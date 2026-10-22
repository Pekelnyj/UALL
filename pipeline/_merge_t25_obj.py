# -*- coding: utf-8 -*-
import json, os, glob, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
qo = tr.setdefault("questObjectives", {})
added = 0; empty = 0; files = 0
for f in sorted(glob.glob(ROOT + "/data/tester_new/t25/ob_*_out.json")):
    files += 1
    d = json.load(open(f, encoding="utf-8"))
    for en, ua in d.items():
        if not ua or not ua.strip():
            empty += 1; continue
        if en not in qo:
            qo[en] = ua; added += 1
        elif qo[en] != ua:
            pass  # вже є — не чіпаємо канон
json.dump(tr, open(ROOT + "/data/translations.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"файлів: {files}, додано в questObjectives: {added}, порожніх пропущено: {empty}")
print(f"усього questObjectives: {len(qo)}")
