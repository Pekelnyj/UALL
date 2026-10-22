# -*- coding: utf-8 -*-
"""Уніфікація: доперекласти АНГЛІЙСЬКІ [дужки] за консенсусом самого журналу.
Чіпаємо лише латинські дужки (українські не торкаємо, щоб не ламати відмінки)."""
import json
import sys
import re
from collections import defaultdict, Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
jst = tr["journalSections"]

BR = re.compile(r"\[([^\]]+)\]")
def is_latin(s): return bool(re.search(r"[A-Za-z]", s)) and not re.search(r"[А-Яа-яІЇЄҐіїєґ]", s)

# консенсус: EN-абілка -> найчастіша УКРАЇНСЬКА форма дужки
en2ua = defaultdict(Counter)
for en, ua in jst.items():
    if not isinstance(ua, str): continue
    eb, ub = BR.findall(en), BR.findall(ua)
    if eb and len(eb) == len(ub):
        for e, u in zip(eb, ub):
            if not is_latin(u):
                en2ua[e][u] += 1
consensus = {e: c.most_common(1)[0][0] for e, c in en2ua.items() if c}

# застосувати: у кожному UA замінити латинську [X] на консенсус-UA, якщо є
fixed_cells = 0
fixed_brackets = 0
no_consensus = Counter()
for en, ua in list(jst.items()):
    if not isinstance(ua, str) or "[" not in ua: continue
    changed = False
    def repl(m):
        global fixed_brackets, changed
        inner = m.group(1)
        if is_latin(inner):
            if inner in consensus:
                fixed_brackets += 1; changed = True
                return "[" + consensus[inner] + "]"
            else:
                no_consensus[inner] += 1
        return m.group(0)
    new = BR.sub(repl, ua)
    if changed:
        jst[en] = new
        fixed_cells += 1

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Уніфіковано: {fixed_brackets} англ. дужок у {fixed_cells} секціях")
print(f"Лишилось англ. дужок БЕЗ консенсусу (нема перекладу ніде): {sum(no_consensus.values())} ({len(no_consensus)} унікальних)")
print("--- топ без консенсусу (їх ніде не перекладали) ---")
for k, n in no_consensus.most_common(20):
    print(f"  {n:>3}  [{k}]")
