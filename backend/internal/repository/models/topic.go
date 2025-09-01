package models

import (
	"github.com/google/uuid"
)

// Topic is a model for topics
type Topic struct {
	ID        uuid.UUID   `gorm:"type:uuid;default:uuid_generate_v4();primaryKey"`
	Title     string      `gorm:"type:varchar(100);not null"`
	ParentID  *uuid.UUID  `gorm:"type:uuid"`
	SeedWords StringArray `gorm:"type:text"`
}

// TableName returns the table name for Topic
func (Topic) TableName() string {
	return "topics"
}
