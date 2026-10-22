# -*- coding: utf-8 -*-
"""Скільки GameObject-назв ми ВЖЕ маємо перекладені (ловили в грі) vs реально нових."""
import json
import re
import sys
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
R = Path("g:/Claude Code/WoWUkraine")

go = json.load(open(R / "data/source/gameobjects.json", encoding="utf-8-sig"))
tr = json.load(open(R / "data/translations.json", encoding="utf-8-sig"))


def junk(n):
    if "_" in n or n in ("Generic", "", "???"):
        return True
    if re.search(r"\d+\.\d|\d+xp|\bZ\d\b", n):
        return True
    if re.search(r"(?i)\bprops?\b|\bphase\b|\bDND\b|\bDNT\b|\[|placeholder|\(TESTING\)|\bWIP\b|\bunused\b", n):
        return True
    if re.search(r"[a-z][A-Z]", n) and " " not in n:
        return True
    if re.fullmatch(r"[\d\s]+", n):
        return True
    return False


# унікальні справжні назви об'єктів
real = {v["name"]["en"] for v in go.values() if v.get("name", {}).get("en") and not junk(v["name"]["en"])}

# мапа: EN-рядок -> у яких секціях він уже перекладений (EN-ключові секції)
en_to_sec = {}
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in d.items():
        if not str(k).isdigit() and isinstance(v, str) and v.strip():   # EN-ключ -> UA
            en_to_sec.setdefault(k, set()).add(sec)

have = real & set(en_to_sec)
new = real - set(en_to_sec)

print(f"Справжніх унікальних GameObject-назв: {len(real)}")
print(f"  ВЖЕ маємо переклад: {len(have)}")
print(f"  РЕАЛЬНО нових (нема ніде): {len(new)}")
print()
print("=== звідки вже маємо (по секціях) ===")
src = Counter()
for n in have:
    for s in en_to_sec[n]:
        src[s] += 1
for s, c in src.most_common():
    print(f"  {c:>4}  {s}")
print()
print("=== приклади РЕАЛЬНО нових (перші 30) ===")
for n in sorted(new)[:30]:
    print("  ", n)
