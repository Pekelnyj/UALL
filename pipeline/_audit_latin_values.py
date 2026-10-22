# -*- coding: utf-8 -*-
"""Знайти «фейкові переклади»: UA-значення латиницею без кирилиці (англ. дубль)."""
import json
import re
import sys
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))

CYR = re.compile(r"[А-Яа-яІЇЄҐіїєґ]")
LAT = re.compile(r"[A-Za-z]")
# код/абревіатура: майже все — крапки, цифри, великі літери (DPS, A.F.M.O.D., VX-001)
def is_code(s):
    letters = re.sub(r"[^A-Za-z]", "", s)
    if not letters:
        return True
    # абревіатура з крапок, або суцільні великі, або з цифрами-ID
    if re.fullmatch(r"[A-Z0-9.\-_/ ]+", s):
        return True
    return False


JUNK = re.compile(r"\[DN[TD]\]|<DN[TD]>|\[dnt\]|\[PH\]|\bPlaceholder\b|\$@spelldesc|"
                  r"^\d+\.\d+|Generic Bunny|Dust Bunny|\(JSB\)|\(PRK\)|Industrial Light|"
                  r"\bTest\b|\bDEPRECATED\b|\bUNUSED\b|^\d+of\d+|\|T|\|c|Monster -|"
                  r"Curio -|iLevel|Item Level|zzOLD|^QA |Debug|TESTING", re.I)


def is_junk(s):
    return bool(JUNK.search(s))


def walk(v, path=()):
    if isinstance(v, str):
        yield path, v
    elif isinstance(v, dict):
        for k, x in v.items():
            yield from walk(x, path + (k,))
    elif isinstance(v, list):
        for j, x in enumerate(v):
            yield from walk(x, path + (j,))


bad_by_sec = Counter()
examples = {}
total = 0
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for path, val in walk(d):
        if not isinstance(val, str) or not val.strip():
            continue
        if LAT.search(val) and not CYR.search(val) and not is_code(val) and not is_junk(val):
            bad_by_sec[sec] += 1
            total += 1
            examples.setdefault(sec, []).append((path[0] if path else "", val))

print(f"«ФЕЙКОВИХ» (латиниця без кирилиці, не код): {total}\n")
print(f"{'Розділ':<18}{'к-сть':>7}")
print("-" * 30)
for sec, n in bad_by_sec.most_common():
    print(f"{sec:<18}{n:>7}")
print("\n=== приклади (топ-розділи) ===")
for sec, n in bad_by_sec.most_common(6):
    print(f"\n[{sec}]")
    for key, val in examples[sec][:5]:
        print(f"   {str(key)[:35]:<37} -> {val[:45]}")
