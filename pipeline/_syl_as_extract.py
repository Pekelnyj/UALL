# -*- coding: utf-8 -*-
"""Рекурсивно зібрати УНІКАЛЬНІ рядки з «Сільванас/Сильванас» (стале -ас) на контекстну правку."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
AS = re.compile(r"[СC][іи]льванас")

strings = set()
def walk(v):
    if isinstance(v, str):
        if AS.search(v):
            strings.add(v)
    elif isinstance(v, dict):
        for x in v.values():
            walk(x)
    elif isinstance(v, list):
        for x in v:
            walk(x)
walk(tr)

out = [{"idx": i, "ua": s} for i, s in enumerate(sorted(strings))]
(B / "data/_syl_as.json").write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"унікальних рядків із -ас: {len(out)}")
for o in out[:8]:
    print("  ", repr(o["ua"][:90]))
