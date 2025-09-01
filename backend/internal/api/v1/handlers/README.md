# 📦 internal/api/v1/handlers

Здесь находятся **HTTP-обработчики** (handlers), которые отвечают на запросы от клиента.

Каждый файл — это набор функций-эндпоинтов для конкретной сущности: `User`, `Word`, `Sentence`, и т.д.

## Обязанности:
- Чтение и валидация входных данных (`schemas/*.go`)
- Возврат HTTP-ответов (JSON + статус)

## Пример структуры:
- `user_handler.go` — POST /users, GET /users/{id}, PUT /users/{id}, ...
- `word_handler.go` — CRUD для слов
- `sentence_handler.go` — добавление / удаление предложений
