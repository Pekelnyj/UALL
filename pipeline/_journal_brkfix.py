# -*- coding: utf-8 -*-
"""Прибрати зайві [дужки], додані агентами там, де в EN їх не було.
Правило: к-сть дужок у UA має дорівнювати EN. Де EN=0 дужок -> прибираємо всі з UA."""
import json
import sys
import re
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
OUT = B / "data/_journal_out"

tr = json.loads(TR.read_text(encoding="utf-8-sig"))
jst = tr["journalSections"]

fixed = 0
skipped = []
for i in range(1, 19):
    outf = OUT / f"batch_{i:02d}.json"
    got = json.loads(outf.read_text(encoding="utf-8-sig"))
    dirty = False
    for en, ua in list(got.items()):
        if not isinstance(ua, str):
            continue
        if en.count("[") == ua.count("[") and en.count("]") == ua.count("]"):
            continue
        if en.count("[") == 0 and en.count("]") == 0:
            new = ua.replace("[", "").replace("]", "")
            got[en] = new
            jst[en] = new
            fixed += 1
            dirty = True
        else:
            skipped.append((i, en[:60]))
    if dirty:
        outf.write_text(json.dumps(got, ensure_ascii=False, indent=1), encoding="utf-8")

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Виправлено (прибрано зайві дужки): {fixed}")
if skipped:
    print(f"Пропущено (EN має дужки, треба руч.): {len(skipped)}")
    for i, s in skipped[:10]:
        print(f"   batch {i}: {s!r}")
else:
    print("Усі розбіжності дужок усунено.")
