# -*- coding: utf-8 -*-
"""Генератор ТЕСТЕРСЬКОЇ збірки UALL для temnozelena.com.

Тестерська = аддон ЯК Є (ns.PUBLIC=false, усі збирачі текстів працюють,
UALLCaptureDB зберігається) — на відміну від публічної (pipeline/build_public.py).
Скрипт лише копіює в build/ і пакує; репозиторій не змінює. Версія — з .toc.

Запуск:  python pipeline/build_tester.py
Результат:  build/tester/<аддони> + build/UALL-tester-<версія>.zip
"""
import os, re, sys, shutil, zipfile
sys.stdout.reconfigure(encoding="utf-8")

# Гейти перед збіркою (07.10.2026): архів не збирається з червоним гейтом — див. release_gates.py
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from release_gates import run_or_exit  # noqa: E402
run_or_exit()

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
SRC = os.path.join(ROOT, "addon")
OUT = os.path.join(ROOT, "build", "tester")
ADDONS = ["UALL", "UALL_Items", "UALL_Journal", "UALL_NpcNames"]

# версія з головного .toc
toc = open(os.path.join(SRC, "UALL", "UALL.toc"), encoding="utf-8").read()
m = re.search(r"(?m)^##\s*Version:\s*(.+)$", toc)
VERSION = m.group(1).strip() if m else "0.0.0"

# гра читає лише .lua/.toc/.xml/асети — README/docs/дев-мотлох не тягнемо
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
print("скопійовано аддонів:", len(ADDONS), "| версія:", VERSION)

# Назва за конвенцією сервера editor/app.py _latest_release(): «UALL-<версія>.zip»
# (кладеться в /opt/wowukraine/editor/releases/, /download віддає найновіший).
zip_path = os.path.join(ROOT, "build", f"UALL-{VERSION}.zip")
with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
    for a in ADDONS:
        base = os.path.join(OUT, a)
        for dirpath, _, files in os.walk(base):
            for fn in files:
                full = os.path.join(dirpath, fn)
                rel = os.path.relpath(full, OUT)  # корінь архіву = папки аддонів
                z.write(full, rel)
size_mb = os.path.getsize(zip_path) / 1024 / 1024
print(f"\n✅ ТЕСТЕРСЬКА збірка готова: {zip_path} ({size_mb:.1f} МБ)")
print(f"   Зі збирачами (ns.PUBLIC=false, UALLCaptureDB) — для тестерів на temnozelena.com")
