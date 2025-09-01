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

// CollectionHandler handles collection operations
type CollectionHandler struct {
	Repo *postgres.CollectionRepository
}

// NewCollectionHandler creates a new CollectionHandler
func NewCollectionHandler(repo *postgres.CollectionRepository) *CollectionHandler {
	return &CollectionHandler{Repo: repo}
}

// ListCollections returns all collections with pagination
// @Summary List collections
// @Description Returns all collections with pagination support
// @Tags Collections
// @Produce json
// @Param limit query int false "Number of items to return (default: 10, max: 100)"
// @Param offset query int false "Number of items to skip (default: 0)"
// @Success 200 {object} schemas.CollectionListResponse
// @Failure 400 {object} schemas.ErrorResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Router /api/v1/collections [get]
func (h *CollectionHandler) ListCollections(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/collections"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

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

	// Get collections
	collections, err := h.Repo.List(r.Context(), limit, offset)
	if err != nil {
		statusCode = 500
		logger.Log.Error("failed to list collections", zap.Error(err))
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	// Get total count
	total, err := h.Repo.Count(r.Context())
	if err != nil {
		statusCode = 500
		logger.Log.Error("failed to get collections count", zap.Error(err))
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	// Build response
	var response schemas.CollectionListResponse
	for _, collection := range collections {
		response.Collections = append(response.Collections, buildCollectionResponse(&collection))
	}
	response.Total = total

	// Return response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

// GetCollection returns a specific collection by ID
// @Summary Get collection
// @Description Returns a specific collection by ID
// @Tags Collections
// @Produce json
// @Param id path string true "Collection ID"
// @Success 200 {object} schemas.CollectionResponse
// @Failure 400 {object} schemas.ErrorResponse
// @Failure 404 {object} schemas.ErrorResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Router /api/v1/collections/{id} [get]
func (h *CollectionHandler) GetCollection(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/collections/{id}"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	// Parse collection ID from URL
	collectionID, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		statusCode = 400
		http.Error(w, "invalid collection id", http.StatusBadRequest)
		return
	}

	// Get collection
	collection, err := h.Repo.GetByID(r.Context(), collectionID)
	if err != nil {
		statusCode = 404
		http.Error(w, "collection not found", http.StatusNotFound)
		return
	}

	// Return response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(buildCollectionResponse(collection))
}

// CreateCollection creates a new collection
// @Summary Create collection
// @Description Creates a new collection
// @Tags Collections
// @Accept json
// @Produce json
// @Security BearerAuth
// @Param request body schemas.CreateCollectionRequest true "Collection data"
// @Success 201 {object} schemas.CollectionResponse
// @Failure 400 {object} schemas.ErrorResponse
// @Failure 401 {object} schemas.ErrorResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Router /api/v1/collections [post]
func (h *CollectionHandler) CreateCollection(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/collections"
	method := r.Method
	statusCode := 201
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	// Get current user (for future use if needed)
	_, err := utils.GetCurrentUser(r.Context())
	if err != nil {
		statusCode = 401
		http.Error(w, "unauthorized", http.StatusUnauthorized)
		return
	}

	// Parse request
	var req schemas.CreateCollectionRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		statusCode = 400
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	// Create collection model
	collection := &models.Collection{
		ID:          uuid.New(),
		Title:       req.Title,
		Description: req.Description,
		IconUrl:     req.IconUrl,
		CreatedAt:   time.Now(),
		UpdatedAt:   time.Now(),
	}

	// Convert schemas.CollectionStructure to models.CollectionStructure
	modelStructure := convertSchemaToModelStructure(&req.Collection)

	// Set collection structure (this will also calculate word count)
	if err := collection.SetCollectionStructure(&modelStructure); err != nil {
		statusCode = 400
		http.Error(w, "invalid collection structure", http.StatusBadRequest)
		return
	}

	// Save to database
	if err := h.Repo.Create(r.Context(), collection); err != nil {
		statusCode = 500
		logger.Log.Error("failed to create collection", zap.Error(err))
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	// Return response
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(buildCollectionResponse(collection))
}

// UpdateCollection updates an existing collection
// @Summary Update collection
// @Description Updates an existing collection
// @Tags Collections
// @Accept json
// @Produce json
// @Security BearerAuth
// @Param id path string true "Collection ID"
// @Param request body schemas.UpdateCollectionRequest true "Collection data"
// @Success 200 {object} schemas.CollectionResponse
// @Failure 400 {object} schemas.ErrorResponse
// @Failure 401 {object} schemas.ErrorResponse
// @Failure 404 {object} schemas.ErrorResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Router /api/v1/collections/{id} [put]
func (h *CollectionHandler) UpdateCollection(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/collections/{id}"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	// Get current user (for future use if needed)
	_, err := utils.GetCurrentUser(r.Context())
	if err != nil {
		statusCode = 401
		http.Error(w, "unauthorized", http.StatusUnauthorized)
		return
	}

	// Parse collection ID from URL
	collectionID, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		statusCode = 400
		http.Error(w, "invalid collection id", http.StatusBadRequest)
		return
	}

	// Get existing collection
	collection, err := h.Repo.GetByID(r.Context(), collectionID)
	if err != nil {
		statusCode = 404
		http.Error(w, "collection not found", http.StatusNotFound)
		return
	}

	// Parse request
	var req schemas.UpdateCollectionRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		statusCode = 400
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	// Update fields if provided
	if req.Title != nil {
		collection.Title = *req.Title
	}
	if req.Description != nil {
		collection.Description = *req.Description
	}
	if req.IconUrl != nil {
		collection.IconUrl = *req.IconUrl
	}
	if req.Collection != nil {
		// Convert schemas.CollectionStructure to models.CollectionStructure
		modelStructure := convertSchemaToModelStructure(req.Collection)

		// Set collection structure (this will also recalculate word count)
		if err := collection.SetCollectionStructure(&modelStructure); err != nil {
			statusCode = 400
			http.Error(w, "invalid collection structure", http.StatusBadRequest)
			return
		}
	}

	collection.UpdatedAt = time.Now()

	// Save to database
	if err := h.Repo.Update(r.Context(), collection); err != nil {
		statusCode = 500
		logger.Log.Error("failed to update collection", zap.Error(err))
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	// Return response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(buildCollectionResponse(collection))
}

// DeleteCollection deletes a collection
// @Summary Delete collection
// @Description Deletes a collection
// @Tags Collections
// @Produce json
// @Security BearerAuth
// @Param id path string true "Collection ID"
// @Success 200 {object} schemas.SuccessResponse
// @Failure 400 {object} schemas.ErrorResponse
// @Failure 401 {object} schemas.ErrorResponse
// @Failure 404 {object} schemas.ErrorResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Router /api/v1/collections/{id} [delete]
func (h *CollectionHandler) DeleteCollection(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/collections/{id}"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	// Get current user (for future use if needed)
	_, err := utils.GetCurrentUser(r.Context())
	if err != nil {
		statusCode = 401
		http.Error(w, "unauthorized", http.StatusUnauthorized)
		return
	}

	// Parse collection ID from URL
	collectionID, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		statusCode = 400
		http.Error(w, "invalid collection id", http.StatusBadRequest)
		return
	}

	// Check if collection exists
	_, err = h.Repo.GetByID(r.Context(), collectionID)
	if err != nil {
		statusCode = 404
		http.Error(w, "collection not found", http.StatusNotFound)
		return
	}

	// Delete collection
	if err := h.Repo.Delete(r.Context(), collectionID); err != nil {
		statusCode = 500
		logger.Log.Error("failed to delete collection", zap.Error(err))
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	// Return success response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(schemas.SuccessResponse{
		Message: "Collection deleted successfully",
	})
}

// convertSchemaToModelStructure converts schemas.CollectionStructure to models.CollectionStructure
func convertSchemaToModelStructure(schemaStructure *schemas.CollectionStructure) models.CollectionStructure {
	modelStructure := models.CollectionStructure{
		Topics:    make(map[string]models.TopicStructure),
		Unrelated: schemaStructure.Unrelated,
	}

	for topicName, topic := range schemaStructure.Topics {
		modelTopic := models.TopicStructure{
			Subtopics: make(map[string]models.SubtopicStructure),
		}
		for subtopicName, subtopic := range topic.Subtopics {
			modelSubtopic := models.SubtopicStructure{
				Subsubtopics: make(map[string][]uuid.UUID),
			}
			for subsubtopicName, wordUUIDs := range subtopic.Subsubtopics {
				modelSubtopic.Subsubtopics[subsubtopicName] = wordUUIDs
			}
			modelTopic.Subtopics[subtopicName] = modelSubtopic
		}
		modelStructure.Topics[topicName] = modelTopic
	}

	return modelStructure
}
