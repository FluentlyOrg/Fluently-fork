package schemas

// ErrorResponse represents a standard error response
// swagger:model ErrorResponse
type ErrorResponse struct {
	Message string `json:"message" example:"invalid request"`
}

// CreateWordRequest is a request body for creating a word
type CreateWordRequest struct {
	Word         string  `json:"word" binding:"required"`
	CEFRLevel    string  `json:"cefr_level"`
	Translation  *string `json:"translation"`
	PartOfSpeech string  `json:"part_of_speech" binding:"required"`
	Context      *string `json:"context"`
	AudioURL     *string `json:"audio_url"`
	TopicID      *string `json:"topic_id"`
	Phonetic     *string `json:"phonetic"`
}

// WordResponse is a response for a word
type WordResponse struct {
	ID           string  `json:"id"`
	Word         string  `json:"word"`
	CEFRLevel    string  `json:"cefr_level"`
	Translation  *string `json:"translation,omitempty"`
	PartOfSpeech string  `json:"part_of_speech"`
	Context      *string `json:"context,omitempty"`
	AudioURL     *string `json:"audio_url,omitempty"`
	TopicID      *string `json:"topic_id,omitempty"`
	Phonetic     *string `json:"phonetic,omitempty"`
}
