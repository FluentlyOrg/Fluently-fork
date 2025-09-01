package models

import (
	"encoding/json"
	"time"

	"github.com/google/uuid"
)

// CollectionStructure represents the hierarchical structure of words in a collection
type CollectionStructure struct {
	Topics    map[string]TopicStructure `json:"topics"`
	Unrelated []uuid.UUID               `json:"unrelated"`
}

// TopicStructure represents a topic with its subtopics
type TopicStructure struct {
	Subtopics map[string]SubtopicStructure `json:"subtopics"`
}

// SubtopicStructure represents a subtopic with its subsubtopics
type SubtopicStructure struct {
	Subsubtopics map[string][]uuid.UUID `json:"subsubtopics"`
}

// Collection is a model for collections
type Collection struct {
	ID          uuid.UUID `gorm:"type:uuid;default:uuid_generate_v4();primaryKey"`
	Title       string    `gorm:"type:varchar(30);not null"`
	Description string    `gorm:"type:text;not null"`
	IconUrl     string    `gorm:"type:varchar(255);not null"`
	WordCount   int       `gorm:"type:int;not null;default:0"` // Cached word count for performance
	CreatedAt   time.Time `gorm:"type:timestamp;not null"`
	UpdatedAt   time.Time `gorm:"type:timestamp;not null"`
	Collection  string    `gorm:"type:jsonb;not null"` // Stores CollectionStructure as JSON

	// Favorite relationships
	FavoritedBy []UserCollectionFavorite `gorm:"foreignKey:CollectionID;constraint:OnDelete:CASCADE"`
}

func (Collection) TableName() string {
	return "collections"
}

// GetCollectionStructure unmarshals the JSONB field into a structured type
func (c *Collection) GetCollectionStructure() (*CollectionStructure, error) {
	var structure CollectionStructure
	if err := json.Unmarshal([]byte(c.Collection), &structure); err != nil {
		return nil, err
	}
	return &structure, nil
}

// SetCollectionStructure marshals the structured type into JSONB field
func (c *Collection) SetCollectionStructure(structure *CollectionStructure) error {
	data, err := json.Marshal(structure)
	if err != nil {
		return err
	}
	c.Collection = string(data)

	// Update the word count when the structure changes
	c.updateWordCount(structure)
	return nil
}

// updateWordCount calculates and updates the word count from the collection structure
func (c *Collection) updateWordCount(structure *CollectionStructure) {
	count := 0

	// Count words in topics
	for _, topic := range structure.Topics {
		for _, subtopic := range topic.Subtopics {
			for _, wordUUIDs := range subtopic.Subsubtopics {
				count += len(wordUUIDs)
			}
		}
	}

	// Count words in unrelated
	count += len(structure.Unrelated)

	c.WordCount = count
}

// GetWordCount returns the cached word count
func (c *Collection) GetWordCount() int {
	return c.WordCount
}
