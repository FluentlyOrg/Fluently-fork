# Fluently API Usage Guide

## Quick Start

### Base URL
```
localhost:8070
```

## 1. Registration & Authentication

### Register New User
```bash
POST /auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "xYzAbCdEf...",
  "token_type": "Bearer",
  "expires_in": 86400
}
```

### Login
```bash
POST /auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "password123"
}
```

## 2. Word Management

### List All Words
```bash
GET /api/v1/words
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Response:**
```json
[
  {
    "id": "word-uuid-here",
    "word": "hello",
    "cefr_level": "A1",
    "part_of_speech": "interjection",
    "translation": "привет",
    "context": "greeting someone",
    "audio_url": "https://example.com/audio/hello.mp3",
    "topic_id": "topic-uuid-here",
    "phonetic": "həˈloʊ"
  }
]
```

### Get Word by ID
```bash
GET /api/v1/words/{word_id}
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Response:**
```json
{
  "id": "word-uuid-here",
  "word": "hello",
  "cefr_level": "A1",
  "part_of_speech": "interjection",
  "translation": "привет",
  "context": "greeting someone",
  "audio_url": "https://example.com/audio/hello.mp3",
  "topic_id": "topic-uuid-here",
  "phonetic": "həˈloʊ"
}
```

### Add Word to Database
```bash
POST /api/v1/words
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

{
  "word": "hello",
  "cefr_level": "A1",
  "part_of_speech": "interjection",
  "translation": "привет",
  "context": "greeting someone",
  "audio_url": "https://example.com/audio/hello.mp3",
  "topic_id": "topic-uuid-here",
  "phonetic": "həˈloʊ"
}
```

**Response:**
```json
{
  "id": "word-uuid-here",
  "word": "hello",
  "cefr_level": "A1",
  "part_of_speech": "interjection",
  "translation": "привет",
  "context": "greeting someone",
  "audio_url": "https://example.com/audio/hello.mp3",
  "topic_id": "topic-uuid-here",
  "phonetic": "həˈloʊ"
}
```

### Update Word in Database
```bash
PUT /api/v1/words/{word_id}
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

{
  "word": "hello",
  "cefr_level": "A1",
  "part_of_speech": "interjection",
  "translation": "привет",
  "context": "greeting someone",
  "audio_url": "https://example.com/audio/hello.mp3",
  "topic_id": "topic-uuid-here",
  "phonetic": "həˈloʊ"
}
```

**Response:**
```json
{
  "id": "word-uuid-here",
  "word": "hello",
  "cefr_level": "A1",
  "part_of_speech": "interjection",
  "translation": "привет",
  "context": "greeting someone",
  "audio_url": "https://example.com/audio/hello.mp3",
  "topic_id": "topic-uuid-here",
  "phonetic": "həˈloʊ"
}
```

### Delete Word from Database
```bash
DELETE /api/v1/words/{word_id}
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Response:** `204 No Content`

### Get Word Sentences
```bash
GET /api/v1/words/{word_id}/sentences
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Response:**
```json
[
  {
    "id": "sentence-uuid-here",
    "word_id": "word-uuid-here",
    "sentence": "Hello, how are you today?",
    "translation": "Привет, как дела сегодня?",
    "audio_url": "https://example.com/audio/sentence.mp3"
  }
]
```

### Get Word Pick Options
```bash
GET /api/v1/words/{word_id}/pick-options
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Response:**
```json
[
  {
    "id": "pick-option-uuid-here",
    "word_id": "word-uuid-here",
    "sentence_id": "sentence-uuid-here",
    "options": ["option1", "option2", "option3"]
  }
]
```

## 2.1. Learned Words Management

### Get User's Learned Words
```bash
GET /api/v1/users/learned-words
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Response:**
```json
[
  {
    "user_id": "user-uuid-here",
    "word_id": "word-uuid-here",
    "learned_at": "2024-01-15T10:30:00Z",
    "last_reviewed": "2024-01-20T14:45:00Z",
    "cnt_reviewed": 3,
    "confidence_score": 8
  }
]
```

### Get Specific Learned Word
```bash
GET /api/v1/users/learned-words/{word_id}
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Response:**
```json
{
  "user_id": "user-uuid-here",
  "word_id": "word-uuid-here",
  "learned_at": "2024-01-15T10:30:00Z",
  "last_reviewed": "2024-01-20T14:45:00Z",
  "cnt_reviewed": 3,
  "confidence_score": 8
}
```

### Add Word to Learned List
```bash
POST /api/v1/users/learned-words
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

{
  "user_id": "user-uuid-here",
  "word_id": "word-uuid-here",
  "learned_at": "2024-01-15T10:30:00Z",
  "last_reviewed": "2024-01-20T14:45:00Z",
  "cnt_reviewed": 3,
  "confidence_score": 8
}
```

### Update Learned Word
```bash
PUT /api/v1/users/learned-words/{word_id}
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

{
  "user_id": "user-uuid-here",
  "word_id": "word-uuid-here",
  "learned_at": "2024-01-15T10:30:00Z",
  "last_reviewed": "2024-01-20T14:45:00Z",
  "cnt_reviewed": 3,
  "confidence_score": 8
}
```

### Remove Word from Learned List
```bash
DELETE /api/v1/users/learned-words/{word_id}
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Response:** `204 No Content`

## 2.2. Not Learned Words Management

### Get User's Not Learned Words
```bash
GET /api/v1/not-learned-words
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Response:**
```json
{
  "words": [
    {
      "id": "not-learned-uuid-here",
      "user_id": "user-uuid-here",
      "word_id": "word-uuid-here",
      "word": "hello",
      "created_at": "2024-01-15T10:30:00Z"
    }
  ],
  "total": 1
}
```

### Add Word to "Not Learned" List
```bash
POST /api/v1/not-learned-words
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

{
  "word": "hello"
}
```

**Response:**
```json
{
  "id": "not-learned-uuid-here",
  "user_id": "user-uuid-here",
  "word_id": "word-uuid-here",
  "word": "hello",
  "created_at": "2024-01-15T10:30:00Z"
}
```

## 2.3. Progress Tracking

### Update User Progress (Mark Words as Learned)
```bash
POST /api/v1/progress
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

[
  {
    "word_id": "word-uuid-here",
    "learned_at": "2024-01-15T10:30:00Z",
    "confidence_score": 8,
    "cnt_reviewed": 3
  }
]
```

**Response:** `200 OK`

**Note:** This endpoint automatically:
- Creates learned word entries for words with progress data
- Removes words from the "not learned" list when they become learned
- Adds words to the "not learned" list when they have no progress data
- Generates conversation topics for newly learned words




## 3. Sentence Management

### Add Sentence for a Word
```bash
POST /api/v1/sentences
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

{
  "word_id": "word-uuid-here",
  "sentence": "Hello, how are you today?",
  "translation": "Привет, как дела сегодня?",
  "audio_url": "https://example.com/audio/sentence.mp3"
}
```

## 4. Additional Features

### Get Day Word
```bash
GET /api/v1/day-word
Authorization: Bearer YOUR_ACCESS_TOKEN
```

### Generate Distractors (Multiple Choice Options)
```bash
POST /api/v1/distractors
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

{
  "sentence": "The cat is on the table",
  "word": "cat"
}
```

### Get Word Recommendations
```bash
POST /api/v1/thesaurus/recommend
Authorization: Bearer YOUR_ACCESS_TOKEN
Content-Type: application/json

[
  {"word": "hello"},
  {"word": "goodbye"}
]
```

## 5. Error Handling

Common HTTP Status Codes:
- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized (invalid/missing token)
- `404` - Not Found
- `409` - Conflict (already exists)
- `500` - Internal Server Error

## 6. Authentication Notes

- Include `Authorization: Bearer YOUR_ACCESS_TOKEN` header for all API calls except auth endpoints
- Access tokens expire in 24 hours
- Use refresh token to get new access token when expired
- All timestamps should be in ISO 8601 format (UTC)

## 7. Example Workflow

1. **Register** → Get access token
2. **Add word** to database → Get word ID
3. **Add sentences** for the word using word ID
4. **Mark word as learned** using progress endpoint
5. **Get recommendations** for new words to learn

## 8. Rate Limits & Best Practices

- Include proper error handling in your requests
- Store and reuse access tokens until they expire
- Use appropriate HTTP status codes for error handling
- Validate input data before sending requests 