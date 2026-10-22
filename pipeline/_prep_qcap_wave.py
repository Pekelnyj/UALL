# -*- coding: utf-8 -*-
"""Батчі для перекладу СЕРВЕРНИХ полів квестів (objectives/progress/completion),
зібраних у грі. Додаємо EN+наявний UA контекст (title/desc) для узгодженості імен.
-> data/batches/qcap/qc_NN.json  [{qid, fields:{поле:en}, ctx_en, ctx_ua}]"""
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

qcap = json.loads((DATA_DIR / "tester_all" / "qcap.json").read_text(encoding="utf-8"))
newf = qcap["newfields"]
src = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})

items = []
for qid, fields in newf.items():
    s = src.get(qid, {})
    ctx_en = ((s.get("title") or {}).get("en", "") + " | " +
              (s.get("description") or {}).get("en", ""))[:400]
    have = tq.get(qid, {}) or {}
    ctx_ua = ((have.get("title") or "") + " | " + (have.get("description") or ""))[:400]
    items.append({"qid": qid, "fields": fields, "ctx_en": ctx_en, "ctx_ua": ctx_ua})

items.sort(key=lambda x: x["qid"])
OUT = DATA_DIR / "batches" / "qcap"
OUT.mkdir(parents=True, exist_ok=True)
for f in OUT.glob("*.json"):
    f.unlink()
B = 20
nb = (len(items) + B - 1) // B
for k in range(nb):
    (OUT / f"qc_{k:02d}.json").write_text(
        json.dumps(items[k * B:(k + 1) * B], ensure_ascii=False, indent=1), encoding="utf-8")
nfields = sum(len(x["fields"]) for x in items)
print(f"квестів: {len(items)} | полів: {nfields} | батчів по {B}: {nb}")
