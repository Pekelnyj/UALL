# -*- coding: utf-8 -*-
"""Полагодити зламані '(M:F)' без $p (залишки bash-бага) → '$p(M:F)'."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))
DOL = "$"
# '(M:F)' де M,F кириличні слова, БЕЗ '$p' перед '(' → '$p(M:F)'
BROKEN = re.compile(r"(?<![$\w])\(([А-Яа-яІЇЄҐіїєґ' ]+):([А-Яа-яІЇЄҐіїєґ' ]+)\)")
n = 0


def fix(s):
    global n
    def r(m):
        global n
        n += 1
        return DOL + "p(" + m.group(1) + ":" + m.group(2) + ")"
    return BROKEN.sub(r, s)


def walk(v):
    if isinstance(v, str):
        return fix(v)
    if isinstance(v, dict):
        return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list):
        return [walk(x) for x in v]
    return v


# зразки до фіксу
samp = [m.group(0) for m in BROKEN.finditer(json.dumps(tr["quests"], ensure_ascii=False))][:6]
print("зразки зламаних:", samp)
tr = walk(tr)
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
blob = json.dumps(tr, ensure_ascii=False)
print("полагоджено:", n)
print("зламаних лишилось:", len([1 for _ in BROKEN.finditer(blob)]))
print("усього $p( :", blob.count(DOL + "p("))
