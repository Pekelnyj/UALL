# -*- coding: utf-8 -*-
"""Генератор ПУБЛІЧНОЇ збірки UALL для CurseForge.

Тестерська (dev) версія — це репозиторій як є: ns.PUBLIC=false, усі збирачі
текстів працюють, UALLCaptureDB зберігається. Публічна збірка НЕ має збирачів:
  • ns.PUBLIC → true (GetCaptureDB віддає викидну таблицю, Diag/лог помилок/
    детектор taint/секція «Збір текстів»/Capture.lua вимкнені гейтами в коді);
  • з .toc прибрано UALLCaptureDB зі SavedVariables → нічого не зберігається;
  • версія всіх .toc → PUB_VERSION.
Скрипт нічого не змінює в самому репозиторії — лише копіює в build/ і трансформує.

Запуск:  python pipeline/build_public.py
Результат:  build/public/<аддони> + build/UALL-<версія>.zip
"""
import os, re, sys, shutil, zipfile
sys.stdout.reconfigure(encoding="utf-8")

# Гейти перед збіркою (07.10.2026): архів не збирається з червоним гейтом — див. release_gates.py
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from release_gates import run_or_exit  # noqa: E402
run_or_exit()

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
SRC = os.path.join(ROOT, "addon")
OUT = os.path.join(ROOT, "build", "public")
ADDONS = ["UALL", "UALL_Items", "UALL_Journal", "UALL_NpcNames"]
PUB_VERSION = "0.1.11"

def read(p):
    return open(p, encoding="utf-8").read()

def write(p, s):
    open(p, "w", encoding="utf-8", newline="").write(s)

def set_field(s, key, val):
    """Замінити рядок '## key: ...' у .toc або вставити після '## Interface:'."""
    pat = r"(?m)^(##\s*" + re.escape(key) + r":\s*).*$"
    if re.search(pat, s):
        return re.sub(pat, lambda m: m.group(1) + val, s, count=1)
    lines = s.splitlines(keepends=True)
    for i, ln in enumerate(lines):
        if ln.startswith("## Interface:"):
            lines.insert(i + 1, "## %s: %s\n" % (key, val))
            return "".join(lines)
    return "## %s: %s\n" % (key, val) + s

# Метадані ПУБЛІЧНОЇ версії (dev-.toc не чіпаємо — там лишається тестерська «UALL»).
PUB_TITLE  = "UALL — Українська локалізація"
PUB_AUTHOR = "Pekelnyj"
PUB_SITE   = "https://temnozelena.com"

# 1) чиста копія аддонів у build/public/ (БЕЗ файлів, непотрібних грі: README/docs/
# дев-мотлох — краще не мати, ніж застаріле). Гра читає лише .lua/.toc/.xml/асети.
IGNORE = shutil.ignore_patterns(
    "README*", "readme*", "*.md", "*.txt", "LICENSE*", "CHANGELOG*",
    ".git*", "__pycache__", "*.py", "*.bak", "*.orig", ".DS_Store", "Thumbs.db")
if os.path.exists(OUT):
    shutil.rmtree(OUT)
os.makedirs(OUT)
for a in ADDONS:
    src = os.path.join(SRC, a)
    if not os.path.isdir(src):
        print(f"!! немає {src} — пропускаю"); continue
    shutil.copytree(src, os.path.join(OUT, a), ignore=IGNORE)
print("скопійовано аддонів:", len(ADDONS))

# 2) UALL/Core.lua — увімкнути прапорець публічної збірки
core = os.path.join(OUT, "UALL", "Core.lua")
s = read(core)
new, n = re.subn(r"ns\.PUBLIC\s*=\s*false(\s*--\s*@BUILD-PUBLIC-FLAG@)",
                 r"ns.PUBLIC = true\1", s)
assert n == 1, f"маркер @BUILD-PUBLIC-FLAG@ не знайдено/не унікальний (n={n})"
write(core, new)
print("Core.lua: ns.PUBLIC → true")

# 3) UALL.toc — прибрати UALLCaptureDB зі SavedVariables + вилизати метадані
toc = os.path.join(OUT, "UALL", "UALL.toc")
s = read(toc)
s = set_field(s, "SavedVariables", "UALLSettingsDB")
assert "UALLCaptureDB" not in s, "UALLCaptureDB лишився у .toc"
s = set_field(s, "Title", PUB_TITLE)
s = set_field(s, "Author", PUB_AUTHOR)
s = set_field(s, "X-Website", PUB_SITE)
write(toc, s)
print(f"UALL.toc: SavedVariables=UALLSettingsDB, Title/Author/X-Website оновлено")

# 4) версія + Author усіх .toc (суб-аддони теж — консистентність)
for a in ADDONS:
    d = os.path.join(OUT, a)
    for f in os.listdir(d):
        if f.endswith(".toc"):
            p = os.path.join(d, f)
            s = read(p)
            s = set_field(s, "Version", PUB_VERSION)
            s = set_field(s, "Author", PUB_AUTHOR)
            write(p, s)
print(f"версія всіх .toc → {PUB_VERSION}, Author → {PUB_AUTHOR}")

# 5) zip для CurseForge (аддон-теки в корені архіву)
zip_path = os.path.join(ROOT, "build", f"UALL-{PUB_VERSION}.zip")
with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
    for a in ADDONS:
        base = os.path.join(OUT, a)
        for dirpath, _, files in os.walk(base):
            for fn in files:
                full = os.path.join(dirpath, fn)
                rel = os.path.relpath(full, OUT)  # корінь архіву = папки аддонів
                z.write(full, rel)
size_mb = os.path.getsize(zip_path) / 1024 / 1024
print(f"\n✅ ПУБЛІЧНА збірка готова: {zip_path} ({size_mb:.1f} МБ)")
print(f"   Розпаковується в Interface/AddOns/ ({', '.join(ADDONS)})")
