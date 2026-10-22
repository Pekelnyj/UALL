# Деплой редактора WoWUkraine на Hetzner (VPS) + Caddy (HTTPS) + systemd + бекапи

Один невеликий VPS, SQLite, авто-HTTPS. Розраховано на десятки перекладачів (трафік малий).

## 0. Що де
- Код: `/opt/wowukraine` (git clone репозиторію).
- БД: `/opt/wowukraine/editor/editor.db` (192МБ; **не** в git).
- Демон: `wowukraine-editor.service` (uvicorn на `127.0.0.1:8011`, лише за Caddy).
- HTTPS: Caddy (reverse proxy + Let's Encrypt).
- Бекапи: щодня `03:30` → `/opt/wowukraine/db-backups/` (14 днів).

## 1. Сервер і домен
Варіант A — **Hetzner Cloud**: CAX11 (ARM, ~€3.79) або CX22/CX23, **Ubuntu**, регіон NBG/FSN/HEL.
**Увімкни Primary IPv4** (+€0.50) — без неї IPv4-користувачі не зайдуть.

Варіант B — **Oracle Cloud Always Free** ($0):
1. `oracle.com/cloud/free` → Start for free (картка для верифікації, не списують). Home Region — **Frankfurt/Amsterdam**.
2. Compute → Create Instance → shape **`VM.Standard.A1.Flex`** (ARM Ampere, Always Free) → 1–4 OCPU / до 24 ГБ → образ **Ubuntu 22.04/24.04**. Додай SSH-ключ.
   - Якщо «Out of capacity» — ретрай / зміни Availability Domain (типова проблема безкоштовного ARM).
3. **Мережа (ОБОВ'ЯЗКОВО):** VCN → Security List → Add **Ingress Rules**: TCP **80** і **443** з `0.0.0.0/0`.
   (Фаєрвол усередині інстансу — iptables — відкриває `setup.sh`.)
4. У інстансу буде публічна IPv4 — її й наводиш A-записом.

DNS: A-запис `temnozelena.com` (і `www`) → публічна IPv4 сервера. SSH як `ubuntu` (Oracle) або `root` (Hetzner).
Команди setup.sh/update.sh запускай через `sudo`.

## 2. Підготувати чисту БД (локально, рекомендовано)
Щоб прод стартував без тестових акаунтів — збери свіжу БД зі своїх даних:
```bash
python editor/import_db.py --force     # лише рядки, без користувачів (на 1-му старті створиться admin)
```
> Якщо хочеш зберегти наявну `editor.db` — пропусти крок; тоді на сервері зміни пароль admin і прибери тестові акаунти в панелі.

## 3. Залити код і БД на сервер
```bash
# код (із локалі, з кореня репо):
ssh root@SERVER 'mkdir -p /opt/wowukraine'
git clone <твій-репозиторій> /tmp/wu && rsync -a --exclude='.git' /tmp/wu/ root@... # АБО простіше:
scp -r editor deploy root@SERVER:/opt/wowukraine/
# БД окремо (вона в .gitignore):
scp editor/editor.db root@SERVER:/opt/wowukraine/editor/
```
> Для зручних **оновлень** краще `git clone` у `/opt/wowukraine` (див. крок 6). Тоді код тягнеться `git pull`, а `editor.db` лишається (вона ігнорується git).

## 4. Налаштувати сервер (одна команда)
```bash
ssh root@SERVER
sudo bash /opt/wowukraine/deploy/setup.sh
```
Скрипт: пакети, Caddy, користувач `wowua`, venv+залежності, `/etc/wowukraine.env`
(з початковим паролем адміна), systemd-сервіс+таймер, фаєрвол. **Запиши виведений пароль адміна.**

## 5. Увімкнути HTTPS
```bash
cp /opt/wowukraine/deploy/Caddyfile /etc/caddy/Caddyfile
nano /etc/caddy/Caddyfile          # встав свій домен замість editor.example.com
systemctl reload caddy
```
Caddy сам отримає сертифікат. Відкрий `https://твій-домен` → увійди як `admin` (пароль із кроку 4) →
**одразу зміни пароль** (панель → Користувачі → Скинути) і прибери тестові акаунти. Створи перекладачів.

## 6. Як заливати ОНОВЛЕННЯ коду
Код у git, `editor.db`/бекапи/завантаження — у `.gitignore`, тож оновлення коду їх не чіпає.

**Якщо код через git clone (рекомендовано):**
```bash
# локально: закомітити + запушити зміни
git add -A && git commit -m "…" && git push
# на сервері:
ssh root@SERVER 'sudo bash /opt/wowukraine/deploy/update.sh'
```
`update.sh` = `git pull` + оновити залежності + перезапустити сервіс. Зміни лише в `static/*`
(HTML/CSS/JS) застосовуються й без рестарту — але `update.sh` рестартує про всяк (безпечно).

**Якщо без git (rsync із локалі):**
```bash
rsync -avz --exclude='__pycache__' --exclude='*.db' \
  --exclude='editor/backups' --exclude='editor/uploads' \
  editor deploy root@SERVER:/opt/wowukraine/
ssh root@SERVER systemctl restart wowukraine-editor
```

## 7. Як заливати ОНОВЛЕННЯ БАЗИ (нові рядки на переклад)
Не через код! Через адмінпанель (зберігає правки спільноти):
```bash
python editor/build_base_package.py          # локально -> data/base_package.jsonl.gz
```
→ на сайті: **Адмінпанель → База → Завантажити нову базу** (перевірка + атомарна підміна + 24h відкат).
Альтернатива по SSH: `scp` пакета + `python editor/update_db.py --from-package …` (див. editor/README.md).

## 8. Експлуатація
```bash
systemctl status wowukraine-editor          # стан сервісу
journalctl -u wowukraine-editor -f          # логи
systemctl list-timers | grep wowukraine     # коли наступний бекап
ls -lh /opt/wowukraine/db-backups/          # бекапи
sudo -u wowua /opt/wowukraine/deploy/backup.sh   # бекап вручну
/opt/wowukraine/.venv/bin/python /opt/wowukraine/editor/auth.py unlock   # зняти брутфорс-блок
```
Відновлення з бекапа: зупини сервіс, розпакуй потрібний `editor-*.db.gz` у `editor/editor.db`, запусти сервіс.

## Безпека (увімкнено)
HTTPS (Caddy) · `WOWUA_SECURE_COOKIE=1` · uvicorn лише на `127.0.0.1` · брутфорс-ліміт логіну ·
pbkdf2-паролі (constant-time) · сесії HttpOnly+SameSite=Lax · захисні заголовки (X-Frame-Options,
nosniff, CSP `frame-ancestors 'none'`) · SQL параметризований · XSS-екранування · ліміт завантажень ·
щоденні бекапи.

Перед/після запуску: прибери тестові акаунти, зміни пароль admin, тримай систему й залежності
оновленими (`apt upgrade`, `pip install -U` за потреби), вимкни root-логін по SSH (ключі), `ufw` 22/80/443.
