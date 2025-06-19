package routes

import (
	"fluently/go-backend/internal/api/v1/handlers"

	"github.com/go-chi/chi/v5"
)

func RegisterAuthRoutes(r chi.Router, h *handlers.Handlers) {
	r.Route("/auth", func(r chi.Router) {
		r.Post("/login", h.LoginHandler)
		r.Post("/register", h.RegisterHandler)
		r.Post("/google", h.GoogleAuthHandler)
		r.Post("/refresh", h.RefreshTokenHandler)
		// r.Post("/logout", h.LogoutHandler)
		// r.Post("/forgot-password", h.ForgotPasswordHandler)
		// r.Post("/reset-password", h.ResetPasswordHandler)
	})
}
