package postgres

import (
	"context"

	"fluently/go-backend/internal/repository/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

// CollectionRepository handles database operations for collections
type CollectionRepository struct {
	db *gorm.DB
}

// NewCollectionRepository creates a new CollectionRepository
func NewCollectionRepository(db *gorm.DB) *CollectionRepository {
	return &CollectionRepository{db: db}
}

// GetByID retrieves a collection by ID
func (r *CollectionRepository) GetByID(ctx context.Context, id uuid.UUID) (*models.Collection, error) {
	var collection models.Collection
	result := r.db.WithContext(ctx).Where("id = ?", id).First(&collection)
	if result.Error != nil {
		return nil, result.Error
	}
	return &collection, nil
}

// Create creates a new collection
func (r *CollectionRepository) Create(ctx context.Context, collection *models.Collection) error {
	return r.db.WithContext(ctx).Create(collection).Error
}

// Update updates an existing collection
func (r *CollectionRepository) Update(ctx context.Context, collection *models.Collection) error {
	return r.db.WithContext(ctx).Save(collection).Error
}

// Delete deletes a collection by ID
func (r *CollectionRepository) Delete(ctx context.Context, id uuid.UUID) error {
	return r.db.WithContext(ctx).Where("id = ?", id).Delete(&models.Collection{}).Error
}

// List retrieves all collections with pagination
func (r *CollectionRepository) List(ctx context.Context, limit, offset int) ([]models.Collection, error) {
	var collections []models.Collection
	result := r.db.WithContext(ctx).Limit(limit).Offset(offset).Find(&collections)
	if result.Error != nil {
		return nil, result.Error
	}
	return collections, nil
}

// Count returns the total number of collections
func (r *CollectionRepository) Count(ctx context.Context) (int64, error) {
	var count int64
	result := r.db.WithContext(ctx).Model(&models.Collection{}).Count(&count)
	if result.Error != nil {
		return 0, result.Error
	}
	return count, nil
}
