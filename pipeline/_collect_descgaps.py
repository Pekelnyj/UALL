# -*- coding: utf-8 -*-
"""Збирає ВСІ EN-описи абілок 7 підземель (рекурсивно з API-секцій), РОЗГОРТАЄ
$@spelldesc-референси, і виводить ті, що НЕ перекладені (немає в descTemplates[en])."""
import sys, re, json, os
sys.stdout.reconfigure(encoding="utf-8")

cache = json.load(open("data/jcov/_apicache.json", encoding="utf-8")) if os.path.exists("data/jcov/_apicache.json") else {}
src = json.load(open("data/source/spells.json", encoding="utf-8-sig"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
dt = tr["descTemplates"]

IIDS = [1300, 476, 1201, 945, 1299, 1315, 1316]


def den(sid):
    e = src.get(str(sid))
    if isinstance(e, dict) and isinstance(e.get("description"), dict):
        return e["description"].get("en")
    return None


def walk(sec, spids):
    sp = sec.get("spell")
    if isinstance(sp, dict) and sp.get("id"):
        spids.add(int(sp["id"]))
    for s in sec.get("sections", []) or []:
        walk(s, spids)


# зібрати всі section spell.id
spids = set()
for iid in IIDS:
    inst = cache.get(f"/data/wow/journal-instance/{iid}")
    if not inst:
        continue
    for e in inst.get("encounters", []) or []:
        enc = cache.get(f"/data/wow/journal-encounter/{e['id']}")
        if enc:
            for s in enc.get("sections", []) or []:
                walk(s, spids)

# розгорнути: для кожного — desc.en; якщо $@spelldescNNN — додати NNN
need = {}  # spellID -> en (потребує перекладу)
seen = set()
queue = list(spids)
while queue:
    sid = queue.pop()
    if sid in seen:
        continue
    seen.add(sid)
    en = den(sid)
    if not en:
        continue
    # референси $@spelldescNNN / $@spellnameNNN — додати в чергу
    for ref in re.findall(r'\$@spell(?:desc|name)(\d+)', en):
        if int(ref) not in seen:
            queue.append(int(ref))
    # чистий аліас сам не потребує перекладу (резолвиться через ціль)
    if re.fullmatch(r'\$@spelldesc\d+s?', en.strip()):
        continue
    if en not in dt:
        need[sid] = en

print(f"section spell.id: {len(spids)} | усього розгорнуто: {len(seen)}")
print(f"НЕперекладених EN-описів (з референсами): {len(need)}")
os.makedirs("data/descgap2", exist_ok=True)
batch = [{"id": sid, "en": en} for sid, en in need.items()]
json.dump(batch, open("data/descgap2/need.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
for sid, en in list(need.items())[:12]:
    print(f"  {sid}: {en[:80]!r}")
