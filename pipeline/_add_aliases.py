# -*- coding: utf-8 -*-
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
gd = json.load(open("data/jcov/gap_desc.json", encoding="utf-8-sig"))
src = json.load(open("data/source/spells.json", encoding="utf-8-sig"))
tr = json.load(open("data/translations.json", encoding="utf-8-sig"))
dt = tr["descTemplates"]
added = 0
for sid in gd:
    e = src.get(str(sid), {})
    de = (e.get("description") or {}).get("en") if isinstance(e.get("description"), dict) else None
    if de and re.fullmatch(r"\$@spelldesc\d+s?", de.strip()):
        if de not in dt:
            dt[de] = de
            added += 1
json.dump(tr, open("data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("аліасів-pass-through додано:", added)
