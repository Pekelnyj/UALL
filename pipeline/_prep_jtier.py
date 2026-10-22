# -*- coding: utf-8 -*-
"""Узагальнений prep тіра журналу: _boss.json (en->ua боси) + _instdesc.json
(описи інстансів, яких ще нема в instanceDesc).
Запуск з кореня: python pipeline/_prep_jtier.py <outdir> <iids-csv>"""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")

outdir = sys.argv[1]
IIDS = [int(x) for x in sys.argv[2].split(",")]
cache = json.load(open("data/jcov/_apicache.json", encoding="utf-8"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
journal = tr.get("journal", {})
idt = tr.get("instanceDesc", {})

import os
os.makedirs(outdir, exist_ok=True)
boss, instdesc, seen_desc = {}, [], set()
for iid in IIDS:
    inst = cache.get(f"/data/wow/journal-instance/{iid}")
    if not inst:
        continue
    for e in inst.get("encounters", []) or []:
        eid = str(e["id"])
        en = e.get("name")
        ua = (journal.get(eid, {}) or {}).get("name")
        if en and ua:
            boss[en] = ua
    desc = inst.get("description")
    if desc and desc not in idt and desc not in seen_desc:
        seen_desc.add(desc)
        instdesc.append({"iid": iid, "name": (inst.get("name") or ""), "en": desc})

json.dump(boss, open(f"{outdir}/_boss.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
json.dump(instdesc, open(f"{outdir}/_instdesc.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"boss canon: {len(boss)} | описів інстансів до перекладу: {len(instdesc)}")
