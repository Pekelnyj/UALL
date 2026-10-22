# -*- coding: utf-8 -*-
"""Доперекласти англійські [дужки]-абілки з бази заклять (tr['spells']) + дамп залишку."""
import json
import sys
import re
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
jst = tr["journalSections"]
spU = tr.get("spells", {})
sp = json.loads((B / "data/source/spells.json").read_text(encoding="utf-8-sig"))
spEN = {}
for k, v in sp.items():
    en = (v.get("name", {}) or {}).get("en")
    if en and k in spU:
        spEN.setdefault(en, spU[k])

BR = re.compile(r"\[([^\]]+)\]")
def is_latin(s): return bool(re.search(r"[A-Za-z]", s)) and not re.search(r"[А-Яа-яІЇЄҐіїєґ]", s)

fixed = 0
cells = 0
left = Counter()
for en, ua in list(jst.items()):
    if not isinstance(ua, str) or "[" not in ua: continue
    changed = [False]
    def repl(m):
        inner = m.group(1)
        if is_latin(inner):
            if inner in spEN:
                changed[0] = True
                return "[" + spEN[inner] + "]"
            else:
                left[inner] += 1
        return m.group(0)
    new = BR.sub(repl, ua)
    if changed[0]:
        # перерахуємо fixed
        fixed += len(BR.findall(ua)) - len([1 for x in BR.findall(new) if is_latin(x)])
        jst[en] = new
        cells += 1

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
# дамп залишку на ручний переклад
dump = sorted(left.items(), key=lambda x: -x[1])
(B / "data/_journal_brackets_left.json").write_text(
    json.dumps([k for k, _ in dump], ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Доперекладено зі spells у {cells} секціях")
print(f"Лишилось англ.-дужок без перекладу: {sum(left.values())} ({len(left)} унікальних) -> data/_journal_brackets_left.json")
for k, n in dump[:25]:
    print(f"  {n:>3}  [{k}]")
