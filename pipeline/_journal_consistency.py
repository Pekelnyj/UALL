# -*- coding: utf-8 -*-
"""Наскрізна перевірка консистентності назв абілок у дужках по всьому журналу.
Для записів з однаковою к-стю [дужок] у EN і UA — зіставляє позиційно й шукає,
де та сама EN-абілка перекладена кількома різними способами."""
import json
import sys
import re
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
jst = tr["journalSections"]

BR = re.compile(r"\[([^\]]+)\]")
en2ua = defaultdict(lambda: defaultdict(int))
latin_in_ua = 0  # скільки UA-дужок лишилось латиницею

for en, ua in jst.items():
    if not isinstance(ua, str):
        continue
    eb = BR.findall(en)
    ub = BR.findall(ua)
    for u in ub:
        if re.search(r"[A-Za-z]", u) and not re.search(r"[А-Яа-яІЇЄҐіїєґ]", u):
            latin_in_ua += 1
    if eb and len(eb) == len(ub):
        for e, u in zip(eb, ub):
            en2ua[e][u] += 1

# знайти EN-абілки з кількома UA-варіантами
incons = {e: dict(v) for e, v in en2ua.items() if len(v) > 1}
# відсіяти тривіальні (відмінкові форми важко відрізнити; показуємо все, сортуємо за розкидом)
print(f"Унікальних EN-абілок у дужках (зіставних): {len(en2ua):,}")
print(f"UA-дужок, що лишились ЛАТИНИЦЕЮ: {latin_in_ua:,}")
print(f"EN-абілок з >1 UA-варіантом: {len(incons):,}")
print()
print("=== ТОП-40 неконсистентних (за к-стю варіантів) ===")
for e, variants in sorted(incons.items(), key=lambda x: -len(x[1]))[:40]:
    tot = sum(variants.values())
    vs = ", ".join(f"{u!r}×{n}" for u, n in sorted(variants.items(), key=lambda x: -x[1]))
    print(f"[{e}] -> {vs}")
