# -*- coding: utf-8 -*-
"""Застосувати QA-фікси по діалогах тестера 24."""
import json, glob, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
P = B / "data/translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
gos, bro = tr["gossip"], tr["broadcast"]

fixes = []
for f in sorted(glob.glob(str(B / "data/_qa24_out/q_*.json"))):
    for x in json.loads(Path(f).read_text(encoding="utf-8")):
        if x.get("fix"):
            fixes.append((x["en"], x["fix"]))

ok, miss = 0, []
for en, fix in fixes:
    if en in gos:
        gos[en] = fix; ok += 1; print(f"  ✓ [gossip] {en[:50]}")
    elif en in bro:
        bro[en] = fix; ok += 1; print(f"  ✓ [broadcast] {en[:50]}")
    else:
        miss.append(en)

# додаткова уніфікація Фурґ→Фург у нових діалогах (рульове h→г, база майже навпіл)
import re
def furg(s): return re.sub(r"Фурґ", "Фург", s) if isinstance(s, str) else s
nf = 0
for d in (gos, bro):
    for k in list(d):
        nv = furg(d[k])
        if nv != d[k]:
            d[k] = nv; nf += 1

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\nзастосовано фіксів: {ok} | Фурґ→Фург: {nf} | не знайдено: {miss}")
