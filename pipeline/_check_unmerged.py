# -*- coding: utf-8 -*-
"""ГЕЙТ: чи є перекладене, що НЕ доїхало до бази.

Підозра юзера 28.08: «перекладаємо, не пишемо в базу і перекладаємо знову».
Вона має підстави — того ж дня знайшлося, що 64 з 75 «неперекладених» імен
NPC лежали у виходах хвиль, а `_merge_uitt_wave.py` мовчки підхоплював
застарілі out-файли.

Тут дивимось на ВСІ виходи агентів (data/batches/**/out_*.json) і питаємо:
чи є цей ключ бодай десь у базі. Якщо ні — переклад зроблено, гроші й час
витрачено, а в грі його немає.

Ключ виходу буває двох видів: англійський рядок або ID — перевіряємо обидва.

Запуск: python _check_unmerged.py [--list]
"""
import glob
import json
import sys
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

LIST = "--list" in sys.argv
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
ALL = set()
for sec, d in tr.items():
    if isinstance(d, dict):
        ALL |= {str(k) for k in d}

# Broadcast.lua — окремий майстер, його ключів у translations може не бути
import re
CYR = re.compile(r"[А-Яа-яІіЇїЄєҐґ]")
bl = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
if bl.exists():
    txt = bl.read_text(encoding="utf-8")
    for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]\s*=', txt):
        ALL.add(m.group(1).replace('\\"', '"').replace("\\n", "\n"))

VALUES = set()
for _sec, _d in tr.items():
    if isinstance(_d, dict):
        for _v in _d.values():
            if isinstance(_v, str):
                VALUES.add(_v)
merged_elsewhere = []

files = sorted(glob.glob(str(DATA_DIR / "batches" / "**" / "out_*.json"),
                         recursive=True))
files += sorted(glob.glob(str(DATA_DIR / "tester_new" / "*.json")))
print(f"файлів-виходів: {len(files)}\n")

rows, total_missing, total_seen = [], 0, 0
missing_by_file = defaultdict(list)
for f in files:
    try:
        d = json.loads(Path(f).read_text(encoding="utf-8"))
    except (OSError, ValueError):
        continue
    if not isinstance(d, dict):
        continue
    miss = []
    for k, v in d.items():
        # Рахуємо лише СПРАВЖНІ переклади. Серед виходів лежать і робочі мапи
        # (toyeffect_itemmap, toysrc_segments), де значення — англійський
        # текст або службові дані; зарахувати їх у «втрачений переклад» було б
        # вигадкою. Ознака перекладу — кирилиця у значенні.
        s = v if isinstance(v, str) else (
            v.get("ua") if isinstance(v, dict) else None)
        if not isinstance(s, str) or not CYR.search(s):
            continue
        total_seen += 1
        ks = str(k)
        # ключ може бути рядком або ID; \n у батчах буває літеральним
        if ks in ALL or ks.replace("\\n", "\n") in ALL:
            continue
        # Ключа немає — але переклад міг доїхати ПІД ІНШИМ ключем (класична
        # діра ID проти назви). Тоді це не втрата, а лише розбіжність ключів.
        if s in VALUES:
            merged_elsewhere.append((ks, s))
            continue
        miss.append((ks, s))
    if miss:
        rows.append((Path(f).name, len(d), len(miss)))
        missing_by_file[Path(f).name] = miss
        total_missing += len(miss)

rows.sort(key=lambda r: -r[2])
print(f"{'файл':<40}{'усього':>8}{'НЕ в базі':>11}")
print("-" * 60)
for name, n, m in rows[:30]:
    print(f"{name:<40}{n:>8}{m:>11}")
print("-" * 60)
print(f"{'РАЗОМ':<40}{total_seen:>8}{total_missing:>11}")
print(f"злито ПІД ІНШИМ ключем (не втрата): {len(merged_elsewhere)}")

if LIST:
    for name, miss in list(missing_by_file.items())[:6]:
        print(f"\n=== {name} ===")
        for k, v in miss[:10]:
            print(f"  {k[:56]}")
            print(f"     -> {v[:56]}")
sys.exit(1 if total_missing else 0)
