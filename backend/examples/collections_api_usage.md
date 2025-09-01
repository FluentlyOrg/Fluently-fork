# Collections API Usage Guide

This guide demonstrates how to use the Collections API with practical examples.

## API Endpoints

### Base URL
```
/api/v1/collections
```

## Authentication
All endpoints require Bearer token authentication:
```bash
Authorization: Bearer <your-jwt-token>
```

## 1. List Collections

**GET** `/api/v1/collections`

Returns all collections with pagination support.

### Query Parameters
- `limit` (optional): Number of items to return (default: 10, max: 100)
- `offset` (optional): Number of items to skip (default: 0)

### Example Request
```bash
curl -X GET "http://localhost:8080/api/v1/collections?limit=5&offset=0" \
  -H "Authorization: Bearer <your-token>"
```

### Example Response
```json
{
  "collections": [
    {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "title": "Basic Vocabulary",
      "description": "Essential words for beginners",
      "icon_url": "https://example.com/icons/basic.png",
      "word_count": 150,
      "created_at": "2024-01-15T10:30:00Z",
      "updated_at": "2024-01-15T10:30:00Z",
      "collection": {
        "topics": {
          "Family": {
            "subtopics": {
              "Relations": {
                "subsubtopics": {
                  "Parents": ["uuid1", "uuid2", "uuid3"],
                  "Siblings": ["uuid4", "uuid5"]
                }
              }
            }
          }
        },
        "unrelated": ["uuid6", "uuid7", "uuid8"]
      }
    }
  ],
  "total": 25
}
```

## 2. Get Collection by ID

**GET** `/api/v1/collections/{id}`

Returns a specific collection by ID.

### Example Request
```bash
curl -X GET "http://localhost:8080/api/v1/collections/550e8400-e29b-41d4-a716-446655440000" \
  -H "Authorization: Bearer <your-token>"
```

### Example Response
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "title": "Basic Vocabulary",
  "description": "Essential words for beginners",
  "icon_url": "https://example.com/icons/basic.png",
  "word_count": 150,
  "created_at": "2024-01-15T10:30:00Z",
  "updated_at": "2024-01-15T10:30:00Z",
  "collection": {
    "topics": {
      "Family": {
        "subtopics": {
          "Relations": {
            "subsubtopics": {
              "Parents": ["uuid1", "uuid2", "uuid3"],
              "Siblings": ["uuid4", "uuid5"]
            }
          }
        }
      }
    },
    "unrelated": ["uuid6", "uuid7", "uuid8"]
  }
}
```

## 3. Create Collection

**POST** `/api/v1/collections`

Creates a new collection.

### Request Body
```json
{
  "title": "Advanced Business Terms",
  "description": "Professional vocabulary for business communication",
  "icon_url": "https://example.com/icons/business.png",
  "collection": {
    "topics": {
      "Business": {
        "subtopics": {
          "Meetings": {
            "subsubtopics": {
              "Agenda": ["uuid1", "uuid2"],
              "Minutes": ["uuid3", "uuid4"]
            }
          },
          "Finance": {
            "subsubtopics": {
              "Budget": ["uuid5", "uuid6"],
              "Investment": ["uuid7", "uuid8"]
            }
          }
        }
      }
    },
    "unrelated": ["uuid9", "uuid10"]
  }
}
```

### Example Request
```bash
curl -X POST "http://localhost:8080/api/v1/collections" \
  -H "Authorization: Bearer <your-token>" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Advanced Business Terms",
    "description": "Professional vocabulary for business communication",
    "icon_url": "https://example.com/icons/business.png",
    "collection": {
      "topics": {
        "Business": {
          "subtopics": {
            "Meetings": {
              "subsubtopics": {
                "Agenda": ["550e8400-e29b-41d4-a716-446655440001", "550e8400-e29b-41d4-a716-446655440002"],
                "Minutes": ["550e8400-e29b-41d4-a716-446655440003", "550e8400-e29b-41d4-a716-446655440004"]
              }
            }
          }
        }
      },
      "unrelated": ["550e8400-e29b-41d4-a716-446655440005", "550e8400-e29b-41d4-a716-446655440006"]
    }
  }'
```

### Example Response
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440007",
  "title": "Advanced Business Terms",
  "description": "Professional vocabulary for business communication",
  "icon_url": "https://example.com/icons/business.png",
  "word_count": 6,
  "created_at": "2024-01-15T11:00:00Z",
  "updated_at": "2024-01-15T11:00:00Z",
  "collection": {
    "topics": {
      "Business": {
        "subtopics": {
          "Meetings": {
            "subsubtopics": {
              "Agenda": ["550e8400-e29b-41d4-a716-446655440001", "550e8400-e29b-41d4-a716-446655440002"],
              "Minutes": ["550e8400-e29b-41d4-a716-446655440003", "550e8400-e29b-41d4-a716-446655440004"]
            }
          }
        }
      }
    },
    "unrelated": ["550e8400-e29b-41d4-a716-446655440005", "550e8400-e29b-41d4-a716-446655440006"]
  }
}
```

## 4. Update Collection

**PUT** `/api/v1/collections/{id}`

Updates an existing collection. All fields are optional.

### Request Body
```json
{
  "title": "Updated Business Terms",
  "description": "Updated description",
  "collection": {
    "topics": {
      "Business": {
        "subtopics": {
          "Meetings": {
            "subsubtopics": {
              "Agenda": ["uuid1", "uuid2", "uuid3"]
            }
          }
        }
      }
    },
    "unrelated": ["uuid4"]
  }
}
```

### Example Request
```bash
curl -X PUT "http://localhost:8080/api/v1/collections/550e8400-e29b-41d4-a716-446655440007" \
  -H "Authorization: Bearer <your-token>" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Updated Business Terms",
    "description": "Updated description",
    "collection": {
      "topics": {
        "Business": {
          "subtopics": {
            "Meetings": {
              "subsubtopics": {
                "Agenda": ["550e8400-e29b-41d4-a716-446655440001", "550e8400-e29b-41d4-a716-446655440002", "550e8400-e29b-41d4-a716-446655440003"]
              }
            }
          }
        }
      },
      "unrelated": ["550e8400-e29b-41d4-a716-446655440004"]
    }
  }'
```

## 5. Delete Collection

**DELETE** `/api/v1/collections/{id}`

Deletes a collection.

### Example Request
```bash
curl -X DELETE "http://localhost:8080/api/v1/collections/550e8400-e29b-41d4-a716-446655440007" \
  -H "Authorization: Bearer <your-token>"
```

### Example Response
```json
{
  "message": "Collection deleted successfully"
}
```

## 6. Favorites Management

### Add to Favorites
**POST** `/api/v1/collections/favorites`

```bash
curl -X POST "http://localhost:8080/api/v1/collections/favorites" \
  -H "Authorization: Bearer <your-token>" \
  -H "Content-Type: application/json" \
  -d '{"collection_id": "550e8400-e29b-41d4-a716-446655440000"}'
```

### Remove from Favorites
**DELETE** `/api/v1/collections/favorites`

```bash
curl -X DELETE "http://localhost:8080/api/v1/collections/favorites" \
  -H "Authorization: Bearer <your-token>" \
  -H "Content-Type: application/json" \
  -d '{"collection_id": "550e8400-e29b-41d4-a716-446655440000"}'
```

### Get User's Favorites
**GET** `/api/v1/collections/favorites`

```bash
curl -X GET "http://localhost:8080/api/v1/collections/favorites?limit=10&offset=0" \
  -H "Authorization: Bearer <your-token>"
```

### Check Favorite Status
**GET** `/api/v1/collections/{collection_id}/favorite`

```bash
curl -X GET "http://localhost:8080/api/v1/collections/550e8400-e29b-41d4-a716-446655440000/favorite" \
  -H "Authorization: Bearer <your-token>"
```

Response:
```json
{
  "is_favorite": true
}
```

## Error Responses

### 400 Bad Request
```json
{
  "error": "invalid request body"
}
```

### 401 Unauthorized
```json
{
  "error": "unauthorized"
}
```

### 404 Not Found
```json
{
  "error": "collection not found"
}
```

### 409 Conflict (Duplicate Favorite)
```json
{
  "error": "collection already in favorites"
}
```

### 500 Internal Server Error
```json
{
  "error": "internal server error"
}
```

## Collection Structure

The `collection` field uses a hierarchical structure:

```json
{
  "topics": {
    "Topic Name": {
      "subtopics": {
        "Subtopic Name": {
          "subsubtopics": {
            "Sub-subtopic Name": ["word_uuid1", "word_uuid2", "word_uuid3"]
          }
        }
      }
    }
  },
  "unrelated": ["word_uuid4", "word_uuid5"]
}
```

- `topics`: Main categories (e.g., "Business", "Family", "Technology")
- `subtopics`: Subcategories within topics (e.g., "Meetings", "Relations")
- `subsubtopics`: Specific groups within subtopics (e.g., "Agenda", "Parents")
- `unrelated`: Words that don't fit into the hierarchical structure

## Word Count

The `word_count` field is automatically calculated and cached for performance. It includes:
- All words in the hierarchical structure (topics → subtopics → subsubtopics)
- All words in the unrelated array

The count is updated whenever the collection structure is modified. 