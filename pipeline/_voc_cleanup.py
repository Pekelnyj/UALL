# -*- coding: utf-8 -*-
"""Відкотити помилкові токени-прикметники (смертн*) — це не звертання до гравця.
Лишаємо лише надійні вокатив-форми (герою/чужинцю/мандрівнику…) + дієслова + агентські."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))

# $p(M:F) де M починається на 'смертн' → лишити M (відкат). Регістр зберігаємо.
TOK = re.compile(r"\$p\((смертн[А-Яа-яІЇЄҐіїєґ]*):([А-Яа-яІЇЄҐіїєґ]+)\)")
n = 0


def fix(s):
    global n
    def r(m):
        global n
        n += 1
        return m.group(1)
    return TOK.sub(r, s)


def walk(v):
    if isinstance(v, str):
        return fix(v)
    if isinstance(v, dict):
        return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list):
        return [walk(x) for x in v]
    return v


tr = walk(tr)
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
blob = json.dumps(tr, ensure_ascii=False)
print("відкочено смертн-токенів:", n)
print("усього $p( лишилось:", blob.count("$" + "p("))
# контроль: які ще прикметники-форми могли потрапити (одинокі ризики)
risky = re.findall(r"\$p\((радий|готовий|певен|сам)\b[^)]*\)", blob)
print("прикметник-токени (радий/готовий/певен/сам, перевір):", len(risky))
