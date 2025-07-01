#!/bin/bash

BACKUP_DIR="/home/deploy/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_PATH="$BACKUP_DIR/fluently_backup_$DATE"

mkdir -p "$BACKUP_PATH"

echo "🔄 Creating backup at $BACKUP_PATH"

# Backup PostgreSQL (most critical)
echo "📊 Backing up PostgreSQL data..."
docker run --rm \
  -v fluently_pgdata_safe:/data \
  -v "$BACKUP_PATH":/backup \
  alpine tar czvf /backup/postgres_data.tar.gz /data

# Backup Grafana dashboards and settings
echo "📈 Backing up Grafana data..."
docker run --rm \
  -v fluently_grafana_data_external:/data \
  -v "$BACKUP_PATH":/backup \
  alpine tar czvf /backup/grafana_data.tar.gz /data

# Backup Prometheus metrics (optional, large files)
echo "📊 Backing up Prometheus data..."
docker run --rm \
  -v fluently_prometheus_data_external:/data \
  -v "$BACKUP_PATH":/backup \
  alpine tar czvf /backup/prometheus_data.tar.gz /data

# Database dump (additional safety)
echo "🗄️ Creating PostgreSQL dump..."
docker compose exec -T postgres pg_dump -U ${DB_USER:-postgres} ${DB_NAME:-fluently} \
  > "$BACKUP_PATH/database_dump.sql"

# SonarQube backup
echo "🔍 Backing up SonarQube data..."
docker run --rm \
  -v fluently_sonarqube_data_external:/data \
  -v "$BACKUP_PATH":/backup \
  alpine tar czvf /backup/sonarqube_data.tar.gz /data

# Create backup metadata
cat > "$BACKUP_PATH/backup_info.txt" << EOF
Backup created: $(date)
Docker compose project: fluently-fork
Volumes backed up:
- fluently_pgdata_safe
- fluently_grafana_data_external
- fluently_prometheus_data_external  
- fluently_sonarqube_data_external
Database dump: database_dump.sql
EOF

echo "✅ Backup completed: $BACKUP_PATH"

# Keep only last 7 days of backups
find "$BACKUP_DIR" -name "fluently_backup_*" -type d -mtime +7 -exec rm -rf {} \;

echo "🧹 Cleaned up old backups (kept last 7 days)"