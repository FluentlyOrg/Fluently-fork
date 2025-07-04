package handlers

import (
	"encoding/json"
	"net/http"

	"fluently/go-backend/internal/repository/models"
	"fluently/go-backend/internal/repository/postgres"
	"fluently/go-backend/internal/repository/schemas"
	"fluently/go-backend/internal/utils"

	"github.com/google/uuid"
)

type WordHandler struct {
	Repo *postgres.WordRepository
}

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

	return resp
}

// ListWords godoc
// @Summary      Get list of words
// @Description  Returns all words
// @Tags         words
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Success      200  {array}   schemas.WordResponse
// @Failure      500  {object}  schemas.ErrorResponse
// @Router       /api/v1/words/ [get]
func (h *WordHandler) ListWords(w http.ResponseWriter, r *http.Request) {
	words, err := h.Repo.ListWords(r.Context())
	if err != nil {
		http.Error(w, "failed to fetch words", http.StatusInternalServerError)
		return
	}

	var resp []schemas.WordResponse
	for _, word := range words {
		resp = append(resp, buildWordResponse(&word))
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

// GetWord godoc
// @Summary      Get word by ID
// @Description  Returns a word by its unique identifier
// @Tags         words
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id   path      string  true  "Word ID"
// @Success      200  {object}  schemas.WordResponse
// @Failure      400  {object}  schemas.ErrorResponse
// @Failure      404  {object}  schemas.ErrorResponse
// @Router       /api/v1/words/{id} [get]
func (h *WordHandler) GetWord(w http.ResponseWriter, r *http.Request) {
	id, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		http.Error(w, "invalid id", http.StatusBadRequest)
		return
	}

	word, err := h.Repo.GetByID(r.Context(), id)
	if err != nil {
		http.Error(w, "word not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(buildWordResponse(word))
}

// CreateWord godoc
// @Summary      Create a new word
// @Description  Adds a new word
// @Tags         words
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        word  body      schemas.CreateWordRequest  true  "Word data"
// @Success      201  {object}  schemas.WordResponse
// @Failure      400  {object}  schemas.ErrorResponse
// @Failure      500  {object}  schemas.ErrorResponse
// @Router       /api/v1/words/ [post]
func (h *WordHandler) CreateWord(w http.ResponseWriter, r *http.Request) {
	var req schemas.CreateWordRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
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

	if err := h.Repo.Create(r.Context(), &word); err != nil {
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
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(resp)
}

// UpdateWord godoc
// @Summary      Update a word
// @Description  Updates an existing word by ID
// @Tags         words
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id    path      string                   true  "Word ID"
// @Param        word  body      schemas.CreateWordRequest  true  "Word data"
// @Success      200  {object}  schemas.WordResponse
// @Failure      400  {object}  schemas.ErrorResponse
// @Failure      404  {object}  schemas.ErrorResponse
// @Failure      500  {object}  schemas.ErrorResponse
// @Router       /api/v1/words/{id} [put]
func (h *WordHandler) UpdateWord(w http.ResponseWriter, r *http.Request) {
	id, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		http.Error(w, "invalid id", http.StatusBadRequest)
		return
	}

	var req schemas.CreateWordRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "invalid request body", http.StatusBadRequest)
		return
	}

	word, err := h.Repo.GetByID(r.Context(), id)
	if err != nil {
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

	if err := h.Repo.Update(r.Context(), word); err != nil {
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
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

// DeleteWord godoc
// @Summary      Delete a word
// @Description  Deletes a word by ID
// @Tags         words
// @Accept       json
// @Produce      json
// @Security     BearerAuth
// @Param        id   path      string  true  "Word ID"
// @Success      204  ""
// @Failure      400  {object}  schemas.ErrorResponse
// @Failure      404  {object}  schemas.ErrorResponse
// @Failure      500  {object}  schemas.ErrorResponse
// @Router       /api/v1/words/{id} [delete]
func (h *WordHandler) DeleteWord(w http.ResponseWriter, r *http.Request) {
	id, err := utils.ParseUUIDParam(r, "id")
	if err != nil {
		http.Error(w, "invalid id", http.StatusBadRequest)
		return
	}

	if err := h.Repo.Delete(r.Context(), id); err != nil {
		http.Error(w, "failed to delete word", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
