# -*- coding: utf-8 -*-
"""Змерджити переклади журналу з батчів + валідація цілісності (коди, втрати)."""
import json
import sys
import re
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
IN = B / "data/_journal_in"
OUT = B / "data/_journal_out"

tr = json.loads(TR.read_text(encoding="utf-8-sig"))
jst = tr.setdefault("journalSections", {})

merged = 0
warns = []
for i in range(1, 19):
    inf = IN / f"batch_{i:02d}.json"
    outf = OUT / f"batch_{i:02d}.json"
    if not outf.exists():
        warns.append(f"batch_{i:02d}: НЕМА вихідного файлу!")
        continue
    src = json.loads(inf.read_text(encoding="utf-8-sig"))
    want = set(src["sections"])
    got = json.loads(outf.read_text(encoding="utf-8-sig"))
    missing = want - set(got)
    extra = set(got) - want
    if missing:
        warns.append(f"batch_{i:02d}: пропущено {len(missing)} секцій")
    if extra:
        warns.append(f"batch_{i:02d}: {len(extra)} зайвих ключів")
    # валідація кодів на кожному рядку
    code_bad = 0
    for en, ua in got.items():
        if not isinstance(ua, str) or not ua.strip():
            code_bad += 1; continue
        if en.count("$bullet;") != ua.count("$bullet;"):
            code_bad += 1
        elif en.count("\r\n") != ua.count("\r\n"):
            code_bad += 1
        elif en.count("[") != ua.count("[") or en.count("]") != ua.count("]"):
            code_bad += 1
    if code_bad:
        warns.append(f"batch_{i:02d}: {code_bad} рядків із розбіжністю кодів ($bullet;/\\r\\n/[])")
    # мердж
    for en, ua in got.items():
        if isinstance(ua, str) and ua.strip():
            jst[en] = ua
            merged += 1

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Змерджено: {merged} | journalSections тепер: {len(jst):,}")
if warns:
    print("ПОПЕРЕДЖЕННЯ:")
    for w in warns:
        print("  -", w)
else:
    print("Валідація: без зауважень.")
