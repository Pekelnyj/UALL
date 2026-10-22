# -*- coding: utf-8 -*-
"""Застосувати журнальні фікси консистентності + Anvilrage у translations
(journalSections, descTemplates, journal[name], instanceDesc) + _boss.json."""
import sys, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))

# (стара_форма -> канон). Підрядкова заміна у ЗНАЧЕННЯХ перекладу.
REPL = [
    ("Пащека Пекла", "Геллмо"),      # Ambassador Hellmaw
    ("Пащеку Пекла", "Геллмо"),
    ("Пащеки Пекла", "Геллмо"),
    ("Тавріссан", "Тауріссан"),       # Dagran Thaurissan
    ("Жнець Ворогів", "Жнець ворогів"),  # Foe Reaper 5000 (регістр)
    ("Ґлубток", "Глубток"),           # Glubtok
    ("Гоґґер", "Хоґґер"),             # Hogger
    ("Айраная", "Айроная"),           # Ironaya
    ("Леттендріс", "Летендріс"),      # Lethtendris
    ("Мармур", "Мурмур"),             # Murmur (НЕ камінь!)
    # Anvilrage -> Гнівоковадла (родовий)
    ("Гнівокувалів", "Гнівоковадла"),
    ("Гнівокову", "Гнівоковадла"),
    ("Гнівобрання", "Гнівоковадла"),
    ("Гніву Ковадла", "Гнівоковадла"),
    ("Ковадлогніву", "Гнівоковадла"),
]

n = 0
for tbl in ("journalSections", "descTemplates", "instanceDesc"):
    d = tr.get(tbl, {})
    for k, v in list(d.items()):
        if not isinstance(v, str):
            continue
        nv = v
        for a, b in REPL:
            if a in nv:
                nv = nv.replace(a, b)
        if nv != v:
            d[k] = nv
            n += 1
# journal[eid].name
for eid, e in tr.get("journal", {}).items():
    nm = e.get("name")
    if isinstance(nm, str):
        nn = nm
        for a, b in REPL:
            nn = nn.replace(a, b)
        if nn != nm:
            e["name"] = nn
            n += 1

(DATA_DIR / "translations.json").write_text(
    json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")

# _boss.json теж
for f in glob.glob(str(DATA_DIR / "jdung_*" / "_boss.json")):
    bd = json.loads(open(f, encoding="utf-8-sig").read())
    ch = False
    for k, v in list(bd.items()):
        nv = v
        for a, b in REPL:
            nv = nv.replace(a, b)
        if nv != v:
            bd[k] = nv
            ch = True
    if ch:
        json.dump(bd, open(f, "w", encoding="utf-8"), ensure_ascii=False, indent=1)

print(f"замін у значеннях: {n}")
