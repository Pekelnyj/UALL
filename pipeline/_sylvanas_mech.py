# -*- coding: utf-8 -*-
"""Механічна і->и для ВІДМІНЮВАНИХ форм Sylvanas (не чіпаючи -ас стале і Sylvanaar)."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))

# лукахед: не літера далі (щоб НЕ чіпати Сільванас, Сільванаар, Сільванами тощо складніше)
NL = r"(?![а-яА-ЯіїєґІЇЄҐ'])"
REPL = [
    (re.compile("Сільвана" + NL), "Сильвана"),
    (re.compile("Сільвани" + NL), "Сильвани"),
    (re.compile("Сільвану" + NL), "Сильвану"),
    (re.compile("Сільвані" + NL), "Сильвані"),
    (re.compile("Сільваною" + NL), "Сильваною"),
    (re.compile("Сільвано" + NL), "Сильвано"),
    (re.compile("Сільванни" + NL), "Сильвани"),   # одрук подвоєння
    (re.compile("Сільванну" + NL), "Сильвану"),
]

cnt = 0
def fix(s):
    global cnt
    for rx, rep in REPL:
        s, n = rx.subn(rep, s)
        cnt += n
    return s


def walk(v):
    if isinstance(v, dict):
        return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list):
        return [walk(x) for x in v]
    if isinstance(v, str):
        return fix(v)
    return v


tr2 = walk(tr)
TR.write_text(json.dumps(tr2, ensure_ascii=False, indent=1), encoding="utf-8")
print("механічних і->и замін:", cnt)

# контроль: лишилось Сільван- (і) не-аар
text = json.dumps(tr2, ensure_ascii=False)
from collections import Counter
rest = Counter(re.findall(r"Сільван(?!аар)\w*", text))
print("ЛИШИЛОСЬ і-форм (не Sylvanaar):", sum(rest.values()))
for w, n in rest.most_common(): print(f"  {n}  {w}")
