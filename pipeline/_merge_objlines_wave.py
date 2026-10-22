# -*- coding: utf-8 -*-
"""Злити перекладені tracker-цілі (out_ol_*.json {en:ua}) у translations.questObjectives.
Кирилиця обов'язкова; ключі байт-у-байт як у джерелі. Потім generate_db.py."""
import sys, json, glob, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

CYR = re.compile("[Ѐ-ӿ]")
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
qo = tr.setdefault("questObjectives", {})
add = skip = 0
for f in sorted(glob.glob(str(DATA_DIR / "batches" / "objlines" / "out_ol_*.json"))):
    data = json.loads(open(f, encoding="utf-8-sig").read())
    for en, ua in data.items():
        if isinstance(ua, str) and ua.strip() and CYR.search(ua) and qo.get(en) != ua:
            qo[en] = ua
            add += 1
        else:
            skip += 1
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"questObjectives злито: {add} | пропущено {skip} | разом {len(qo)}")
