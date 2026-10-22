# -*- coding: utf-8 -*-
"""QA-уніфікація імен Midnight-рейдів до канонічних (journal[eid].name).
Замінює варіанти різних хвиль у descTemplates + journalSections + instanceDesc.
Порядок важливий: довші/специфічніші заміни першими."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")

# (варіант, канон) — варіанти у формах, що реально трапились (див. _scan_variants)
FIX = [
    # боси
    ("Хімерус", "Чимаерус"),              # Хімеруса→Чимаеруса теж
    ("Кречпайн", "Скеледрев"),
    ("Скелесосна", "Скеледрев"),
    ("Вораcіус", "Воразіус"),             # лат. 'c'
    ("Воразій", "Воразіус"),
    ("Гнилобагно", "Ротмайр"),
    ("Ваелґор", "Вейлґор"),
    ("Вейлгора", "Вейлґора"),
    ("Вейлгор", "Вейлґор"),
    ("Велґор", "Вейлґор"),
    # доп. істоти / терміни
    ("Світлокров", "Лайтблад"),           # Світлокрова→Лайтблада
    ("Нульзон", "Нуль-зон"),
    ("Безодній Формувач", "Безодній Творець"),
    ("Формувач Порожнечі", "Творець Порожнечі"),
    ("Пащ Порожнечі", "Паща Порожнечі"),
    ("Вейлкрила", "Велвінги"),
    ("Вейлкрило", "Велвінг"),
    ("Беллемі", "Беллемі"),               # canon (no-op, лишаємо як є)
    ("Белламі", "Беллемі"),
    ("Беламі", "Беллемі"),
]

tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
changed = 0
for table in ("descTemplates", "journalSections", "instanceDesc"):
    d = tr.get(table, {})
    for k, v in list(d.items()):
        if not isinstance(v, str):
            continue
        nv = v
        for a, b in FIX:
            if a != b and a in nv:
                nv = nv.replace(a, b)
        if nv != v:
            d[k] = nv; changed += 1
# journal[eid].desc/name теж
for eid, e in (tr.get("journal", {}) or {}).items():
    if not isinstance(e, dict):
        continue
    for fld in ("name", "desc"):
        v = e.get(fld)
        if isinstance(v, str):
            nv = v
            for a, b in FIX:
                if a != b and a in nv:
                    nv = nv.replace(a, b)
            if nv != v:
                e[fld] = nv; changed += 1

json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"уніфіковано записів: {changed}")
