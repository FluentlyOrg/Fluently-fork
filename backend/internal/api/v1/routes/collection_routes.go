package routes

import (
	handler "fluently/go-backend/internal/api/v1/handlers"

	"github.com/go-chi/chi/v5"
)

// RegisterCollectionRoutes registers collection routes
func RegisterCollectionRoutes(r chi.Router, ch *handler.CollectionHandler, fh *handler.CollectionFavoriteHandler) {
	r.Route("/collections", func(r chi.Router) {
		r.Get("/", ch.ListCollections)
		r.Get("/{id}", ch.GetCollection)
		r.Post("/", ch.CreateCollection)
		r.Put("/{id}", ch.UpdateCollection)
		r.Delete("/{id}", ch.DeleteCollection)

		// Favorite routes
		r.Route("/favorites", func(r chi.Router) {
			r.Get("/", fh.GetUserFavorites)
			r.Post("/", fh.AddToFavorites)
			r.Delete("/", fh.RemoveFromFavorites)
		})

		// Check favorite status for specific collection
		r.Get("/{collection_id}/favorite", fh.CheckFavoriteStatus)
	})
}
