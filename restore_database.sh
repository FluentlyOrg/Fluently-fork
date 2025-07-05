#!/bin/bash

# Fluently Database Restore Script
# This script safely restores a database backup by starting with a clean database

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
BACKUP_FILE="local_backup.sql"
CONTAINER_NAME="fluently_postgres"
DB_NAME="postgres"
DB_USER="postgres"

echo -e "${GREEN}=== Fluently Database Restore Script ===${NC}"
echo ""

# Check if backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo -e "${RED}Error: Backup file '$BACKUP_FILE' not found!${NC}"
    echo "Please make sure the backup file exists in the current directory."
    exit 1
fi

echo -e "${YELLOW}Step 1: Stopping all services...${NC}"
docker-compose down

echo -e "${YELLOW}Step 2: Removing existing database data...${NC}"
# Remove postgres data volume if it exists
docker volume rm fluently_pgdata_safe 2>/dev/null || true
docker volume rm fluently_postgres_data 2>/dev/null || true

# Remove any existing postgres container
docker rm -f $CONTAINER_NAME 2>/dev/null || true

echo -e "${YELLOW}Step 3: Starting database service only...${NC}"
docker-compose up -d postgres

echo -e "${YELLOW}Step 4: Waiting for database to be ready...${NC}"
sleep 10

# Wait for database to be healthy
echo "Waiting for database health check..."
while ! docker-compose exec postgres pg_isready -U $DB_USER -d $DB_NAME >/dev/null 2>&1; do
    echo "Database not ready yet, waiting..."
    sleep 5
done

echo -e "${GREEN}Database is ready!${NC}"

echo -e "${YELLOW}Step 5: Restoring database from backup...${NC}"
echo "This may take a few minutes..."

# Restore the backup
cat "$BACKUP_FILE" | docker exec -i $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Database restored successfully!${NC}"
else
    echo -e "${RED}Database restore failed!${NC}"
    exit 1
fi

echo -e "${YELLOW}Step 6: Starting all services...${NC}"
docker compose up backend -d && docker compose up directus -d

echo -e "${YELLOW}Step 7: Waiting for all services to be ready...${NC}"
sleep 15

echo -e "${GREEN}=== Restore Complete! ===${NC}"
echo ""
echo "Your database has been successfully restored."
echo "Services are starting up. You can check their status with:"
echo "  docker-compose ps"
echo ""
echo "To view logs:"
echo "  docker-compose logs -f" 