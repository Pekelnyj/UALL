# -*- coding: utf-8 -*-
"""Злити перекладені серверні поля квестів (quest_capture_batches/out_*.json)
у translations.json quests[qid].{objectives,progress,completion}.
"""
import json
import glob
from common import DATA_DIR

OUT = DATA_DIR / "quest_capture_batches"
FIELDS = ("objectives", "progress", "completion")


def main():
    tp = DATA_DIR / "translations.json"
    tr = json.loads(tp.read_text(encoding="utf-8-sig"))
    quests = tr.setdefault("quests", {})
    n = 0
    for f in sorted(glob.glob(str(OUT / "out_*.json"))):
        data = json.loads(open(f, encoding="utf-8-sig").read())
        for qid, fields in data.items():
            if not isinstance(fields, dict):
                continue
            q = quests.setdefault(str(qid), {})
            for fld in FIELDS:
                ua = fields.get(fld)
                if isinstance(ua, str) and ua.strip():
                    q[fld] = ua.strip()
                    n += 1
    tp.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Влито серверних полів квестів: {n}")


if __name__ == "__main__":
    main()
