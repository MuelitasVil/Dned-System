#!/usr/bin/env bash
set -Eeuo pipefail
umask 077

PROJECT_DIR="/home/dned-admin/dned-system/Dned-System"
BACKUP_DIR="/home/dned-admin/backups/dned-system"
DATE="$(date '+%Y%m%d_%H%M%S')"
MYSQL_CONTAINER="dned-mysql"
DB_NAME="TU_NOMBRE_DE_BASE_DE_DATOS"
DB_USER="TU_USUARIO_DE_MYSQL"

mkdir -p "$BACKUP_DIR"

# Respaldo lógico de MySQL comprimido.
docker exec "$MYSQL_CONTAINER" sh -c \
  'exec mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --single-transaction "$MYSQL_DATABASE"' \
  | gzip > "$BACKUP_DIR/mysql_${DATE}.sql.gz"

# Copia del volumen de GAM: incluye configuración/credenciales.
docker run --rm \
  -v dned-system_gam_data:/source:ro \
  -v "$BACKUP_DIR":/backup \
  alpine \
  tar -czf "/backup/gam_${DATE}.tar.gz" -C /source .

# Elimina respaldos locales de más de 30 días.
find "$BACKUP_DIR" -type f -mtime +30 -delete
