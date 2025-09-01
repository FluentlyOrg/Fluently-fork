package postgres

import (
	"context"
	"errors"

	"fluently/go-backend/internal/repository/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

// UserCollectionFavoriteRepository handles database operations for user collection favorites
type UserCollectionFavoriteRepository struct {
	db *gorm.DB
}

// NewUserCollectionFavoriteRepository creates a new UserCollectionFavoriteRepository
func NewUserCollectionFavoriteRepository(db *gorm.DB) *UserCollectionFavoriteRepository {
	return &UserCollectionFavoriteRepository{db: db}
}

// Create adds a collection to user's favorites
func (r *UserCollectionFavoriteRepository) Create(ctx context.Context, userID, collectionID uuid.UUID) error {
	favorite := models.UserCollectionFavorite{
		UserID:       userID,
		CollectionID: collectionID,
	}

	result := r.db.WithContext(ctx).Create(&favorite)
	if result.Error != nil {
		// Check if it's a duplicate key error
		if errors.Is(result.Error, gorm.ErrDuplicatedKey) {
			return errors.New("collection already in favorites")
		}
		return result.Error
	}

	return nil
}

// Delete removes a collection from user's favorites
func (r *UserCollectionFavoriteRepository) Delete(ctx context.Context, userID, collectionID uuid.UUID) error {
	result := r.db.WithContext(ctx).Where("user_id = ? AND collection_id = ?", userID, collectionID).
		Delete(&models.UserCollectionFavorite{})

	if result.Error != nil {
		return result.Error
	}

	if result.RowsAffected == 0 {
		return errors.New("collection not in favorites")
	}

	return nil
}

// IsFavorite checks if a collection is in user's favorites
func (r *UserCollectionFavoriteRepository) IsFavorite(ctx context.Context, userID, collectionID uuid.UUID) (bool, error) {
	var count int64
	result := r.db.WithContext(ctx).Model(&models.UserCollectionFavorite{}).
		Where("user_id = ? AND collection_id = ?", userID, collectionID).
		Count(&count)

	if result.Error != nil {
		return false, result.Error
	}

	return count > 0, nil
}

// GetUserFavorites returns all favorite collections for a user
func (r *UserCollectionFavoriteRepository) GetUserFavorites(ctx context.Context, userID uuid.UUID, limit, offset int) ([]models.UserCollectionFavorite, error) {
	var favorites []models.UserCollectionFavorite

	result := r.db.WithContext(ctx).
		Preload("Collection").
		Where("user_id = ?", userID).
		Order("created_at DESC").
		Limit(limit).
		Offset(offset).
		Find(&favorites)

	if result.Error != nil {
		return nil, result.Error
	}

	return favorites, nil
}

// GetUserFavoritesCount returns the total count of favorite collections for a user
func (r *UserCollectionFavoriteRepository) GetUserFavoritesCount(ctx context.Context, userID uuid.UUID) (int64, error) {
	var count int64

	result := r.db.WithContext(ctx).Model(&models.UserCollectionFavorite{}).
		Where("user_id = ?", userID).
		Count(&count)

	if result.Error != nil {
		return 0, result.Error
	}

	return count, nil
}

// GetCollectionFavoritesCount returns how many users have favorited a collection
func (r *UserCollectionFavoriteRepository) GetCollectionFavoritesCount(ctx context.Context, collectionID uuid.UUID) (int64, error) {
	var count int64

	result := r.db.WithContext(ctx).Model(&models.UserCollectionFavorite{}).
		Where("collection_id = ?", collectionID).
		Count(&count)

	if result.Error != nil {
		return 0, result.Error
	}

	return count, nil
}
