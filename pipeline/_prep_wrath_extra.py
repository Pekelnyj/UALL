# -*- coding: utf-8 -*-
"""Для Wrath-тіра: _boss.json (en->ua боси, canon для секцій) + _instdesc.json
(описи інстансів, яких ще нема в instanceDesc). Запуск з кореня."""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")

IIDS = [271, 272, 273, 274, 275, 276, 277, 279, 280, 281, 282, 283, 284, 285, 286]
cache = json.load(open("data/jcov/_apicache.json", encoding="utf-8"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
journal = tr.get("journal", {})
idt = tr.get("instanceDesc", {})

boss = {}
instdesc = []
for iid in IIDS:
    inst = cache.get(f"/data/wow/journal-instance/{iid}")
    if not inst:
        continue
    # боси: en -> ua (з journal[eid].name)
    for e in inst.get("encounters", []) or []:
        eid = str(e["id"])
        en = e.get("name")
        ua = (journal.get(eid, {}) or {}).get("name")
        if en and ua:
            boss[en] = ua
    # опис інстансу
    desc = inst.get("description")
    if desc and desc not in idt:
        instdesc.append({"iid": iid, "name": (inst.get("name") or ""), "en": desc})

json.dump(boss, open("data/jdung_wrath/_boss.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
json.dump(instdesc, open("data/jdung_wrath/_instdesc.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"boss canon: {len(boss)} | описів інстансів до перекладу: {len(instdesc)}")
for x in instdesc[:3]:
    print(f"  {x['iid']} {x['name']}: {x['en'][:70]!r}")
