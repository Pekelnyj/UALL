# -*- coding: utf-8 -*-
"""Злити перекладені серверні поля квестів (out_qc_*.json) у translations.quests."""
import sys, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
q = tr.setdefault("quests", {})

added = 0
qids = set()
for f in sorted(glob.glob(str(DATA_DIR / "batches" / "qcap" / "out_qc_*.json"))):
    data = json.loads(open(f, encoding="utf-8-sig").read())
    for rec in data:
        qid = str(rec.get("qid", "")).strip()
        flds = rec.get("fields", {})
        if not qid or not flds:
            continue
        entry = q.setdefault(qid, {})
        for k, v in flds.items():
            if isinstance(v, str) and v.strip() and k in ("title", "description",
                    "objectives", "progress", "completion"):
                entry[k] = v
                added += 1
                qids.add(qid)

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"quest-полів злито: {added} | квестів: {len(qids)}")
