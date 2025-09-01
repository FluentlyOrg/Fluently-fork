package handlers

import (
	"encoding/json"
	"net/http"
	"strconv"
	"time"

	"fluently/go-backend/internal/repository/models"
	"fluently/go-backend/internal/repository/postgres"
	"fluently/go-backend/internal/repository/schemas"
	"fluently/go-backend/internal/utils"
	"fluently/go-backend/pkg/logger"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

// CollectionFavoriteHandler handles collection favorite operations
type CollectionFavoriteHandler struct {
	FavoriteRepo   *postgres.UserCollectionFavoriteRepository
	CollectionRepo *postgres.CollectionRepository
}

// NewCollectionFavoriteHandler creates a new CollectionFavoriteHandler
func NewCollectionFavoriteHandler(favoriteRepo *postgres.UserCollectionFavoriteRepository, collectionRepo *postgres.CollectionRepository) *CollectionFavoriteHandler {
	return &CollectionFavoriteHandler{
		FavoriteRepo:   favoriteRepo,
		CollectionRepo: collectionRepo,
	}
}

// AddToFavorites adds a collection to user's favorites
// @Summary Add collection to favorites
// @Description Adds a collection to the current user's favorites
// @Tags Collections
// @Accept json
// @Produce json
// @Security BearerAuth
// @Param request body schemas.AddToFavoritesRequest true "Collection ID"
// @Success 200 {object} schemas.SuccessResponse
// @Failure 400 {object} schemas.ErrorResponse
// @Failure 401 {object} schemas.ErrorResponse
// @Failure 404 {object} schemas.ErrorResponse
// @Failure 409 {object} schemas.ErrorResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Router /api/v1/collections/favorites [post]
func (h *CollectionFavoriteHandler) AddToFavorites(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/collections/favorites"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	// Get current user
	user, err := utils.GetCurrentUser(r.Context())
	if err != nil {
		statusCode = 401
		http.Error(w, "unauthorized", http.StatusUnauthorized)
		return
	}

	// Parse request
	var req schemas.AddToFavoritesRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		statusCode = 400
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	// Validate collection ID
	collectionID, err := uuid.Parse(req.CollectionID)
	if err != nil {
		statusCode = 400
		http.Error(w, "invalid collection_id", http.StatusBadRequest)
		return
	}

	// Check if collection exists
	_, err = h.CollectionRepo.GetByID(r.Context(), collectionID)
	if err != nil {
		statusCode = 404
		http.Error(w, "collection not found", http.StatusNotFound)
		return
	}

	// Add to favorites
	err = h.FavoriteRepo.Create(r.Context(), user.ID, collectionID)
	if err != nil {
		if err.Error() == "collection already in favorites" {
			statusCode = 409
			http.Error(w, err.Error(), http.StatusConflict)
		} else {
			statusCode = 500
			logger.Log.Error("failed to add collection to favorites", zap.Error(err))
			http.Error(w, "internal server error", http.StatusInternalServerError)
		}
		return
	}

	// Return success response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(schemas.SuccessResponse{
		Message: "Collection added to favorites successfully",
	})
}

// RemoveFromFavorites removes a collection from user's favorites
// @Summary Remove collection from favorites
// @Description Removes a collection from the current user's favorites
// @Tags Collections
// @Accept json
// @Produce json
// @Security BearerAuth
// @Param request body schemas.RemoveFromFavoritesRequest true "Collection ID"
// @Success 200 {object} schemas.SuccessResponse
// @Failure 400 {object} schemas.ErrorResponse
// @Failure 401 {object} schemas.ErrorResponse
// @Failure 404 {object} schemas.ErrorResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Router /api/v1/collections/favorites [delete]
func (h *CollectionFavoriteHandler) RemoveFromFavorites(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/collections/favorites"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	// Get current user
	user, err := utils.GetCurrentUser(r.Context())
	if err != nil {
		statusCode = 401
		http.Error(w, "unauthorized", http.StatusUnauthorized)
		return
	}

	// Parse request
	var req schemas.RemoveFromFavoritesRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		statusCode = 400
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	// Validate collection ID
	collectionID, err := uuid.Parse(req.CollectionID)
	if err != nil {
		statusCode = 400
		http.Error(w, "invalid collection_id", http.StatusBadRequest)
		return
	}

	// Remove from favorites
	err = h.FavoriteRepo.Delete(r.Context(), user.ID, collectionID)
	if err != nil {
		if err.Error() == "collection not in favorites" {
			statusCode = 404
			http.Error(w, err.Error(), http.StatusNotFound)
		} else {
			statusCode = 500
			logger.Log.Error("failed to remove collection from favorites", zap.Error(err))
			http.Error(w, "internal server error", http.StatusInternalServerError)
		}
		return
	}

	// Return success response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(schemas.SuccessResponse{
		Message: "Collection removed from favorites successfully",
	})
}

// GetUserFavorites returns all favorite collections for the current user
// @Summary Get user's favorite collections
// @Description Returns all collections that the current user has favorited
// @Tags Collections
// @Produce json
// @Security BearerAuth
// @Param limit query int false "Number of items to return (default: 10, max: 100)"
// @Param offset query int false "Number of items to skip (default: 0)"
// @Success 200 {object} schemas.FavoriteCollectionsListResponse
// @Failure 401 {object} schemas.ErrorResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Router /api/v1/collections/favorites [get]
func (h *CollectionFavoriteHandler) GetUserFavorites(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/collections/favorites"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	// Get current user
	user, err := utils.GetCurrentUser(r.Context())
	if err != nil {
		statusCode = 401
		http.Error(w, "unauthorized", http.StatusUnauthorized)
		return
	}

	// Parse query parameters
	limit := 10
	if limitStr := r.URL.Query().Get("limit"); limitStr != "" {
		if l, err := strconv.Atoi(limitStr); err == nil && l > 0 && l <= 100 {
			limit = l
		}
	}
	offset := 0
	if offsetStr := r.URL.Query().Get("offset"); offsetStr != "" {
		if o, err := strconv.Atoi(offsetStr); err == nil && o >= 0 {
			offset = o
		}
	}

	// Get favorites
	favorites, err := h.FavoriteRepo.GetUserFavorites(r.Context(), user.ID, limit, offset)
	if err != nil {
		statusCode = 500
		logger.Log.Error("failed to get user favorites", zap.Error(err))
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	// Get total count
	total, err := h.FavoriteRepo.GetUserFavoritesCount(r.Context(), user.ID)
	if err != nil {
		statusCode = 500
		logger.Log.Error("failed to get user favorites count", zap.Error(err))
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	// Build response
	var response schemas.FavoriteCollectionsListResponse
	for _, favorite := range favorites {
		collectionResp := buildCollectionResponse(&favorite.Collection)
		favoriteResp := schemas.FavoriteCollectionResponse{
			CollectionResponse: collectionResp,
			FavoritedAt:        favorite.CreatedAt.Format(time.RFC3339),
		}
		response.Collections = append(response.Collections, favoriteResp)
	}
	response.Total = total

	// Return response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

// CheckFavoriteStatus checks if a collection is in user's favorites
// @Summary Check if collection is favorited
// @Description Checks if the current user has favorited a specific collection
// @Tags Collections
// @Produce json
// @Security BearerAuth
// @Param collection_id path string true "Collection ID"
// @Success 200 {object} schemas.FavoriteStatusResponse
// @Failure 400 {object} schemas.ErrorResponse
// @Failure 401 {object} schemas.ErrorResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Router /api/v1/collections/{collection_id}/favorite [get]
func (h *CollectionFavoriteHandler) CheckFavoriteStatus(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/collections/{collection_id}/favorite"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	// Get current user
	user, err := utils.GetCurrentUser(r.Context())
	if err != nil {
		statusCode = 401
		http.Error(w, "unauthorized", http.StatusUnauthorized)
		return
	}

	// Parse collection ID from URL
	collectionID, err := utils.ParseUUIDParam(r, "collection_id")
	if err != nil {
		statusCode = 400
		http.Error(w, "invalid collection_id", http.StatusBadRequest)
		return
	}

	// Check favorite status
	isFavorite, err := h.FavoriteRepo.IsFavorite(r.Context(), user.ID, collectionID)
	if err != nil {
		statusCode = 500
		logger.Log.Error("failed to check favorite status", zap.Error(err))
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	// Return response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(schemas.FavoriteStatusResponse{
		IsFavorite: isFavorite,
	})
}

// buildCollectionResponse builds a CollectionResponse from a Collection model
func buildCollectionResponse(collection *models.Collection) schemas.CollectionResponse {
	structure, _ := collection.GetCollectionStructure()

	// Convert models.CollectionStructure to schemas.CollectionStructure
	schemaStructure := schemas.CollectionStructure{
		Topics:    make(map[string]schemas.TopicStructure),
		Unrelated: structure.Unrelated,
	}

	for topicName, topic := range structure.Topics {
		schemaTopic := schemas.TopicStructure{
			Subtopics: make(map[string]schemas.SubtopicStructure),
		}
		for subtopicName, subtopic := range topic.Subtopics {
			schemaSubtopic := schemas.SubtopicStructure{
				Subsubtopics: make(map[string][]uuid.UUID),
			}
			for subsubtopicName, wordUUIDs := range subtopic.Subsubtopics {
				schemaSubtopic.Subsubtopics[subsubtopicName] = wordUUIDs
			}
			schemaTopic.Subtopics[subtopicName] = schemaSubtopic
		}
		schemaStructure.Topics[topicName] = schemaTopic
	}

	return schemas.CollectionResponse{
		ID:          collection.ID.String(),
		Title:       collection.Title,
		Description: collection.Description,
		IconUrl:     collection.IconUrl,
		WordCount:   collection.WordCount,
		CreatedAt:   collection.CreatedAt.Format(time.RFC3339),
		UpdatedAt:   collection.UpdatedAt.Format(time.RFC3339),
		Collection:  schemaStructure,
	}
}
