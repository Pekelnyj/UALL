# -*- coding: utf-8 -*-
"""Підготувати батчі неперекладених журнальних секцій (цілими боями, ~250/батч).
Кожен батч: список EN-секцій + мапа імен босів (EN->UA з готового tr['journal'])."""
import json
import sys
from collections import defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
js = json.loads((B / "data/source/api_journal_sections.json").read_text(encoding="utf-8-sig"))
jj = json.loads((B / "data/source/api_journal.json").read_text(encoding="utf-8-sig"))
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
jst = tr.get("journalSections", {})
jtr = tr.get("journal", {})  # encounterID(str) -> {name: UA, ...} ? перевіримо формат

INDIR = B / "data/_journal_in"
INDIR.mkdir(exist_ok=True)
(B / "data/_journal_out").mkdir(exist_ok=True)

# untranslated, основний encounter = перший у enc
untr = [(k, (v.get("enc") or [0])[0], v.get("enc") or []) for k, v in js.items() if str(k) not in jst]
# групуємо по основному encounter
by_enc = defaultdict(list)
for k, e, encs in untr:
    by_enc[e].append((k, encs))


def boss_en(e):
    return (jj.get(str(e), {}).get("name", {}) or {}).get("en", f"enc{e}")


def boss_ua(e):
    val = jtr.get(str(e))
    if isinstance(val, dict):
        return val.get("name") or val.get("title") or ""
    if isinstance(val, str):
        return val
    return ""


# чанкуємо по encounter-ID (рейди — суміжні ID), ~250 секцій/батч
TARGET = 250
batches = []
cur, cur_n = [], 0
for e in sorted(by_enc):
    secs = by_enc[e]
    cur.append(e)
    cur_n += len(secs)
    if cur_n >= TARGET:
        batches.append(cur); cur, cur_n = [], 0
if cur:
    batches.append(cur)

manifest = []
for i, encs in enumerate(batches, 1):
    sections = []
    bosses = {}
    for e in encs:
        en_b = boss_en(e); ua_b = boss_ua(e)
        if en_b:
            bosses[en_b] = ua_b
        for k, _ in by_enc[e]:
            sections.append(k)
    out = {"batch": i, "encounters": encs, "bosses": bosses, "sections": sections}
    fn = INDIR / f"batch_{i:02d}.json"
    fn.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    manifest.append((i, len(encs), len(sections)))

print(f"Батчів: {len(batches)} | секцій усього: {sum(m[2] for m in manifest)}")
for i, ne, ns in manifest:
    print(f"  batch_{i:02d}: боїв {ne:>3}, секцій {ns:>4}")
