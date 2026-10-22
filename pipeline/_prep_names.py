# -*- coding: utf-8 -*-
"""Збирає ВСІ назви абілок (section-спели + $@spellname-референси) підземель,
яких ще нема в translations[spells]. Назви з source або wago SpellName.<lang>.csv.
Запуск: python _prep_names.py <iids> <outdir>"""
import sys, re, json, os, csv
sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10 ** 7)
IIDS = [int(x) for x in sys.argv[1].split(",")]
outdir = sys.argv[2]
src = json.load(open("data/source/spells.json", encoding="utf-8-sig"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
spt = tr.get("spells", {})
cache = json.load(open("data/jcov/_apicache.json", encoding="utf-8"))


def wn(lang):
    m = {}
    with open(f"data/wago/SpellName.{lang}.latest.csv", encoding="utf-8") as f:
        r = csv.reader(f); h = next(r); idi = h.index("ID"); ni = h.index("Name_lang")
        for row in r:
            if row and row[ni]:
                m[row[idi]] = row[ni]
    return m


wen, wde, wfr = wn("enUS"), wn("deDE"), wn("frFR")


def en(d):
    return d.get("en") if isinstance(d, dict) else d


def srcname(sid):
    e = src.get(str(sid))
    n = en(e.get("name")) if isinstance(e, dict) else None
    return n or wen.get(str(sid))


def den(sid):
    e = src.get(str(sid))
    return (e.get("description") or {}).get("en") if isinstance(e, dict) and isinstance(e.get("description"), dict) else None


def walk(sec, sp):
    s = sec.get("spell")
    if isinstance(s, dict) and s.get("id"):
        sp.add(int(s["id"]))
    for x in sec.get("sections", []) or []:
        walk(x, sp)


# section spell-ID + усі $@spellname-референси (BFS)
spids = set()
for iid in IIDS:
    inst = cache.get(f"/data/wow/journal-instance/{iid}")
    if inst:
        for e in inst.get("encounters", []) or []:
            enc = cache.get(f"/data/wow/journal-encounter/{e['id']}")
            if enc:
                for s in enc.get("sections", []) or []:
                    walk(s, spids)
seen, queue = set(), list(spids)
namerefs = set(str(s) for s in spids)
while queue:
    sid = queue.pop()
    if sid in seen:
        continue
    seen.add(sid)
    d = den(sid)
    if not d:
        continue
    for ref in re.findall(r'\$@spell(?:desc|name)(\d+)', d):
        namerefs.add(ref)
        if int(ref) not in seen:
            queue.append(int(ref))

# глосарій en→ua з уже перекладених
g = {}
for sid, ua in spt.items():
    n = srcname(sid)
    if n and n not in g:
        g[n] = ua

applied = 0
batch = []
seen_en = set()
for ref in namerefs:
    if ref in spt:
        continue
    nm = srcname(ref)
    if not nm or nm in seen_en:
        continue
    if nm in g:
        spt[ref] = g[nm]; applied += 1
    else:
        seen_en.add(nm)
        batch.append({"id": ref, "en": nm, "de": wde.get(ref, ""), "fr": wfr.get(ref, "")})

json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
os.makedirs(outdir, exist_ok=True)
json.dump(batch, open(outdir + "/need.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"назв-референсів {len(namerefs)} | застосовано з глосарію {applied} | на переклад {len(batch)}")
