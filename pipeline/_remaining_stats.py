# -*- coding: utf-8 -*-
"""Скільки лишилось перекласти + оцінка слів по категоріях."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
S = B / "data" / "source"
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))

JUNK = ("[DNT]", "(DNT)", "[PH]", "[Ph]", "PH]", "Test", "TEST", "LFG", "Tracking Quest",
        "DEPRECATED", "UNUSED", "PLACEHOLDER", "QAOnly", "[Classic]")


def is_junk(s):
    return any(j in s for j in JUNK)


def words(s):
    return len(re.findall(r"\S+", s))


def load(name):
    p = S / name
    return json.loads(p.read_text(encoding="utf-8-sig")) if p.exists() else {}


def en_of(v):
    if isinstance(v, dict):
        return v.get("en", "")
    return v if isinstance(v, str) else ""


report = []
total_words = 0

# QUESTS (nested title/description/objectives/progress/completion)
src = load("quests.json")
qtr = tr.get("quests", {})
unt = 0
w = 0
for qid, q in src.items():
    if not isinstance(q, dict):
        continue
    de = en_of(q.get("description", {}))
    if len(de) < 15 or is_junk(en_of(q.get("title", {})) + de):
        continue
    have = qtr.get(qid, {})
    for fld in ("title", "description", "objectives", "progress", "completion"):
        e = en_of(q.get(fld, {}))
        if e and len(e) > 2 and (fld not in have or not have.get(fld)):
            unt += 1
            w += words(e)
report.append(("Квести (поля)", unt, w))
total_words += w

# Прості keyed-секції: source-name, tr-section, key=en
SIMPLE = [
    ("itemNames", "items.json", "name"),
    ("factions", "api_factions.json", None),
    ("achievements", "achievements.json", None),
    ("gameobjects", "gameobjects.json", None),
    ("currencies", "currencies.json", None),
]


def count_keyed(src_obj, tr_sec, field):
    unt = 0
    w = 0
    seen = set()
    items = src_obj.items() if isinstance(src_obj, dict) else enumerate(src_obj)
    for k, v in items:
        # field може бути 'name'/'desc'/None(=сам рядок)
        cands = []
        if isinstance(v, dict):
            for fk in ("name", "title", "desc", "description"):
                e = en_of(v.get(fk, ""))
                if e:
                    cands.append(e)
        else:
            cands.append(en_of(v))
        for e in cands:
            if not e or len(e) < 3 or is_junk(e) or e in seen:
                continue
            seen.add(e)
            if e not in tr_sec:
                unt += 1
                w += words(e)
    return unt, w


for tr_name, src_file, fld in SIMPLE:
    so = load(src_file)
    sec = tr.get(tr_name, {})
    u, w = count_keyed(so, sec, fld)
    report.append((tr_name, u, w))
    total_words += w

print(f"{'КАТЕГОРІЯ':<22}{'НЕПЕРЕКЛ.':>10}{'СЛІВ ~':>10}")
print("-" * 42)
for name, u, w in sorted(report, key=lambda x: -x[2]):
    print(f"{name:<22}{u:>10}{w:>10}")
print("-" * 42)
print(f"{'РАЗОМ (ці категорії)':<22}{'':>10}{total_words:>10}")
