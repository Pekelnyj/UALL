# -*- coding: utf-8 -*-
"""Консолідована QA-уніфікація рейдів DF: варіант→канон (journal[eid].name).
Виправляє розбіжності назв босів/адів між хвилями та з ручним instanceDesc."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")

FIX = [
    # головні боси (канон з journal)
    ("Фір'алат", "Файр'алат"),       # Fyr'alath (сокира Fyrakk) — узгодити з Файракк
    ("Фіракк", "Файракк"),           # Fyrakk → канон Файракк
    ("Рашагет", "Расзаґет"),         # Raszageth → канон Расзаґет
    ("Корчекореня", "Ґнарлрута"),    # Gnarlroot (ref-gap агент дав описове)
    ("Корчекорінь", "Ґнарлрут"),
    ("Волькоросс", "Волкоросс"),     # Volcoross
    # ади/предмети (вибір канону)
    ("Опалзуб", "Опалозуб"),         # Opalfang
    ("Глутношрам", "Емберскар"),     # Emberscar
    ("Жаророзрубувач", "Емберскар"),
    ("Жароруба", "Емберскара"),
    ("Жароруб", "Емберскар"),
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
