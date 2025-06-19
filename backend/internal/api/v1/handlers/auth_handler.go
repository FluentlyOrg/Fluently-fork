package handlers

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"time"

	"fluently/go-backend/internal/config"
	"fluently/go-backend/internal/repository/models"
	"fluently/go-backend/internal/repository/postgres"
	"fluently/go-backend/pkg/logger"

	"fluently/go-backend/internal/repository/schemas"
	"fluently/go-backend/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"google.golang.org/api/idtoken"
	"gorm.io/gorm"
)

// Handlers combines multiple repositories needed for authentication
type Handlers struct {
	UserRepo         *postgres.UserRepository
	UserPrefRepo     *postgres.PreferenceRepository
	RefreshTokenRepo *postgres.RefreshTokenRepository
}

// GoogleAuthHandler godoc
// @Summary      Authenticates with Google
// @Description  Authenticates with Google using the authorization code flow
// @Tags         auth
// @Accept       json
// @Produce      json
// @Param        code query     string  true  "Authorization code"
// @Success      200  {object}  schemas.JwtResponse
// @Failure      400  {object}  schemas.ErrorResponse
// @Failure      401  {object}  schemas.ErrorResponse
// @Failure      500  {object}  schemas.ErrorResponse
// @Router       /auth/google [get]
func (h *Handlers) GoogleAuthHandler(w http.ResponseWriter, r *http.Request) {
	// Getting idtoken and platform (for audience) from request
	var req struct {
		IDToken  string `json:"id_token"`
		Platform string `json:"platform"`
	}

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		logger.Log.Error("Invalid request", zap.Error(err))
		http.Error(w, "invalid request", http.StatusBadRequest)
		return
	}

	googleToken := req.IDToken
	platform := req.Platform

	cfg := config.GetConfig()
	var googleClientIDs = map[string]string{
		"ios":     fmt.Sprintf("%s.apps.googleusercontent.com", cfg.Google.IosClientID),
		"android": fmt.Sprintf("%s.apps.googleusercontent.com", cfg.Google.AndroidClientID),
		"web":     cfg.Google.WebClientID,
	}

	audience := googleClientIDs[platform]

	payload, err := idtoken.Validate(r.Context(), googleToken, audience)
	if err != nil {
		logger.Log.Error("Invalid token", zap.Error(err))
		http.Error(w, "invalid token", http.StatusUnauthorized)
		return
	}

	// Process claims
	claims := payload.Claims
	sub := claims["sub"].(string)
	email := claims["email"].(string)
	emailVerified := claims["email_verified"].(bool)
	name := claims["name"].(string)
	avatar := claims["picture"].(string)

	// Check if email is verified
	if !emailVerified {
		logger.Log.Error("Email not verified", zap.String("email", email))
		http.Error(w, "email not verified", http.StatusBadRequest)
		return
	}

	// Check if user exists
	user, err := h.UserRepo.GetByEmail(r.Context(), email)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			// Firstly creating user preferences
			userID := uuid.New()
			prefID := uuid.New()
			userPreferences := models.Preference{
				ID:              prefID,
				Subscribed:      false,
				CEFRLevel:       0,
				FactEveryday:    false,
				Notifications:   true,
				NotificationsAt: nil,
				WordsPerDay:     10,
				Goal:            "Learn new words",
				AvatarImage:     []byte(avatar),
			}
			if err := h.UserPrefRepo.Create(r.Context(), &userPreferences); err != nil {
				logger.Log.Error("Failed to create user preferences", zap.Error(err))
				http.Error(w, "failed to create user preferences", http.StatusInternalServerError)
				return
			}

			logger.Log.Info("Creating new user with email: ", zap.String("email", email))
			newUser := &models.User{
				ID:           userID,
				Name:         name,
				Email:        email,
				PasswordHash: "",
				Provider:     "google",
				GoogleID:     sub,
				Role:         "user",
				IsActive:     true,
				PrefID:       &prefID,
				LastLoginAt:  time.Now(),
			}

			if err := h.UserRepo.Create(r.Context(), newUser); err != nil {
				logger.Log.Error("Failed to create user", zap.Error(err))
				http.Error(w, "failed to create user", http.StatusInternalServerError)
				return
			}
			user = newUser
		} else {
			logger.Log.Error("Failed to get user", zap.Error(err))
			http.Error(w, "failed to get user", http.StatusInternalServerError)
			return
		}
	} else {
		// Update last login time for existing user
		if err := h.UserRepo.UpdateLastLogin(r.Context(), user.ID); err != nil {
			logger.Log.Error("Failed to update last login time", zap.Error(err))
		}
	}

	// Generate JWT token
	tokenString, err := utils.GenerateJWT(user)
	if err != nil {
		logger.Log.Error("Failed to generate JWT", zap.Error(err))
		http.Error(w, "failed to generate token", http.StatusInternalServerError)
		return
	}

	// Generate refresh token
	refreshToken, err := utils.GenerateRefreshToken()
	if err != nil {
		logger.Log.Error("Failed to generate refresh token", zap.Error(err))
		http.Error(w, "failed to generate refresh token", http.StatusInternalServerError)
		return
	}

	refreshTokenModel := &models.RefreshToken{
		ID:        uuid.New(),
		UserID:    user.ID,
		Token:     refreshToken,
		ExpiresAt: time.Now().Add(30 * 24 * time.Hour),
	}
	if err := h.RefreshTokenRepo.Create(r.Context(), refreshTokenModel); err != nil {
		logger.Log.Error("Failed to store refresh token", zap.Error(err))
		http.Error(w, "failed to store refresh token", http.StatusInternalServerError)
		return
	}

	resp := schemas.JwtResponse{
		AccessToken:  tokenString,
		RefreshToken: refreshToken,
		TokenType:    "Bearer",
		ExpiresIn:    int64(config.GetConfig().Auth.JWTExpiration.Seconds()),
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(resp)
}

// LoginHandler godoc
// @Summary      Login with email & password
// @Description  Authenticates user and returns JWT
// @Tags         auth
// @Accept       json
// @Produce      json
// @Param        credentials  body      schemas.LoginRequest  true  "Email & Password"
// @Success      200  {object}  schemas.JwtResponse
// @Failure      400  {object}  schemas.ErrorResponse
// @Failure      401  {object}  schemas.ErrorResponse
// @Failure      500  {object}  schemas.ErrorResponse
// @Router       /auth/login [post]
func (h *Handlers) LoginHandler(w http.ResponseWriter, r *http.Request) {
	var req schemas.LoginRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "invalid request", http.StatusBadRequest)
		return
	}

	user, err := h.UserRepo.GetByEmail(r.Context(), req.Email)
	if err != nil {
		logger.Log.Error("User not found", zap.Error(err))
		http.Error(w, "invalid credentials", http.StatusUnauthorized)
		return
	}

	if !utils.CheckPasswordHash(req.Password, user.PasswordHash) {
		http.Error(w, "invalid credentials", http.StatusUnauthorized)
		return
	}

	token, err := utils.GenerateJWT(user)
	if err != nil {
		logger.Log.Error("Failed to generate JWT", zap.Error(err))
		http.Error(w, "failed to generate token", http.StatusInternalServerError)
		return
	}

	refreshToken, err := utils.GenerateRefreshToken()
	if err != nil {
		logger.Log.Error("Failed to generate refresh token", zap.Error(err))
		http.Error(w, "failed to generate refresh token", http.StatusInternalServerError)
		return
	}

	refreshTokenModel := &models.RefreshToken{
		ID:        uuid.New(),
		UserID:    user.ID,
		Token:     refreshToken,
		ExpiresAt: time.Now().Add(30 * 24 * time.Hour),
	}
	if err := h.RefreshTokenRepo.Create(r.Context(), refreshTokenModel); err != nil {
		logger.Log.Error("Failed to store refresh token", zap.Error(err))
		http.Error(w, "failed to store refresh token", http.StatusInternalServerError)
		return
	}

	resp := schemas.JwtResponse{
		AccessToken:  token,
		RefreshToken: refreshToken,
		TokenType:    "Bearer",
		ExpiresIn:    int64(config.GetConfig().Auth.JWTExpiration.Seconds()),
	}

	json.NewEncoder(w).Encode(resp)
}

// RegisterHandler godoc
// @Summary      Register with email & password
// @Description  Creates a user, hashes password, returns JWT
// @Tags         auth
// @Accept       json
// @Produce      json
// @Param        user  body      schemas.RegisterRequest  true  "Registration data"
// @Success      201  {object}  schemas.JwtResponse
// @Failure      400  {object}  schemas.ErrorResponse
// @Failure      409  {object}  schemas.ErrorResponse
// @Failure      500  {object}  schemas.ErrorResponse
// @Router       /auth/register [post]
func (h *Handlers) RegisterHandler(w http.ResponseWriter, r *http.Request) {
	var req schemas.RegisterRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "invalid request", http.StatusBadRequest)
		return
	}

	// Check if user already exists
	if _, err := h.UserRepo.GetByEmail(r.Context(), req.Email); err == nil {
		http.Error(w, "user already exists", http.StatusConflict)
		return
	}

	hash, err := utils.HashPassword(req.Password)
	if err != nil {
		logger.Log.Error("Failed to hash password", zap.Error(err))
		http.Error(w, "internal error", http.StatusInternalServerError)
		return
	}

	user := &models.User{
		ID:           uuid.New(),
		Name:         req.Name,
		Email:        req.Email,
		PasswordHash: hash,
		Provider:     "password",
		Role:         "user",
		IsActive:     true,
		LastLoginAt:  time.Now(),
	}

	if err := h.UserRepo.Create(r.Context(), user); err != nil {
		logger.Log.Error("Failed to create user", zap.Error(err))
		http.Error(w, "failed to create user", http.StatusInternalServerError)
		return
	}

	token, err := utils.GenerateJWT(user)
	if err != nil {
		logger.Log.Error("Failed to generate JWT", zap.Error(err))
		http.Error(w, "failed to generate token", http.StatusInternalServerError)
		return
	}

	refreshToken, err := utils.GenerateRefreshToken()
	if err != nil {
		logger.Log.Error("Failed to generate refresh token", zap.Error(err))
		http.Error(w, "failed to generate refresh token", http.StatusInternalServerError)
		return
	}

	refreshTokenModel := &models.RefreshToken{
		ID:        uuid.New(),
		UserID:    user.ID,
		Token:     refreshToken,
		ExpiresAt: time.Now().Add(30 * 24 * time.Hour),
	}
	if err := h.RefreshTokenRepo.Create(r.Context(), refreshTokenModel); err != nil {
		logger.Log.Error("Failed to store refresh token", zap.Error(err))
		http.Error(w, "failed to store refresh token", http.StatusInternalServerError)
		return
	}

	resp := schemas.JwtResponse{
		AccessToken:  token,
		RefreshToken: refreshToken,
		TokenType:    "Bearer",
		ExpiresIn:    int64(config.GetConfig().Auth.JWTExpiration.Seconds()),
	}

	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(resp)
}

// RefreshTokenHandler godoc
// @Summary      Refresh access token
// @Description  Rotates refresh token and returns new access and refresh tokens
// @Tags         auth
// @Accept       json
// @Produce      json
// @Param        refreshToken body object true "Refresh Token"
// @Success      200  {object}  schemas.JwtResponse
// @Failure      400  {object}  schemas.ErrorResponse
// @Failure      401  {object}  schemas.ErrorResponse
// @Failure      500  {object}  schemas.ErrorResponse
// @Router       /auth/refresh [post]
func (h *Handlers) RefreshTokenHandler(w http.ResponseWriter, r *http.Request) {
	var req struct {
		RefreshToken string `json:"refresh_token"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "invalid request", http.StatusBadRequest)
		return
	}

	rt, err := h.RefreshTokenRepo.GetByToken(r.Context(), req.RefreshToken)
	if err != nil || rt.Revoked || rt.ExpiresAt.Before(time.Now()) {
		http.Error(w, "invalid refresh token", http.StatusUnauthorized)
		return
	}

	user, err := h.UserRepo.GetByID(r.Context(), rt.UserID)
	if err != nil {
		http.Error(w, "user not found", http.StatusUnauthorized)
		return
	}

	// revoke old refresh token
	if err := h.RefreshTokenRepo.Revoke(r.Context(), rt.ID); err != nil {
		http.Error(w, "could not revoke token", http.StatusInternalServerError)
		return
	}

	// issue new tokens
	accessToken, err := utils.GenerateJWT(user)
	if err != nil {
		http.Error(w, "could not generate access token", http.StatusInternalServerError)
		return
	}

	newRefreshToken, err := utils.GenerateRefreshToken()
	if err != nil {
		http.Error(w, "could not generate refresh token", http.StatusInternalServerError)
		return
	}

	refreshTokenModel := &models.RefreshToken{
		ID:        uuid.New(),
		UserID:    user.ID,
		Token:     newRefreshToken,
		ExpiresAt: time.Now().Add(30 * 24 * time.Hour),
	}
	if err := h.RefreshTokenRepo.Create(r.Context(), refreshTokenModel); err != nil {
		http.Error(w, "could not save refresh token", http.StatusInternalServerError)
		return
	}

	resp := schemas.JwtResponse{
		AccessToken:  accessToken,
		RefreshToken: newRefreshToken,
		TokenType:    "Bearer",
		ExpiresIn:    int64(config.GetConfig().Auth.JWTExpiration.Seconds()),
	}

	json.NewEncoder(w).Encode(resp)
}
