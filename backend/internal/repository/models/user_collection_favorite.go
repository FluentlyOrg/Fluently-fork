package models

import (
	"time"

	"github.com/google/uuid"
)

// UserCollectionFavorite represents a user's favorite collection
type UserCollectionFavorite struct {
	ID           uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primaryKey"`
	UserID       uuid.UUID `gorm:"type:uuid;not null;uniqueIndex:idx_user_collection"`
	CollectionID uuid.UUID `gorm:"type:uuid;not null;uniqueIndex:idx_user_collection"`
	CreatedAt    time.Time `gorm:"autoCreateTime"`

	// Relationships
	User       User       `gorm:"foreignKey:UserID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE"`
	Collection Collection `gorm:"foreignKey:CollectionID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE"`
}

func (UserCollectionFavorite) TableName() string {
	return "user_collection_favorites"
} 