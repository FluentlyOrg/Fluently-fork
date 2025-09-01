package routes

import (
	handler "fluently/go-backend/internal/api/v1/handlers"

	"github.com/go-chi/chi/v5"
)

// RegisterTopicRoutes registers topic routes
func RegisterTopicRoutes(r chi.Router, h *handler.TopicHandler) {
	r.Route("/topics", func(r chi.Router) {
		r.Post("/", h.CreateTopic)
		r.Get("/", h.GetTopics)
		r.Get("/full-trees", h.GetFullTopicsTrees)
		r.Get("/{id}", h.GetTopic)
		r.Get("/root-topic/{id}", h.GetMainTopic)
		r.Get("/path-to-root/{id}", h.GetPathToMainTopic)
		r.Put("/{id}", h.UpdateTopic)
		r.Delete("/{id}", h.DeleteTopic)
	})
}
