# 📦 internal/api/v1/routes

Маршруты (роутинг) HTTP-запросов. Каждый файл регистрирует роуты для одной сущности или группы.

## Пример:
- `user_routes.go` — эндпоинты типа `/users`, `/users/{id}/preferences`
- `word_routes.go` — `/words`, `/words/{id}/sentences`

> В `router.go` вызываются все функции `RegisterXxxRoutes()`, чтобы собрать единый роутер.
