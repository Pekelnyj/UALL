# Offsite-бекап editor.db з temnozelena.com (Oracle VM) на цей ПК.
# Тягне НАЙСВІЖІШИЙ щоденний editor-*.db.gz (~78 МБ) у db-offsite\ і тримає останні 8.
# Навіщо: усі серверні бекапи лежать на тому САМОМУ диску VM — якщо Oracle забере
# інстанс чи помре диск, без цієї копії пропаде вся праця спільноти.
# Запуск вручну:  powershell -ExecutionPolicy Bypass -File tools\offsite_backup.ps1
# Планувальник (нд 12:00) реєструється один раз — див. README нижче по файлу.

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$key  = Join-Path $root "key\<приватний-ключ>.key"
$dest = Join-Path $root "db-offsite"
$srv  = "ubuntu@<IP-сервера>"

if (-not (Test-Path $dest)) { New-Item -ItemType Directory $dest | Out-Null }

# 1) ім'я найсвіжішого gz-бекапу на сервері
$newest = & ssh -i $key -o ConnectTimeout=20 $srv "ls -t /opt/wowukraine/db-backups/editor-2*.db.gz | head -1"
if (-not $newest) { throw "не знайдено бекапів на сервері" }
$name = Split-Path $newest -Leaf

# 2) скачати, якщо ще нема
$local = Join-Path $dest $name
if (Test-Path $local) {
    Write-Host "вже є: $name"
} else {
    & scp -i $key -o ConnectTimeout=20 "${srv}:$newest" $local
    Write-Host "скачано: $name ($([math]::Round((Get-Item $local).Length/1MB)) MB)"
}

# 3) ретенція: останні 8 копій
Get-ChildItem $dest -Filter "editor-*.db.gz" | Sort-Object LastWriteTime -Descending |
    Select-Object -Skip 8 | ForEach-Object { Remove-Item $_.FullName -Confirm:$false; Write-Host "видалено старе: $($_.Name)" }

Write-Host "OK: offsite-бекапів локально: $((Get-ChildItem $dest -Filter 'editor-*.db.gz').Count)"
