// Package handlers provides handlers for the API endpoints.
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

	"github.com/google/uuid"
)

// swagger:ignore
var _ schemas.ErrorResponse

// WordHandler handles the word endpoint
type WordHandler struct {
	Repo *postgres.WordRepository
}

// buildWordResponse builds a WordResponse from a Word
func buildWordResponse(w *models.Word) schemas.WordResponse {
	resp := schemas.WordResponse{
		ID:           w.ID.String(),
		Word:         w.Word,
		CEFRLevel:    w.CEFRLevel,
		PartOfSpeech: w.PartOfSpeech,
	}

	if w.Translation != "" {
		resp.Translation = &w.Translation
	}

	if w.Context != "" {
		resp.Context = &w.Context
	}

	if w.AudioURL != "" {
		resp.AudioURL = &w.AudioURL
	}

	if w.Phonetic != "" {
		resp.Phonetic = &w.Phonetic
	}

	if w.TopicID != nil {
		topicID, err := uuid.Parse(w.TopicID.String())
		if err != nil {
			resp.TopicID = nil
		} else {
			topicIDString := topicID.String()
			resp.TopicID = &topicIDString
		}
	}

	return resp
}

// ListWords lists all words
func (h *WordHandler) ListWords(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/words"
	method := r.Method
	statusCode := 200
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()
	words, err := h.Repo.ListWords(r.Context())
	if err != nil {
		statusCode = 500
		http.Error(w, "failed to fetch words", http.StatusInternalServerError)
		return
	}

	var resp []schemas.WordResponse
	for _, word := range words {
		resp = append(resp, buildWordResponse(&word))
	}

	// Return the list of words
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

// GetWord gets a word
func (h *WordHandler) GetWord(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/words/{id}"
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

	word, err := h.Repo.GetByID(r.Context(), id)
	if err != nil {
		statusCode = 404
		http.Error(w, "word not found", http.StatusNotFound)
		return
	}

	// Return the word
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(buildWordResponse(word))
}

// CreateWord creates a new word
func (h *WordHandler) CreateWord(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/words"
	method := r.Method
	statusCode := 201
	defer func() {
		httpRequestsTotal.WithLabelValues(method, endpoint, strconv.Itoa(statusCode)).Inc()
		httpRequestDuration.WithLabelValues(method, endpoint).Observe(time.Since(start).Seconds())
	}()
	var req schemas.CreateWordRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		statusCode = 400
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	word := models.Word{
		ID:           uuid.New(),
		Word:         req.Word,
		CEFRLevel:    req.CEFRLevel,
		PartOfSpeech: req.PartOfSpeech,
	}

	if req.Translation != nil {
		word.Translation = *req.Translation
	}

	if req.Context != nil {
		word.Context = *req.Context
	}

	if req.AudioURL != nil {
		word.AudioURL = *req.AudioURL
	}

	if req.TopicID != nil {
		topicID, err := uuid.Parse(*req.TopicID)
		if err != nil {
			statusCode = 400
			http.Error(w, "invalid topic id", http.StatusBadRequest)
			return
		}
		word.TopicID = &topicID
	}

	if req.Phonetic != nil {
		word.Phonetic = *req.Phonetic
	}

	if err := h.Repo.Create(r.Context(), &word); err != nil {
		statusCode = 500
		http.Error(w, "failed to create word", http.StatusInternalServerError)
		return
	}

	resp := schemas.WordResponse{
		ID:           word.ID.String(),
		Word:         word.Word,
		CEFRLevel:    word.CEFRLevel,
		PartOfSpeech: word.PartOfSpeech,
		Translation:  req.Translation,
		Context:      req.Context,
		AudioURL:     req.AudioURL,
		TopicID:      req.TopicID,
		Phonetic:     req.Phonetic,
	}

	// Return the created word
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(resp)
}

// UpdateWord updates a word
func (h *WordHandler) UpdateWord(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/words/{id}"
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

	var req schemas.CreateWordRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		statusCode = 400
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	word, err := h.Repo.GetByID(r.Context(), id)
	if err != nil {
		statusCode = 404
		http.Error(w, "word not found", http.StatusNotFound)
		return
	}

	word.Word = req.Word
	word.CEFRLevel = req.CEFRLevel
	word.PartOfSpeech = req.PartOfSpeech

	if req.Translation != nil {
		word.Translation = *req.Translation
	} else {
		word.Translation = ""
	}

	if req.Context != nil {
		word.Context = *req.Context
	} else {
		word.Context = ""
	}

	if req.AudioURL != nil {
		word.AudioURL = *req.AudioURL
	} else {
		word.AudioURL = ""
	}

	if req.TopicID != nil {
		topicID, err := uuid.Parse(*req.TopicID)
		if err != nil {
			statusCode = 400
			http.Error(w, "invalid topic id", http.StatusBadRequest)
			return
		}
		word.TopicID = &topicID
	} else {
		word.TopicID = nil
	}

	if req.Phonetic != nil {
		word.Phonetic = *req.Phonetic
	} else {
		word.Phonetic = ""
	}

	if err := h.Repo.Update(r.Context(), word); err != nil {
		statusCode = 500
		http.Error(w, "failed to update word", http.StatusInternalServerError)
		return
	}

	resp := schemas.WordResponse{
		ID:           word.ID.String(),
		Word:         word.Word,
		CEFRLevel:    word.CEFRLevel,
		PartOfSpeech: word.PartOfSpeech,
		Translation:  req.Translation,
		Context:      req.Context,
		AudioURL:     req.AudioURL,
		TopicID:      req.TopicID,
		Phonetic:     req.Phonetic,
	}

	// Return the updated word
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

// DeleteWord deletes a word
func (h *WordHandler) DeleteWord(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	endpoint := "/api/v1/words/{id}"
	method := r.Method
	statusCode := 204
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

	if err := h.Repo.Delete(r.Context(), id); err != nil {
		statusCode = 500
		http.Error(w, "failed to delete word", http.StatusInternalServerError)
		return
	}

	// Return no content
	w.WriteHeader(http.StatusNoContent)
}
