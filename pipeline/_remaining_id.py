# -*- coding: utf-8 -*-
"""Точний підрахунок неперекладеного — ID-звірка source vs translations."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
S = B / "data" / "source"
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))

JUNK = ("[DNT]", "(DNT)", "[PH]", "PH]", "Test", "TEST", "LFG", "Tracking Quest",
        "DEPRECATED", "UNUSED", "PLACEHOLDER", "QAOnly", "Classic]", "DNT")


def junk(s):
    return any(j in s for j in JUNK)


def words(s):
    return len(re.findall(r"\S+", s))


def load(name):
    p = S / name
    try:
        return json.loads(p.read_text(encoding="utf-8-sig")) if p.exists() else {}
    except Exception:
        return {}


def en(v):
    return (v.get("en", "") if isinstance(v, dict) else (v or "")) or ""


rows = []


def id_count(label, src_file, tr_sec_name, fields):
    """source {id:{field:{en}}}; tr_sec {id: ua|dict}. Неперекл = id real не в tr."""
    src = load(src_file)
    sec = tr.get(tr_sec_name, {})
    unt, w = 0, 0
    for sid, v in (src.items() if isinstance(src, dict) else []):
        # зібрати en-поля
        texts = []
        for f in fields:
            e = en(v.get(f, "")) if isinstance(v, dict) else en(v)
            if e and len(e) > 1:
                texts.append(e)
        if not texts:
            continue
        if any(junk(t) for t in texts):
            continue
        # головна назва коротка? фільтр сміття-рівнів («Level 10») лишаємо — це теж контент
        if str(sid) not in sec:
            unt += 1
            w += sum(words(t) for t in texts)
    rows.append((label, unt, w))


id_count("achievements", "achievements.json", "achievements", ["title", "desc"])
id_count("recipes(назви)", "api_recipes.json", "recipes", ["name"])
id_count("spells(назви)", "spells.json", "spells", ["name"])
id_count("pets", "api_pets.json", "pets", ["name", "description"])
id_count("mounts", "api_mounts.json", "mounts", ["name", "description"])
id_count("toys", "api_toys.json", "toys", ["name", "description"])
id_count("currencies", "currencies.json", "currencies", ["name", "description"])
id_count("titles", "api_titles.json", "titles", ["name"])

# factions: api_factions {id:{name,desc}} -> tr factions keyed?
fsrc = load("api_factions.json")
fsec = tr.get("factions", {})
unt, w = 0, 0
for fid, v in (fsrc.items() if isinstance(fsrc, dict) else []):
    d = en(v.get("description", v.get("desc", ""))) if isinstance(v, dict) else ""
    if not d or len(d) < 5 or junk(d):
        continue
    if d not in fsec and str(fid) not in fsec:
        unt += 1
        w += words(d)
rows.append(("factions(описи)", unt, w))

# quests tail
qsrc = load("quests.json")
qtr = tr.get("quests", {})
unt, w = 0, 0
for qid, q in (qsrc.items() if isinstance(qsrc, dict) else []):
    if not isinstance(q, dict):
        continue
    de = en(q.get("description", {}))
    if len(de) < 15 or junk(en(q.get("title", {})) + de):
        continue
    have = qtr.get(qid, {})
    for fld in ("title", "description", "objectives", "progress", "completion"):
        e = en(q.get(fld, {}))
        if e and len(e) > 2 and not have.get(fld):
            unt += 1
            w += words(e)
rows.append(("Квести (хвіст)", unt, w))

print(f"{'КАТЕГОРІЯ':<18}{'НЕПЕРЕКЛ':>9}{'СЛІВ ~':>10}")
print("-" * 37)
tw = 0
for name, u, w in sorted(rows, key=lambda x: -x[2]):
    print(f"{name:<18}{u:>9}{w:>10}")
    tw += w
print("-" * 37)
print(f"{'РАЗОМ':<18}{'':>9}{tw:>10}")
