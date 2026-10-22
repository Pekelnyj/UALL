# -*- coding: utf-8 -*-
"""Чанкер Stage 2 Midnight-рейдів: описи абілок + секції в батчі;
витяг описів інстансів (5) і лору Sporefall (untranslated boss) для ручного перекладу."""
import sys, json, os
sys.stdout.reconfigure(encoding="utf-8")

IIDS = [1312, 1314, 1307, 1308, 1305]
OUT = "data/jbatch_mid"
os.makedirs(OUT + "/desc", exist_ok=True)
os.makedirs(OUT + "/sec", exist_ok=True)

# --- описи абілок ---
need = json.load(open("data/descgap2/need.json", encoding="utf-8-sig"))
DSZ = 37
for f in os.listdir(OUT + "/desc"):
    os.remove(OUT + "/desc/" + f)
nd = 0
for i in range(0, len(need), DSZ):
    nd += 1
    json.dump(need[i:i + DSZ], open(f"{OUT}/desc/d_{nd:02d}.json", "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)

# --- секції (raw EN bullets) ---
sec = json.load(open("data/jcov/gap_sec.json", encoding="utf-8-sig"))
SSZ = 36
for f in os.listdir(OUT + "/sec"):
    os.remove(OUT + "/sec/" + f)
ns = 0
for i in range(0, len(sec), SSZ):
    ns += 1
    json.dump(sec[i:i + SSZ], open(f"{OUT}/sec/s_{ns:02d}.json", "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)

# --- описи інстансів (5) ---
idesc = json.load(open("data/source/api_instance_desc.json", encoding="utf-8-sig"))
inst = {}
for iid in IIDS:
    e = idesc.get(str(iid))
    if e:
        inst[str(iid)] = {"name": (e.get("name") or {}).get("en", ""),
                          "en": (e.get("desc") or {}).get("en", "")}
json.dump(inst, open(f"{OUT}/inst.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)

# --- лор Sporefall: боси без перекладеного journal[eid].desc ---
cache = json.load(open("data/jcov/_apicache.json", encoding="utf-8"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
journal = tr.get("journal", {})
aj = json.load(open("data/source/api_journal.json", encoding="utf-8-sig"))
lore = {}
for iid in IIDS:
    d = cache.get(f"/data/wow/journal-instance/{iid}")
    if not d:
        continue
    for e in d.get("encounters", []) or []:
        eid = str(e["id"])
        desc_en = (aj.get(eid, {}).get("description") or {}).get("en")
        if desc_en and not (journal.get(eid, {}) or {}).get("desc", "").strip():
            lore[eid] = {"name": (aj.get(eid, {}).get("name") or {}).get("en", ""),
                         "en": desc_en,
                         "de": (aj.get(eid, {}).get("description") or {}).get("de", ""),
                         "fr": (aj.get(eid, {}).get("description") or {}).get("fr", "")}
json.dump(lore, open(f"{OUT}/lore.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)

print(f"описи: {len(need)} → {nd} батчів | секції: {len(sec)} → {ns} батчів | "
      f"інстансів: {len(inst)} | лор-боси без перекладу: {len(lore)}")
