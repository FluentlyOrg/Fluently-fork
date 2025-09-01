package schemas

import (
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

// CreateCollectionRequest represents the request to create a collection
type CreateCollectionRequest struct {
	Title       string              `json:"title" validate:"required,max=30"`
	Description string              `json:"description" validate:"required"`
	IconUrl     string              `json:"icon_url" validate:"required,url"`
	Collection  CollectionStructure `json:"collection" validate:"required"`
}

// UpdateCollectionRequest represents the request to update a collection
type UpdateCollectionRequest struct {
	Title       *string              `json:"title,omitempty" validate:"omitempty,max=30"`
	Description *string              `json:"description,omitempty"`
	IconUrl     *string              `json:"icon_url,omitempty" validate:"omitempty,url"`
	Collection  *CollectionStructure `json:"collection,omitempty"`
}

// CollectionResponse represents the response for a collection
type CollectionResponse struct {
	ID          string              `json:"id"`
	Title       string              `json:"title"`
	Description string              `json:"description"`
	IconUrl     string              `json:"icon_url"`
	WordCount   int                 `json:"word_count"`
	CreatedAt   string              `json:"created_at"`
	UpdatedAt   string              `json:"updated_at"`
	Collection  CollectionStructure `json:"collection"`
}

// CollectionListResponse represents the response for listing collections
type CollectionListResponse struct {
	Collections []CollectionResponse `json:"collections"`
	Total       int64                `json:"total"`
}

// AddToFavoritesRequest represents the request to add a collection to favorites
type AddToFavoritesRequest struct {
	CollectionID string `json:"collection_id" validate:"required,uuid"`
}

// RemoveFromFavoritesRequest represents the request to remove a collection from favorites
type RemoveFromFavoritesRequest struct {
	CollectionID string `json:"collection_id" validate:"required,uuid"`
}

// FavoriteCollectionResponse represents a favorite collection with additional metadata
type FavoriteCollectionResponse struct {
	CollectionResponse
	FavoritedAt string `json:"favorited_at"`
}

// FavoriteCollectionsListResponse represents the response for listing favorite collections
type FavoriteCollectionsListResponse struct {
	Collections []FavoriteCollectionResponse `json:"collections"`
	Total       int64                        `json:"total"`
}

// FavoriteStatusResponse represents the response for checking favorite status
type FavoriteStatusResponse struct {
	IsFavorite bool `json:"is_favorite"`
}

// SuccessResponse represents a generic success response
type SuccessResponse struct {
	Message string `json:"message"`
}
