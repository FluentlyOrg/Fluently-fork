package postgres

import (
	"context"

	"fluently/go-backend/internal/repository/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type LessonRepository struct {
	db *gorm.DB
}

func NewLessonRepository(db *gorm.DB) *LessonRepository {
	return &LessonRepository{db: db}
}

func (r *LessonRepository) Create(ctx context.Context, lesson *models.Lesson, words []uuid.UUID) error {
	return r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		if err := tx.Create(lesson).Error; err != nil {
			return err
		}

		for i, wordID := range words {
			card := models.LessonCard{
				LessonID: lesson.ID,
				WordID:   wordID,
				Order:    i,
			}

			if err := tx.Create(&card).Error; err != nil {
				return err
			}
		}

		return nil
	})
}

func (r *LessonRepository) GetByID(ctx context.Context, id uuid.UUID) (*models.Lesson, error) {
	var lesson models.Lesson
	err := r.db.WithContext(ctx).
		Preload("Cards.Word.Topic").
		Preload("Cards.Word.Sentences").
		Preload("Cards.Word.Exercises.ExerciseType").
		Preload("Cards.Word.Exercises.PickOption").
		First(&lesson, "id = ?", id).Error
	if err != nil {
		return nil, err
	}

	return &lesson, nil
}

func (r *LessonRepository) GetLastByUser(ctx context.Context, userID uuid.UUID) (*models.Lesson, error) {
	var lesson models.Lesson
	err := r.db.WithContext(ctx).
		Preload("Cards.Word.Topic").
		Preload("Cards.Word.Sentences").
		Preload("Cards.Word.Exercises.ExerciseType").
		Preload("Cards.Word.Exercises.PickOption").
		Where("user_id = ?", userID).
		Order("started_at DESC").
		First(&lesson).Error
	if err != nil {
		return nil, err
	}

	return &lesson, nil
}

// Delete removes a lesson and all its associated cards
func (r *LessonRepository) Delete(ctx context.Context, id uuid.UUID) error {
	return r.db.WithContext(ctx).Transaction(func(tx *gorm.DB) error {
		if err := tx.Where("lesson_id = ?", id).Delete(&models.LessonCard{}).Error; err != nil {
			return err
		}

		return tx.Delete(&models.Lesson{}, "id = ?", id).Error
	})
}

// GetWordsForLesson needs for generate cards in lesson
func (r *LessonRepository) GetWordsForLesson(
	ctx context.Context,
	userID uuid.UUID,
	cefrLevel string,
	limit int,
) ([]models.Word, error) {
	var words []models.Word

	subQuery := r.db.
		Table("learned_words").
		Select("word_id").
		Where("user_id = ?", userID)

	err := r.db.WithContext(ctx).
		Where("words.cefr_level = ?", cefrLevel).
		Where("words.id NOT IN (?)", subQuery).
		Limit(limit).
		Find(&words).Error

	if err != nil {
		return nil, err
	}

	return words, nil
}
