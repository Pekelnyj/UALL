# -*- coding: utf-8 -*-
"""Аудит покриття перекладу квестів: скільки з повним перекладом і чого бракує.
Всесвіт = квести з реальною EN-назвою в source/quests.json (без DNT/PH-заглушок).
Джерела «чи поле має існувати»: source/quests.json (title/description),
wowhead_quests.json (objectives/progress/completion)."""
import json, re, sys
from collections import Counter
sys.stdout.reconfigure(encoding="utf-8")
R = "g:/Claude Code/WoWUkraine"
CYR = re.compile("[а-яіїєґ]", re.I)
JUNK = re.compile(r"\bDNT\b|\[PH\]|NOT USED|DEPRECAT|deprecat|Test Quest|^Test\b|Placeholder|"
                  r"\bTBD\b|\[OLD|^zz|^ZZ|^REUSE|^LFGDungeons|Player Choice|Tracking Quest|"
                  r"^Midnight(\s*\(\d+\))?\s*E?$|^\[|Yuni-Test|TestQuest|^Conditional", re.I)

src = json.load(open(f"{R}/data/source/quests.json", encoding="utf-8-sig"))
wh = json.load(open(f"{R}/data/source/wowhead_quests.json", encoding="utf-8-sig"))
t = json.load(open(f"{R}/data/translations.json", encoding="utf-8-sig"))
tq = t["quests"]

def ua(e, f):
    return isinstance(e.get(f), str) and bool(CYR.search(e[f]))

# всесвіт: реальні квести з EN-назвою
universe = []
for q, s in src.items():
    en_t = (s.get("title") or {}).get("en", "")
    if not en_t.strip() or JUNK.search(en_t):
        continue
    universe.append(q)

stat = Counter()
gaps = {"title": [], "description": [], "objectives": [], "completion": [], "progress": []}
full = 0
for q in universe:
    e = tq.get(q, {}); e = e if isinstance(e, dict) else {}
    s = src.get(q, {}); v = wh.get(q, {}) if isinstance(wh.get(q), dict) else {}
    # які поля МАЮТЬ існувати
    need = {}
    need["title"] = bool((s.get("title") or {}).get("en", "").strip())
    need["description"] = bool((s.get("description") or {}).get("en", "").strip()) or bool(v.get("description"))
    for f in ("objectives", "completion", "progress"):
        need[f] = bool(v.get(f))
    # покриття
    ok = True
    for f, needed in need.items():
        if not needed:
            continue
        if ua(e, f):
            stat[f + "_ok"] += 1
        else:
            gaps[f].append(q); ok = False
    if ok:
        full += 1

print(f"ВСЕСВІТ реальних квестів: {len(universe):,}")
print(f"ПОВНІСТЮ перекладені (усі наявні поля UA): {full:,}  ({full*100//len(universe)}%)")
print("--- ДІРИ по полях (є джерело, нема UA) ---")
for f in ("title", "description", "objectives", "completion", "progress"):
    print(f"  {f}: {len(gaps[f]):,}")
# зберегти списки дір
json.dump({f: gaps[f] for f in gaps}, open(f"{R}/data/_quest_gaps.json", "w"), ensure_ascii=False)
print("→ списки ID дір: data/_quest_gaps.json")
# зразки дір назв/описів
for f in ("title", "description"):
    ex = [(q, (src[q].get(f) or {}).get("en", "")[:45]) for q in gaps[f][:6]]
    print(f"  приклади {f}-дір:", ex)
