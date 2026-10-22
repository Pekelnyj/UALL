# -*- coding: utf-8 -*-
"""Повний підрахунок: що лишилось перекласти + слова, по ВСІХ категоріях."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
S = B / "data" / "source"
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))

JUNK = ("[DNT]", "(DNT)", "[PH]", "PH]", "Test", "TEST", "LFG", "Tracking Quest",
        "DEPRECATED", "UNUSED", "PLACEHOLDER", "QAOnly", "Classic]", "[D]", "DNT")


def junk(s):
    return any(j in s for j in JUNK)


def words(s):
    return len(re.findall(r"\S+", s))


def load(name):
    p = S / name
    if not p.exists():
        return {}
    try:
        return json.loads(p.read_text(encoding="utf-8-sig"))
    except Exception:
        return {}


def en_of(v):
    if isinstance(v, dict):
        return v.get("en", "") or ""
    return v if isinstance(v, str) else ""


rows = []


def add(label, src_obj, tr_sec, fields, minlen=3):
    """src_obj: dict/list; для кожного запису беремо поля fields (en); рахуємо ті, чий en не в tr_sec."""
    unt, w, seen = 0, 0, set()
    items = src_obj.items() if isinstance(src_obj, dict) else enumerate(src_obj)
    for k, v in items:
        for f in fields:
            e = en_of(v.get(f, "")) if isinstance(v, dict) else (en_of(v) if f is None else "")
            if not e or len(e) < minlen or junk(e) or e in seen:
                continue
            seen.add(e)
            if e not in tr_sec:
                unt += 1
                w += words(e)
    rows.append((label, unt, w))


# QUESTS
src = load("quests.json")
qtr = tr.get("quests", {})
unt, w = 0, 0
for qid, q in (src.items() if isinstance(src, dict) else []):
    if not isinstance(q, dict):
        continue
    de = en_of(q.get("description", {}))
    if len(de) < 15 or junk(en_of(q.get("title", {})) + de):
        continue
    have = qtr.get(qid, {})
    for fld in ("title", "description", "objectives", "progress", "completion"):
        e = en_of(q.get(fld, {}))
        if e and len(e) > 2 and not have.get(fld):
            unt += 1
            w += words(e)
rows.append(("Квести (поля)", unt, w))

# ITEMS: name + flavor
items = load("items.json")
add("itemNames", items, tr.get("itemNames", {}), ["name"])
add("itemFlavors", items, tr.get("itemFlavors", {}), ["flavor", "flavorText", "description"])

# SPELLS: name + desc
sp = load("spells.json")
add("spellNames", sp, tr.get("spells", {}), ["name"])
add("spellDesc", sp, tr.get("spellDescriptions", tr.get("spellDesc", {})), ["desc", "description"])

# прості keyed
add("achievements", load("achievements.json"), tr.get("achievements", {}), ["name", "title", "desc", "description"])
add("factions", load("api_factions.json"), tr.get("factions", {}), ["name", "desc", "description"])
add("gameobjects", load("gameobjects.json"), tr.get("gameobjects", {}), ["name", None])
add("currencies", load("currencies.json"), tr.get("currencies", {}), ["name", "desc", "description"])
add("pets", load("api_pets.json"), tr.get("pets", {}), ["name", "description"])
add("mounts", load("api_mounts.json"), tr.get("mounts", {}), ["name", "description"])
add("toys", load("api_toys.json"), tr.get("toys", {}), ["name", "description"])
add("recipes", load("api_recipes.json"), tr.get("recipes", {}), ["name"])
add("journalSections", load("api_journal_sections.json"), tr.get("journalSections", {}), ["text", "name", None])
add("titles", load("api_titles.json"), tr.get("titles", {}), ["name", None])
add("professions", load("api_professions.json"), tr.get("professions", {}), ["name", None])

print(f"{'КАТЕГОРІЯ':<20}{'НЕПЕРЕКЛ':>9}{'СЛІВ ~':>10}")
print("-" * 39)
tot_u, tot_w = 0, 0
for name, u, w in sorted(rows, key=lambda x: -x[2]):
    if u:
        print(f"{name:<20}{u:>9}{w:>10}")
    tot_u += u
    tot_w += w
print("-" * 39)
print(f"{'РАЗОМ':<20}{tot_u:>9}{tot_w:>10}")
