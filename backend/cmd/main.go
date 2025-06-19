package main

import (
	"net/http"

	_ "fluently/go-backend/docs"
	appConfig "fluently/go-backend/internal/config"
	"fluently/go-backend/internal/repository/models"
	"fluently/go-backend/internal/router"
	"fluently/go-backend/pkg/logger"

	"github.com/go-chi/chi/v5"
	httpSwagger "github.com/swaggo/http-swagger"
	"go.uber.org/zap"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// @title           Fluently API
// @version         1.0
// @description     Backend API for Fluently
// @termsOfService  http://fluently-app.ru/terms/

// @contact.name   Danila Kochegarov
// @contact.url    http://fluently-app.ru
// @contact.email  Woolfer0097@yandex.ru

// @license.name  MIT
// @license.url   https://opensource.org/licenses/MIT

// @host      fluently-app.ru/swagger/index.html
// @BasePath  /api/v1
func main() {
	appConfig.Init()
	logger.Init(true) // or false for production
	defer logger.Log.Sync()

	// Router init
	r := chi.NewRouter()

	// Database init
	dsn := appConfig.GetPostgresDSN()
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		logger.Log.Fatal("Failed to connect to database", zap.Error(err))
	}

	err = db.AutoMigrate(
		&models.LearnedWords{},
		&models.Preference{},
		&models.Sentence{},
		&models.User{},
		&models.RefreshToken{},
		&models.Word{},
		&models.PickOption{},
		&models.Topic{},
	)
	if err != nil {
		logger.Log.Fatal("Failed to auto-migrate", zap.Error(err))
	}

	router.InitRoutes(db)

	r.Get("/swagger/*", httpSwagger.WrapHandler) // Swagger UI

	r.Get("/api/v1/ping", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("pong"))
	})

	logger.Log.Info("Logger initialization successful!")
	logger.Log.Info("App starting",
		zap.String("name", appConfig.GetConfig().API.AppName),
		zap.String("address", appConfig.GetConfig().API.AppHost+":"+appConfig.GetConfig().API.AppPort),
		zap.String("dsn", appConfig.GetPostgresDSN()),
	)

	err = http.ListenAndServe(appConfig.GetConfig().API.AppHost+":"+appConfig.GetConfig().API.AppPort, r)
	if err != nil {
		logger.Log.Fatal("App failed to start", zap.Error(err))
	}
}
