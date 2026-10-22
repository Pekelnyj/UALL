#!/usr/bin/env bash
# Первинне налаштування сервера (Ubuntu/Debian). Запускати як root ПІСЛЯ того,
# як код лежить у /opt/wowukraine (git clone або scp) і editor.db на місці.
#   sudo bash /opt/wowukraine/deploy/setup.sh
set -euo pipefail
APP=/opt/wowukraine

echo "== swap (для машин з малою RAM, напр. Oracle E2.1.Micro 1ГБ) =="
# Підміна бази копіює ~192МБ SQLite — на 1ГБ RAM без swap може впертись у пам'ять.
if ! swapon --show | grep -q '/swapfile'; then
  if [ ! -f /swapfile ]; then
    fallocate -l 2G /swapfile || dd if=/dev/zero of=/swapfile bs=1M count=2048
    chmod 600 /swapfile
    mkswap /swapfile
  fi
  swapon /swapfile
  grep -q '/swapfile' /etc/fstab || echo '/swapfile none swap sw 0 0' >> /etc/fstab
  sysctl -w vm.swappiness=10 >/dev/null
  grep -q 'vm.swappiness' /etc/sysctl.conf || echo 'vm.swappiness=10' >> /etc/sysctl.conf
  echo "  swap 2ГБ увімкнено й збережено"
else
  echo "  swap уже є — пропускаю"
fi

echo "== пакети =="
apt-get update
apt-get install -y python3 python3-venv python3-pip sqlite3 git curl \
    debian-keyring debian-archive-keyring apt-transport-https

echo "== Caddy =="
if ! command -v caddy >/dev/null; then
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' \
    | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' \
    > /etc/apt/sources.list.d/caddy-stable.list
  apt-get update
  apt-get install -y caddy
fi

echo "== користувач wowua =="
id wowua >/dev/null 2>&1 || useradd --system --home "$APP" --shell /usr/sbin/nologin wowua

echo "== venv + залежності =="
[ -d "$APP/.venv" ] || python3 -m venv "$APP/.venv"
"$APP/.venv/bin/pip" install --upgrade pip
"$APP/.venv/bin/pip" install -r "$APP/editor/requirements.txt"

echo "== права =="
chown -R wowua:wowua "$APP"
chmod +x "$APP/deploy/backup.sh"

echo "== env-файл =="
if [ ! -f /etc/wowukraine.env ]; then
  PW=$(head -c 12 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 14)
  printf 'WOWUA_SECURE_COOKIE=1\nWOWUA_ADMIN_PW=%s\n' "$PW" > /etc/wowukraine.env
  chmod 600 /etc/wowukraine.env
  echo "   СТВОРЕНО /etc/wowukraine.env"
  echo "   >>> Початковий пароль адміна (лише якщо БД без користувачів): $PW"
fi

echo "== systemd =="
cp "$APP/deploy/wowukraine-editor.service" /etc/systemd/system/
cp "$APP/deploy/wowukraine-backup.service" /etc/systemd/system/
cp "$APP/deploy/wowukraine-backup.timer"   /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now wowukraine-editor.service
systemctl enable --now wowukraine-backup.timer

echo "== фаєрвол: відкрити 80/443 =="
# Oracle Cloud (Ubuntu) має ЖОРСТКІ iptables (default REJECT) — відкриваємо HTTP/HTTPS і зберігаємо.
if command -v iptables >/dev/null && iptables -S INPUT 2>/dev/null | grep -qiE "REJECT|DROP"; then
  for p in 80 443; do
    iptables -C INPUT -p tcp --dport "$p" -j ACCEPT 2>/dev/null || iptables -I INPUT -p tcp --dport "$p" -j ACCEPT
  done
  if command -v netfilter-persistent >/dev/null; then
    netfilter-persistent save
  else
    DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent && netfilter-persistent save
  fi
  echo "  iptables: 80/443 відкрито й збережено"
fi
# ufw (інші провайдери) — якщо активний
if command -v ufw >/dev/null && ufw status 2>/dev/null | grep -q "Status: active"; then
  ufw allow 22,80,443/tcp || true
fi
echo "  !!! НЕ ЗАБУДЬ відкрити 80/443 ще й у Oracle VCN -> Security List (хмарний фаєрвол) !!!"

echo
echo "ГОТОВО. Залишилось:"
echo "  1) Встав свій домен у /etc/caddy/Caddyfile (скопіюй із $APP/deploy/Caddyfile)."
echo "  2) systemctl reload caddy"
echo "  3) Відкрий https://твій-домен — увійди як admin (пароль вище / у /etc/wowukraine.env)."
echo "     Одразу зміни пароль і прибери тестові акаунти."
