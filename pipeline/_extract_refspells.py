# -*- coding: utf-8 -*-
"""Дотягує REFERENCED-спели ($@spelldesc/$@spellname), яким бракує опису в source,
з wago Spell.<lang>.latest.csv (en/de/fr Description_lang). Додає в source/spells.json
і виводить ті, що потребують перекладу (desc.en є, але немає в descTemplates[en])."""
import sys, re, json, os, csv
sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)

cache = json.load(open("data/jcov/_apicache.json", encoding="utf-8"))
src = json.load(open("data/source/spells.json", encoding="utf-8-sig"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
dt = tr["descTemplates"]
IIDS = [int(x) for x in sys.argv[1].split(",")] if len(sys.argv) > 1 else [1300, 476, 1201, 945, 1299, 1315, 1316]


def load_wago(lang):
    m = {}
    with open(f"data/wago/Spell.{lang}.latest.csv", encoding="utf-8") as f:
        r = csv.reader(f); hdr = next(r)
        idi, di = hdr.index("ID"), hdr.index("Description_lang")
        for row in r:
            if row and row[di]:
                m[row[idi]] = row[di]
    return m


wago = {"en": load_wago("enUS"), "de": load_wago("deDE"), "fr": load_wago("frFR")}


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

# BFS через референси; дотягуємо відсутні описи з wago
seen, queue = set(), list(spids)
added, need = 0, {}
while queue:
    sid = queue.pop()
    if sid in seen:
        continue
    seen.add(sid)
    en = den(sid)
    if not en:  # немає опису в source → тягнемо з wago
        wen = wago["en"].get(str(sid))
        if wen:
            entry = src.setdefault(str(sid), {"talent": True, "skillLine": "Captured", "name": {}})
            entry["description"] = {"en": wen}
            if wago["de"].get(str(sid)):
                entry["description"]["de"] = wago["de"][str(sid)]
            if wago["fr"].get(str(sid)):
                entry["description"]["fr"] = wago["fr"][str(sid)]
            en = wen
            added += 1
    if not en:
        continue
    for ref in re.findall(r'\$@spell(?:desc|name)(\d+)', en):
        if int(ref) not in seen:
            queue.append(int(ref))
    if re.fullmatch(r'\$@spelldesc\d+s?', en.strip()):
        continue
    if en not in dt:
        need[str(sid)] = en

json.dump(src, open("data/source/spells.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"дотягнуто описів з wago: {added}")
print(f"потребують перекладу (desc.en є, немає в descTemplates): {len(need)}")
os.makedirs("data/descgap2", exist_ok=True)
batch = [{"id": sid, "en": en, "de": (src[sid].get("description") or {}).get("de", ""),
          "fr": (src[sid].get("description") or {}).get("fr", "")} for sid, en in need.items()]
json.dump(batch, open("data/descgap2/need.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
for sid, en in list(need.items())[:12]:
    print(f"  {sid}: {en[:80]!r}")
