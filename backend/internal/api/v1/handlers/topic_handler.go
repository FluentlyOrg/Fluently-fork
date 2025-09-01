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

	"go.uber.org/zap"

	"github.com/google/uuid"
)

// TopicHandler handles the topic endpoint
type TopicHandler struct {
	Repo *postgres.TopicRepository
}

// buildTopicResponse builds a TopicResponse from a Topic
func buildTopicResponse(topic *models.Topic) schemas.TopicResponse {
	return schemas.TopicResponse{
		ID:    topic.ID.String(),
		Title: topic.Title,
	}
}

// sortSubtopicTree recursively sorts subtopics by title for consistent ordering
func sortSubtopicTree(topic *schemas.FullTopicTreeResponse) {
	// Sort current level subtopics
	for i := 0; i < len(topic.Subtopic); i++ {
		for j := i + 1; j < len(topic.Subtopic); j++ {
			if topic.Subtopic[i].Title > topic.Subtopic[j].Title {
				topic.Subtopic[i], topic.Subtopic[j] = topic.Subtopic[j], topic.Subtopic[i]
			}
		}
		// Recursively sort subtopics of subtopics
		sortSubtopicTree(&topic.Subtopic[i])
	}
}

// GetTopic gets a topic
func (h *TopicHandler) GetTopic(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/topics/{id}"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	id, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		statusCode = 400
		http.Error(w, "invalid id", http.StatusBadRequest)
		return
	}

	topic, err := h.Repo.GetByID(r.Context(), id)
	if err != nil {
		statusCode = 404
		http.Error(w, "topic not found", http.StatusNotFound)
		return
	}

	// Return the topic
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(buildTopicResponse(topic))
}

// GetMainTopic gets the main topic
// The main topic is the topic that has no parent
func (h *TopicHandler) GetMainTopic(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/topics/main/{id}"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	id, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		statusCode = 400
		http.Error(w, "invalid id", http.StatusBadRequest)
		return
	}

	topic, err := h.Repo.GetByID(r.Context(), id)
	if err != nil {
		statusCode = 404
		http.Error(w, "topic not found", http.StatusNotFound)
		return
	}

	// Find the main topic (the topic that has no parent)
	for topic.ParentID != nil {
		topic, err = h.Repo.GetByID(r.Context(), *topic.ParentID)
		if err != nil {
			statusCode = 500
			http.Error(w, "failed to fetch parent topic", http.StatusInternalServerError)
			return
		}
	}

	// Return the topic
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(buildTopicResponse(topic))
}

// GetPathToMainTopic gets the path to the main topic
// The path is a list of topics that lead to the main topic
func (h *TopicHandler) GetPathToMainTopic(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/topics/path/{id}"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	id, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		statusCode = 400
		http.Error(w, "invalid id", http.StatusBadRequest)
		return
	}

	var path []uuid.UUID

	topic, err := h.Repo.GetByID(r.Context(), id)
	if err != nil {
		statusCode = 404
		http.Error(w, "topic not found", http.StatusNotFound)
		return
	}
	path = append(path, topic.ID)

	// Find the main topic (the topic that has no parent)
	for topic.ParentID != nil {
		topic, err = h.Repo.GetByID(r.Context(), *topic.ParentID)
		if err != nil {
			statusCode = 500
			http.Error(w, "failed to fetch parent topic", http.StatusInternalServerError)
			return
		}
		path = append(path, topic.ID)
	}

	// Convert the path to a slice of strings
	strPath := make([]string, len(path))
	for i, id := range path {
		strPath[i] = id.String()
	}

	// Return the path
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string][]string{
		"topics": strPath,
	})
}

// CreateTopic creates a new topic
func (h *TopicHandler) CreateTopic(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/topics"
	method := r.Method
	statusCode := 201
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	var req schemas.CreateTopicRequest

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		statusCode = 400
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	topic := models.Topic{
		Title: req.Title,
	}

	if err := h.Repo.Create(r.Context(), &topic); err != nil {
		statusCode = 500
		http.Error(w, "failed to create topic", http.StatusInternalServerError)
		return
	}

	// Return the created topic
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(buildTopicResponse(&topic))
}

// UpdateTopic updates a topic
func (h *TopicHandler) UpdateTopic(w http.ResponseWriter, r *http.Request) {
	id, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		http.Error(w, "invalid id", http.StatusBadRequest)
		return
	}

	var req schemas.CreateTopicRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	topic, err := h.Repo.GetByID(r.Context(), id)
	if err != nil {
		http.Error(w, "topic not found", http.StatusNotFound)
		return
	}

	topic.Title = req.Title

	if err := h.Repo.Update(r.Context(), topic); err != nil {
		http.Error(w, "failed to update topic", http.StatusInternalServerError)
		return
	}

	// Return the updated topic
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(buildTopicResponse(topic))
}

// DeleteTopic deletes a topic
func (h *TopicHandler) DeleteTopic(w http.ResponseWriter, r *http.Request) {
	id, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		http.Error(w, "invalid id", http.StatusBadRequest)
		return
	}

	if err := h.Repo.Delete(r.Context(), id); err != nil {
		http.Error(w, "failed to delete topic", http.StatusInternalServerError)
		return
	}

	// Return no content
	w.WriteHeader(http.StatusNoContent)
}

// GetTopics returns all topics that start with a capital letter
// GetTopics возвращает список тем, которые начинаются с заглавной буквы
// @Summary Получить список тем
// @Description Возвращает все темы, которые начинаются с заглавной буквы (только названия)
// @Tags topics
// @Produce json
// @Success 200 {array} schemas.TopicTitleResponse
// @Failure 500 {object} schemas.ErrorResponse
// @Security BearerAuth
// @Router /api/v1/topics [get]
func (h *TopicHandler) GetTopics(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/topics"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	// Fetch all topics that start with a capital letter from the repository
	topics, err := h.Repo.GetAllStartingWithCapital(r.Context())
	if err != nil {
		statusCode = 500
		http.Error(w, "failed to fetch topics", http.StatusInternalServerError)
		return
	}

	// Build response with only titles
	var resp []schemas.TopicTitleResponse
	for _, topic := range topics {
		resp = append(resp, schemas.TopicTitleResponse{
			Title: topic.Title,
		})
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(resp)
}

// GetFullTopicsTrees returns all topics in a tree structure
func (h *TopicHandler) GetFullTopicsTrees(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/topics/full-trees"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()

	topics, err := h.Repo.GetAll(r.Context())
	if err != nil {
		statusCode = 500
		// Log the actual error for debugging
		logger.Log.Error("Error fetching topics", zap.Error(err))
		http.Error(w, "failed to fetch topics", http.StatusInternalServerError)
		return
	}

	// Log the number of topics found for debugging
	logger.Log.Info("Found topics", zap.Int("count", len(topics)))

	// Build tree structure using recursive approach
	topicMap := make(map[uuid.UUID]*models.Topic)
	for _, topic := range topics {
		topicMap[topic.ID] = &topic
	}

	// Build the tree recursively
	var buildTree func(topicID uuid.UUID) *schemas.FullTopicTreeResponse
	buildTree = func(topicID uuid.UUID) *schemas.FullTopicTreeResponse {
		topic := topicMap[topicID]
		if topic == nil {
			return nil
		}

		node := &schemas.FullTopicTreeResponse{
			ID:       topic.ID.String(),
			Title:    topic.Title,
			Subtopic: []schemas.FullTopicTreeResponse{},
		}

		// Find all children of this topic
		for _, t := range topics {
			if t.ParentID != nil && *t.ParentID == topicID {
				childNode := buildTree(t.ID)
				if childNode != nil {
					node.Subtopic = append(node.Subtopic, *childNode)
				}
			}
		}

		return node
	}

	// Find root topics and build their trees
	var fullTopicTrees []schemas.FullTopicTreeResponse
	for _, topic := range topics {
		if topic.ParentID == nil {
			rootTree := buildTree(topic.ID)
			if rootTree != nil {
				fullTopicTrees = append(fullTopicTrees, *rootTree)
			}
		}
	}

	// Debug: Log the structure to see what's happening
	logger.Log.Info("Topic tree structure", zap.Any("fullTopicTrees", fullTopicTrees))

	// Sort subtopics to ensure consistent ordering
	for i := range fullTopicTrees {
		sortSubtopicTree(&fullTopicTrees[i])
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(fullTopicTrees)
}
