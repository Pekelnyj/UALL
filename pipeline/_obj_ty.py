# -*- coding: utf-8 -*-
"""Об'єктиви квестів: звертання до гравця «ви»→«ти» (імператив мн.→одн.).
Стандарт глосарію п.3 = «ти». Застосовуємо лише до поля objectives."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))

# (закінчення мн.імператива → одн.) — ПОРЯДОК: довші/рефлексивні перші
ENDS = [
    ("айтеся", "айся"), ("ийтеся", "ийся"), ("ньтеся", "нься"), ("іться", "ися"),
    ("йтеся", "йся"), ("ьтеся", "ься"), ("теся", "ся"),
    ("айте", "ай"), ("ийте", "ий"), ("ійте", "ій"), ("ньте", "нь"),
    ("їте", "ї"), ("іть", "и"), ("їть", "ї"), ("йте", "й"), ("ьте", "ь"),
]
# перелік слів, які НЕ чіпати (іменники/інше на -іть/-те, не імператив)
SKIP = {"мить", "повість", "користь", "вісьте"}

word = re.compile(r"\b([А-ЯҐЄІЇа-яґєії']{3,})\b")
cnt = [0]


def conv_word(w):
    lw = w.lower()
    if lw in SKIP:
        return w
    for a, b in ENDS:
        if lw.endswith(a) and len(lw) > len(a) + 1:
            cnt[0] += 1
            stem = w[: len(w) - len(a)]
            return stem + b
    return w


# слова-маркери імператива мн. (щоб не зачепити теперішній час типу «знаєте»)
IMP = re.compile(r"(іть|їть|айте|ийте|ійте|ньте|йте|ьте|теся|іться|айтеся|ньтеся)\b", re.I)


def fix(s):
    # конвертуємо лише слова з імперативним мн.-закінченням
    def r(m):
        w = m.group(1)
        if IMP.search(w):
            return conv_word(w)
        return w
    return word.sub(r, s)


n = 0
for qid, q in tr.get("quests", {}).items():
    if not isinstance(q, dict):
        continue
    o = q.get("objectives")
    if isinstance(o, str) and o.strip() and IMP.search(o):
        no = fix(o)
        if no != o:
            q["objectives"] = no
            n += 1

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"об'єктивів змінено: {n} | слів конвертовано: {cnt[0]}")
# контроль: лишок «ви»-імперативів у об'єктивах
left = 0
samp = []
for qid, q in tr["quests"].items():
    if isinstance(q, dict):
        o = q.get("objectives", "")
        if isinstance(o, str):
            for m in re.finditer(r"\b\w+(?:іть|айте|ньте)\b", o):
                left += 1
                if len(samp) < 8:
                    samp.append(m.group(0))
print("лишок (перевір — можуть бути іменники):", left, samp)
