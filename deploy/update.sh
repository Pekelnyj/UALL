#!/usr/bin/env bash
# Залити оновлення КОДУ на сервер. Запускати на сервері як root: sudo bash deploy/update.sh
#
# editor.db, editor/backups/, editor/uploads/ — у .gitignore, тож git pull їх НЕ чіпає:
# база й уся праця спільноти лишаються недоторканими. Оновлюється тільки код.
set -euo pipefail
APP=/opt/wowukraine

echo "== git pull =="
sudo -u wowua git -C "$APP" pull --ff-only

echo "== залежності =="
sudo -u wowua "$APP/.venv/bin/pip" install -q -r "$APP/editor/requirements.txt"

echo "== перезапуск =="
systemctl restart wowukraine-editor
sleep 1
systemctl --no-pager --lines=0 status wowukraine-editor | head -n 4
echo "Готово. (Зміни лише в static/* застосовуються й без рестарту — але рестарт безпечний.)"
