# Как локально развернуть БД с данными

1. Подключаемся к серверу и тыбзим оттуда данные
```shell
ssh deploy@45.156.22.159 "docker exec -i fluently_postgres pg_dump -U postgres -d postgres" > local_backup.sql
```

2. Пускаем скрипт (В КОРНЕ ПРОЕКТА) который убьёт и запустит нужный сервисы, да ещё и БД заполнит (ну сказка)
```shell
./restore_database.sh
```

# Как вести локальную разработку

Этой команды будет достаточно для разработки backend:
```shell
docker compose -f docker-compose-local.yml down && docker compose  -f docker-compose-local.yml up backend --build -d && docker compose -f docker-compose-local.yml up directus -d
```

Можно убрать билд, если не нужно пересобирать бэк
```shell
docker compose -f docker-compose-local.yml down && docker compose  -f docker-compose-local.yml up backend -d && docker compose -f docker-compose-local.yml up directus -d
```