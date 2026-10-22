# -*- coding: utf-8 -*-
"""Збірка релізу: zip УСІХ аддонів (головний + LoD) у release/WoWUkraine-<version>.zip.

- Пакує кожну підпапку addon/ з .toc як окрему теку верхнього рівня
  (WoWUkraine/, WoWUkraine_Items/, WoWUkraine_NpcNames/, WoWUkraine_Journal/) —
  розпаковується прямо в Interface/AddOns/.
- Версія береться з ## Version головного WoWUkraine.toc.
- Виключає сміття (.bak, .py, __pycache__, тимчасові).

Запуск: python pipeline/build_release.py
"""
import re, sys, zipfile
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
ADDON_ROOT = ROOT / "addon"
RELEASE = ROOT / "release"

# ГОЛОВНИЙ аддон = папка з .toc БЕЗ ## LoadOnDemand (ім'я не зашите — авто-визначення).
def _find_main_toc():
    for d in sorted(ADDON_ROOT.iterdir()):
        if not d.is_dir():
            continue
        for toc in d.glob("*.toc"):
            if "## LoadOnDemand" not in toc.read_text(encoding="utf-8-sig"):
                return toc
    raise FileNotFoundError("Не знайдено головного .toc (без LoadOnDemand) у addon/")

MAIN = _find_main_toc()
MAIN_NAME = MAIN.parent.name
version = re.search(r"##\s*Version:\s*(\S+)", MAIN.read_text(encoding="utf-8")).group(1)

EXCLUDE_EXT = (".bak", ".py", ".pyc", ".tmp", "~", ".orig", ".bak2")


def keep(p: Path) -> bool:
    if any(p.name.endswith(e) for e in EXCLUDE_EXT):
        return False
    if "__pycache__" in p.parts:
        return False
    return True


# Перед-реліз запобіжник: ніки гравців у реліз-рядках (мали б бути {NAME}).
# Попереджаємо, але НЕ блокуємо (можливі хибні збіги з ігровими словами).
import subprocess
chk = subprocess.run([sys.executable, str(Path(__file__).parent / "_check_playernames.py")],
                     capture_output=True, text=True, encoding="utf-8")
if chk.returncode == 1:
    print("\n" + "!" * 60)
    print("УВАГА: знайдено ніки гравців у реліз-рядках (перевір перед роздачею):")
    print(chk.stdout.split("ЗНАЙДЕНО", 1)[-1][:1500] if "ЗНАЙДЕНО" in chk.stdout else chk.stdout[-1500:])
    print("!" * 60 + "\n")

# усі папки аддонів (з .toc усередині)
folders = sorted(d for d in ADDON_ROOT.iterdir()
                 if d.is_dir() and list(d.glob("*.toc")))

RELEASE.mkdir(exist_ok=True)
out = RELEASE / f"{MAIN_NAME}-{version}.zip"
total = 0
with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
    for d in folders:
        files = sorted(p for p in d.rglob("*") if p.is_file() and keep(p))
        total += len(files)
        for p in files:
            z.write(p, d.name + "/" + p.relative_to(d).as_posix())
        print(f"  + {d.name}: {len(files)} файлів")

print(f"Версія: {version}")
print(f"Аддонів: {len(folders)} | Файлів: {total}")
print(f"-> {out.name} ({out.stat().st_size // 1024} KB)")
