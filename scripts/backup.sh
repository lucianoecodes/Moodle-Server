#!/usr/bin/env bash
# ============================================================
# Script de backup sugerido — Stack Moodle
# Local sugerido: /usr/local/bin/backup-moodle.sh
# Executar como root (ou via sudo). Agendar no cron.
#
# Faz backup de:
#   - Banco MariaDB (mysqldump)
#   - Pasta de configurações persistentes (/var/lib/docker/moodle-app/)
#   - docker-compose.yml
# ============================================================

set -euo pipefail

# ---- Configurações (AJUSTE) ----
BACKUP_DIR="/backup/moodle"                 # destino dos backups
DB_CONTAINER="moodle-app-database-1"
DB_USER="moodle_user"
DB_PASS="123SenhaLocal\$"                       # senha do banco
DB_NAME="moodle"
COMPOSE_DIR="/var/lib/docker/moodle-app"
RETENTION_DAYS=30                            # dias para reter backups

mkdir -p "$BACKUP_DIR"
DATE=$(date +%Y%m%d_%H%M%S)

echo "[backup] Iniciando backup em $DATE"

# ---- 1) Dump do banco ----
echo "[backup] Dump do banco MariaDB..."
docker exec "$DB_CONTAINER" \
  mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" \
  > "$BACKUP_DIR/moodle_db_$DATE.sql"

# ---- 2) Pasta de configurações persistentes + compose ----
echo "[backup] Copiando configurações persistentes..."
tar -czf "$BACKUP_DIR/moodle_conf_$DATE.tar.gz" \
  -C / \
  "$COMPOSE_DIR"

# ---- 3) Limpeza de backups antigos ----
echo "[backup] Removendo backups com mais de ${RETENTION_DAYS} dias..."
find "$BACKUP_DIR" -type f -mtime "+$RETENTION_DAYS" -delete

echo "[backup] Backups em: $BACKUP_DIR"
ls -lh "$BACKUP_DIR"
echo "[backup] Concluído."
