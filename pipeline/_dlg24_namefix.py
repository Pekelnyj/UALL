# -*- coding: utf-8 -*-
"""Уніфікація імен у нових діалогах тестера 24 до домінантної форми бази."""
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))

# (хибна/меншість -> канон), з межами слова
FIX = [
    (r"Декімус", "Децимус"),     # явна помилка (1 проти 53)
    (r"Ліладжу", "Лілажу"),      # 5 -> 10
    (r"\bФліг\b", "Фліґ"),       # 2 -> 4
    (r"\bІдаго\b", "Ідаґо"),     # 8 -> 11
]
cnt = {}
def fix(s):
    for pat, rep in FIX:
        new, n = re.subn(pat, rep, s)
        if n:
            cnt[pat] = cnt.get(pat, 0) + n
            s = new
    return s
def walk(v):
    if isinstance(v, str): return fix(v)
    if isinstance(v, dict): return {k: walk(x) for k, x in v.items()}
    if isinstance(v, list): return [walk(x) for x in v]
    return v
tr = walk(tr)
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("уніфіковано:", sum(cnt.values()))
for k, v in cnt.items(): print(f"  {k}: {v}")
