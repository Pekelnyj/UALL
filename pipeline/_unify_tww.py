# -*- coding: utf-8 -*-
"""Консолідована QA-уніфікація рейдів TWW: варіант→канон у descTemplates+journalSections
+instanceDesc+journal. Канон = journal[eid].name. Лише чіткі бос-рівневі розбіжності."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")

FIX = [
    ("Дименсіус", "Дімензіус"),     # Dimensius (мій instanceDesc розійшовся з канон-журналом)
    ("Геллівікс", "Ґаллівікс"),     # Gallywix (мій instanceDesc vs канон Хром. Король Ґаллівікс)
    ("Брухтрот", "Брухтошрот"),     # Stix Bunkjunker (один desc-агент скоротив)
    ("Таказдж", "Таказж"),          # Skeinspinner Takazj (zj→ж)
]

tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
changed = 0
for table in ("descTemplates", "journalSections", "instanceDesc"):
    d = tr.get(table, {})
    for k, v in list(d.items()):
        if isinstance(v, str):
            nv = v
            for a, b in FIX:
                if a in nv:
                    nv = nv.replace(a, b)
            if nv != v:
                d[k] = nv; changed += 1
for eid, e in (tr.get("journal", {}) or {}).items():
    if isinstance(e, dict):
        for fld in ("name", "desc"):
            v = e.get(fld)
            if isinstance(v, str):
                nv = v
                for a, b in FIX:
                    if a in nv:
                        nv = nv.replace(a, b)
                if nv != v:
                    e[fld] = nv; changed += 1
json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"уніфіковано записів: {changed}")
