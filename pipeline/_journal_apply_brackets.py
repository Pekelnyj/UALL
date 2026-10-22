# -*- coding: utf-8 -*-
"""Застосувати мапу перекладів назв абілок до англійських [дужок] у журналі + фінал-перевірка."""
import json
import sys
import re
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
jst = tr["journalSections"]
mp = json.loads((B / "data/_journal_brackets_map.json").read_text(encoding="utf-8-sig"))

BR = re.compile(r"\[([^\]]+)\]")
def is_latin(s): return bool(re.search(r"[A-Za-z]", s)) and not re.search(r"[А-Яа-яІЇЄҐіїєґ]", s)

cells = 0
applied = 0
for en, ua in list(jst.items()):
    if not isinstance(ua, str) or "[" not in ua: continue
    ch = [False]
    def repl(m):
        inner = m.group(1)
        if is_latin(inner) and inner in mp:
            ch[0] = True; applied_local.append(1)
            return "[" + mp[inner] + "]"
        return m.group(0)
    applied_local = []
    new = BR.sub(repl, ua)
    if ch[0]:
        jst[en] = new
        cells += 1
        applied += len(applied_local)

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")

# фінальна перевірка: скільки латинських дужок лишилось
rem = 0
remset = {}
for en, ua in jst.items():
    if not isinstance(ua, str): continue
    for b in BR.findall(ua):
        if is_latin(b):
            rem += 1
            remset[b] = remset.get(b, 0) + 1
print(f"Застосовано {applied} замін у {cells} секціях")
print(f"Латинських дужок ЛИШИЛОСЬ у журналі (весь, новий+старий): {rem} ({len(remset)} унікальних)")
print("--- топ залишку (це й старі досесійні, не з нашої хвилі) ---")
for k, n in sorted(remset.items(), key=lambda x: -x[1])[:15]:
    print(f"  {n:>3}  [{k}]")
