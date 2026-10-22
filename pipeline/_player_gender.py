# -*- coding: utf-8 -*-
"""Вставити токени статі гравця $p(чол:жін) у звертання до гравця (2-га особа).
БЕЗПЕЧНІ патерни: 'ти <дієслово-в>' = однозначно гравець. Вокативи/прикметники — окремо."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
p = B / "data/translations.json"
tr = json.loads(p.read_text(encoding="utf-8-sig"))

VOWEL = "аяиіуїео"
# 1) рефлексивні: ти X-вся → ти X-$p(вся:лася)   (бився→би$p(вся:лася))
REFL = re.compile(r"(\bти\s+(?:не\s|вже\s|щойно\s|так\sі\s|ледь\s)?\w*?)вся\b")
# 2) минулий чол.: ти X-[голосна]в → ти X-$p(в:ла)
PAST = re.compile(r"(\bти\s+(?:не\s|вже\s|щойно\s|так\sі\s|ледь\s)?\w*?[" + VOWEL + r"])в\b")
# 3) прикметники/стан після 'ти'
ADJ = [
    (re.compile(r"\bти\s+готовий\b"), "ти готов$p(ий:а)"),
    (re.compile(r"\bти\s+радий\b"), "ти $p(радий:рада)"),
    (re.compile(r"\bти\s+певен\b"), "ти $p(певен:певна)"),
    (re.compile(r"\bти\s+сам\b"), "ти $p(сам:сама)"),
    (re.compile(r"\bти\s+вдячний\b"), "ти вдячн$p(ий:а)"),
    (re.compile(r"\bти\s+змушений\b"), "ти змушен$p(ий:а)"),
    (re.compile(r"\bти\s+упевнений\b"), "ти упевнен$p(ий:а)"),
    (re.compile(r"\bти\s+здатний\b"), "ти здатн$p(ий:а)"),
    (re.compile(r"\bти\s+щасливий\b"), "ти щаслив$p(ий:а)"),
]

cnt = {"refl": 0, "past": 0, "adj": 0}


def fix(s):
    if "ти " not in s:
        return s
    def r1(m):
        cnt["refl"] += 1
        return m.group(1) + "$p(вся:лася)"
    s = REFL.sub(r1, s)
    def r2(m):
        cnt["past"] += 1
        return m.group(1) + "$p(в:ла)"
    s = PAST.sub(r2, s)
    for rx, repl in ADJ:
        s, n = rx.subn(repl, s)
        cnt["adj"] += n
    return s


nq = 0
for qid, q in tr.get("quests", {}).items():
    if not isinstance(q, dict):
        continue
    changed = False
    for f in ("title", "description", "progress", "completion", "objectives"):
        v = q.get(f)
        if isinstance(v, str) and "ти " in v and "$p(" not in v:
            nv = fix(v)
            if nv != v:
                q[f] = nv
                changed = True
    if changed:
        nq += 1

p.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"квестів змінено: {nq} | токенів: рефлекс={cnt['refl']} минулий={cnt['past']} прикм={cnt['adj']}")
# приклади
ex = 0
for qid, q in tr["quests"].items():
    if isinstance(q, dict):
        for f in ("description", "progress", "completion"):
            v = q.get(f, "")
            if isinstance(v, str) and "$p(" in v and ex < 6:
                m = re.search(r".{20}\$p\([^)]*\).{10}", v)
                if m:
                    print("  ", m.group())
                    ex += 1
