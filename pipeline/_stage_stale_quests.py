# -*- coding: utf-8 -*-
"""Оновлює quests.json живими описами застарілих квестів і готує їх до перекладу."""
import json, os, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
src = json.load(open(ROOT + "/data/source/quests.json", encoding="utf-8-sig"))
live = json.load(open(ROOT + "/data/source/_stale_live_desc.json", encoding="utf-8"))
tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
qtr = tr.get("quests", {})

# 1) оновити quests.json: description.en = живий текст
updated = 0
for qid, live_en in live.items():
    if qid in src:
        d = src[qid].setdefault("description", {})
        if isinstance(d, dict):
            d["en"] = live_en
        else:
            src[qid]["description"] = {"en": live_en}
        updated += 1
json.dump(src, open(ROOT + "/data/source/quests.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"quests.json оновлено описів: {updated}")

# 2) підготувати вхід для перекладу: {id: {title_en, desc_en, de, fr}}
inp = {}
for qid, live_en in live.items():
    q = src.get(qid, {})
    title = q.get("title", {})
    inp[qid] = {
        "title_en": (title.get("en", "") if isinstance(title, dict) else title) or "",
        "desc_en": live_en,
        "desc_de": (q.get("description", {}) or {}).get("de", "") if isinstance(q.get("description"), dict) else "",
        "desc_fr": (q.get("description", {}) or {}).get("fr", "") if isinstance(q.get("description"), dict) else "",
    }
os.makedirs(ROOT + "/data/tester_new/stale", exist_ok=True)
items = list(inp.items())
CH = 16
n = (len(items) + CH - 1) // CH
for i in range(n):
    part = dict(items[i*CH:(i+1)*CH])
    json.dump(part, open(ROOT + f"/data/tester_new/stale/q{i+1}.json", "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)
print(f"до перекладу: {len(items)} квестів -> {n} чанків по {CH}")
