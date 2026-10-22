# -*- coding: utf-8 -*-
"""Збирає $@spellnameNNN-референси з описів абілок 7 підземель, чиї НАЗВИ не
перекладені в translations[spells]. Застосовує en→ua глосарій назв; решту — на переклад.
Назви з source або wago SpellName.<lang>.latest.csv."""
import sys, re, json, os, csv
sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)

src = json.load(open("data/source/spells.json", encoding="utf-8-sig"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
dt = tr["descTemplates"]
spt = tr.setdefault("spells", {})
cache = json.load(open("data/jcov/_apicache.json", encoding="utf-8"))
IIDS = [int(x) for x in sys.argv[1].split(",")] if len(sys.argv) > 1 else [1300, 476, 1201, 945, 1299, 1315, 1316]


def nameen(sid):
    e = src.get(str(sid))
    if isinstance(e, dict):
        n = e.get("name")
        return n.get("en") if isinstance(n, dict) else n
    return None


def load_wago_names(lang):
    m = {}
    with open(f"data/wago/SpellName.{lang}.latest.csv", encoding="utf-8") as f:
        r = csv.reader(f); hdr = next(r)
        idi = hdr.index("ID"); ni = hdr.index("Name_lang")
        for row in r:
            if row and row[ni]:
                m[row[idi]] = row[ni]
    return m


wname = {"en": load_wago_names("enUS"), "de": load_wago_names("deDE"), "fr": load_wago_names("frFR")}

# глосарій en→ua з уже перекладених назв
g = {}
for sid, ua in spt.items():
    n = nameen(sid)
    if n and n not in g:
        g[n] = ua

# зібрати section spell.id + усі $@spellname-референси з їхніх описів (рекурсивно)
def den(sid):
    e = src.get(str(sid))
    return (e.get("description") or {}).get("en") if isinstance(e, dict) and isinstance(e.get("description"), dict) else None


def walk(sec, spids):
    sp = sec.get("spell")
    if isinstance(sp, dict) and sp.get("id"):
        spids.add(int(sp["id"]))
    for s in sec.get("sections", []) or []:
        walk(s, spids)


spids = set()
for iid in IIDS:
    inst = cache.get(f"/data/wow/journal-instance/{iid}")
    if inst:
        for e in inst.get("encounters", []) or []:
            enc = cache.get(f"/data/wow/journal-encounter/{e['id']}")
            if enc:
                for s in enc.get("sections", []) or []:
                    walk(s, spids)

namerefs = set()
seen, queue = set(), list(spids)
while queue:
    sid = queue.pop()
    if sid in seen:
        continue
    seen.add(sid)
    en = den(sid)
    if not en:
        continue
    for ref in re.findall(r'\$@spell(?:desc|name)(\d+)', en):
        if int(ref) not in seen:
            queue.append(int(ref))
    for ref in re.findall(r'\$@spellname(\d+)', en):
        namerefs.add(ref)

applied = need = 0
needbatch = []
for ref in namerefs:
    if ref in spt:
        continue
    nm = nameen(ref) or wname["en"].get(ref)
    if not nm:
        continue
    if nm in g:  # уже перекладено як назву абілки деінде
        spt[ref] = g[nm]; applied += 1
    else:
        need += 1
        needbatch.append({"id": ref, "en": nm, "de": wname["de"].get(ref, ""), "fr": wname["fr"].get(ref, "")})

json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
os.makedirs("data/namegap", exist_ok=True)
json.dump(needbatch, open("data/namegap/need.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"$@spellname-референсів усього: {len(namerefs)}")
print(f"  застосовано з глосарію (вже перекладені назви): {applied}")
print(f"  на переклад (нові назви): {need}")
for e in needbatch[:15]:
    print(f"    {e['id']}: {e['en']!r}")
