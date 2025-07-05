package handlers

import (
	"encoding/json"
	"math/rand"
	"net/http"
	"time"

	"fluently/go-backend/internal/repository/postgres"
	"fluently/go-backend/internal/repository/schemas"
	"fluently/go-backend/internal/utils"
	"fluently/go-backend/pkg/logger"
	"strings"
	"unicode/utf8"

	"go.uber.org/zap"
)

var exerciseTypes = []string{
	"translate_ru_to_en",
	"write_word_from_translation",
	"pick_option_sentence",
}

type LessonHandler struct {
	PreferenceRepo *postgres.PreferenceRepository
	TopicRepo      *postgres.TopicRepository
	SentenceRepo   *postgres.SentenceRepository
	Repo           *postgres.LessonRepository
}

func replaceWordWithUnderscores(text, word string) string {
	replacement := strings.Repeat("_", utf8.RuneCountInString(word))
	return strings.ReplaceAll(text, word, replacement)
}

// GenerateLesson godoc
// @Summary Generate a new lesson for the user
// @Description Creates a personalized lesson based on user preferences, including words, exercises, and topics
// @Tags lessons
// @Accept json
// @Produce json
// @Security BearerAuth
// @Success 200 {object} schemas.LessonResponse "Successfully generated lesson"
// @Failure 400 {string} string "Bad request - invalid user or preferences"
// @Failure 401 {string} string "Unauthorized - invalid or missing token"
// @Failure 500 {string} string "Internal server error"
// @Router /lesson [get]
func (h *LessonHandler) GenerateLesson(w http.ResponseWriter, r *http.Request) {
	user, err := utils.GetCurrentUser(r.Context())
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	userID := user.ID

	// Lesson info block
	var lessonInfo schemas.LessonInfo

	userPref, err := h.PreferenceRepo.GetByUserID(r.Context(), userID)
	if err != nil {
		http.Error(w, "failed to get preference", http.StatusBadRequest)
		return
	}

	lessonInfo.WordsPerLesson = userPref.WordsPerDay
	lessonInfo.TotalWords = userPref.WordsPerDay * 2
	lessonInfo.CEFRLevel = userPref.CEFRLevel
	lessonInfo.StartedAt = time.Now().UTC().Format(time.RFC3339)

	// Lesson card block
	var cards []schemas.Card

	words, err := h.Repo.GetWordsForLesson(
		r.Context(),
		userID,
		userPref.CEFRLevel,
		lessonInfo.TotalWords,
	)

	if err != nil {
		logger.Log.Error("Failed to get words for lesson", zap.Error(err))
		http.Error(w, "failed to get words for lesson", http.StatusBadRequest)
		return
	}

	for _, word := range words {
		var card schemas.Card

		card.WordID = word.ID
		card.Word = word.Word
		card.Translation = word.Translation

		topic, err := h.TopicRepo.GetByID(r.Context(), *word.TopicID)
		if err != nil {
			http.Error(w, "failed to get topic", http.StatusBadRequest)
			return
		}

		// Topic and subtopic process
		card.Subtopic = topic.Title

		for topic.ParentID != nil {
			topic, err = h.TopicRepo.GetByID(r.Context(), *topic.ParentID)
			if err != nil {
				http.Error(w, "failed to get topic", http.StatusBadRequest)
				return
			}
		}

		card.Topic = topic.Title

		// Sentence process
		sentence, err := h.SentenceRepo.GetByWordID(r.Context(), word.ID)
		if err != nil {
			http.Error(w, "failed to get sentence", http.StatusBadRequest)
			return
		}

		card.Sentences = append(card.Sentences, schemas.Sentence{
			Text:        sentence.Sentence,
			Translation: "Violets are Blue", //TODO: Remove moke in future
		})

		// Exercise process
		option := rand.Intn(3)

		var exercise schemas.Exercise
		exercise.Type = exerciseTypes[option]

		switch option {
		case 0: // translate_ru_to_en
			var translateRuToEn schemas.ExerciseTranslateRuToEn

			translateRuToEn.Text = word.Translation
			translateRuToEn.CorrectAnswer = word.Word
			translateRuToEn.PickOptions, _ = utils.GeneratePickOptionsWithDefaults(r.Context(), sentence.Sentence, word.Word)
			exercise.Data = translateRuToEn
		case 1: // write_word_from_translation
			var writeWordFromTranslation schemas.ExerciseWriteWordFromTranslation

			writeWordFromTranslation.Translation = word.Translation
			writeWordFromTranslation.CorrectAnswer = word.Word
			exercise.Data = writeWordFromTranslation
		case 2: // pick_option_sentence
			var pickOptionSentence schemas.ExercisePickOptionSentence

			pickOptionSentence.Template = replaceWordWithUnderscores(
				sentence.Sentence,
				word.Word,
			)
			pickOptionSentence.CorrectAnswer = word.Word
			pickOptionSentence.PickOptions, _ = utils.GeneratePickOptionsWithDefaults(r.Context(), sentence.Sentence, word.Word)
			exercise.Data = pickOptionSentence
		default:
		}

		card.Exercise = exercise
		cards = append(cards, card)
		logger.Log.Info("Card generated", zap.Any("card", card))
	}

	var lesson schemas.LessonResponse
	lesson.Lesson = lessonInfo
	lesson.Cards = cards
	logger.Log.Info("Lesson generated", zap.Any("lesson", lesson))

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	if err := json.NewEncoder(w).Encode(lesson); err != nil {
		http.Error(w, "failed to encode response", http.StatusInternalServerError)
		return
	}
}
