# -*- coding: utf-8 -*-
"""Застосувати агентські токени вокативів/прикметників (id|field -> текст) + валідація."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
P = B / "data/translations.json"
T = B / "data/tester_new"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
q = tr["quests"]

applied, miss, bad = 0, 0, 0
TOKEN = "$" + "p("
BROKEN = re.compile(r"(?<![$\w])\([А-Яа-яІЇЄҐіїєґ' ]+:[А-Яа-яІЇЄҐіїєґ' ]+\)")
GOOD = re.compile(r"\$p\([^)]*:[^)]*\)")

for i in range(1, 13):
    f = T / f"voc_out_{i}.json"
    if not f.exists():
        continue
    d = json.loads(f.read_text(encoding="utf-8-sig"))
    for key, text in d.items():
        if not isinstance(text, str) or "|" not in key:
            continue
        qid, fld = key.split("|", 1)
        # валідація: нема зламаних (X:Y) без $p
        if BROKEN.search(text):
            bad += 1
            continue
        if qid in q and isinstance(q[qid], dict) and fld in q[qid]:
            q[qid][fld] = text
            applied += 1
        else:
            miss += 1

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"застосовано: {applied} | промахів: {miss} | відкинуто(зламані): {bad}")

# глобальна валідація всіх квестів
blob = json.dumps(q, ensure_ascii=False)
print("усього $p( у квестах:", blob.count(TOKEN))
broken_left = [m.group(0) for m in BROKEN.finditer(blob)][:5]
print("зламаних (X:Y) без $p у базі:", len([1 for _ in BROKEN.finditer(blob)]), broken_left)
