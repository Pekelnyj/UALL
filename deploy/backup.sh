#!/usr/bin/env bash
# Щоденний консистентний бекап editor.db (через sqlite3 .backup, безпечно на живій БД).
# Тримає KEEP_DAYS днів. Запускається таймером wowukraine-backup.timer.
set -euo pipefail

DB=/opt/wowukraine/editor/editor.db
DEST=/opt/wowukraine/db-backups
KEEP_DAYS=14

mkdir -p "$DEST"
TS=$(date +%Y%m%d-%H%M%S)
OUT="$DEST/editor-$TS.db"

sqlite3 "$DB" ".backup '$OUT'"
gzip -f "$OUT"
# ротація: прибрати старіші за KEEP_DAYS
find "$DEST" -name 'editor-*.db.gz' -mtime "+$KEEP_DAYS" -delete

echo "backup ok: $OUT.gz"
