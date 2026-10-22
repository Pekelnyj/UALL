# -*- coding: utf-8 -*-
"""Звести 10 батчів мобів у єдину EN->UA мапу + валідація покриття + скан розбіжностей компонентів."""
import json
import sys
import re
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
new = json.loads((B / "data/_live_new_npc.json").read_text(encoding="utf-8-sig"))  # id->en
uniq = set(new.values())

en2ua = {}
dups = []
for i in range(1, 11):
    f = B / f"data/_mob_out/mob_{i:02d}.json"
    d = json.loads(f.read_text(encoding="utf-8-sig"))
    for en, ua in d.items():
        if en in en2ua and en2ua[en] != ua:
            dups.append((en, en2ua[en], ua))
        en2ua[en] = ua

missing = uniq - set(en2ua)
print(f"Унікальних імен: {len(uniq)} | перекладено: {len(en2ua)} | пропущено: {len(missing)}")
if missing:
    for m in list(missing)[:15]:
        print("  ПРОПУЩЕНО:", m)
if dups:
    print(f"Дублі-розбіжності між батчами: {len(dups)}")

(B / "data/_mob_master.json").write_text(json.dumps(en2ua, ensure_ascii=False, indent=1), encoding="utf-8")

# скан компонентів: для кожного «останнього слова» EN (прізвище/тип), що зустрічається >=2,
# показати, чи UA-переклади узгоджені
comp = defaultdict(list)
for en, ua in en2ua.items():
    ws = en.split()
    if len(ws) >= 2:
        comp[ws[-1]].append((en, ua))

print("\n=== РОЗБІЖНОСТІ компонентів (одне EN-слово -> різні UA-форми) ===")
flag = 0
for w, items in sorted(comp.items()):
    if len(items) < 2:
        continue
    # груба евристика: чи останнє UA-слово однакове (лема) у всіх
    last_ua = set()
    for en, ua in items:
        uw = ua.split()
        if uw:
            last_ua.add(uw[-1].lower())
    if len(last_ua) > 1 and len(items) >= 2:
        # показати лише підозрілі (різні корені, не просто відмінки)
        roots = set(u[:5] for u in last_ua)
        if len(roots) > 1:
            flag += 1
            if flag <= 30:
                print(f"[{w}] ({len(items)}): " + " | ".join(f"{en}→{ua}" for en, ua in items[:4]))
print(f"\nПідозрілих компонентів-розбіжностей: {flag}")
