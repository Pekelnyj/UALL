# -*- coding: utf-8 -*-
# Зливає вихід агентів-перекладачів квестів у translations.json.
#   data/quest_out_new/*.json : {questID: {"title": "...", "description": "..."}}
# Кирилиця обов'язкова хоча б в одному полі. Потім: python pipeline/generate_db.py
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
CYR = re.compile("[Ѐ-ӿ]")
# Службові теги доповнень/рівнів («Dragonflight (60-69) E», «Shadowlands 60 E»,
# «Legion 110 H», «Classic 10-19») — НЕ перекладати/не зливати, навіть якщо агент дав кирилицю.
TAG = re.compile(r"^(Classic|TBC|The Burning Crusade|Burning Crusade|Wrath|Cataclysm|"
                 r"Mists of Pandaria|Pandaria|Warlords|Draenor|Legion|Battle for Azeroth|"
                 r"BfA|Shadowlands|Dragonflight|The War Within|War Within|Midnight|Vanilla)\b.{0,14}\d.{0,4}$",
                 re.I)
src = json.loads((DATA / "source" / "quests.json").read_text(encoding="utf-8-sig"))
def is_tag(qid):
    en = ((src.get(str(qid)) or {}).get("title") or {}).get("en") or ""
    return bool(TAG.match(en))

tr = json.loads((DATA / "translations.json").read_text(encoding="utf-8-sig"))
q = tr.setdefault("quests", {})

added = skipped = tags = 0
d = DATA / "quest_out_new"
for f in sorted(d.glob("*.json")):
    try:
        data = json.loads(f.read_text(encoding="utf-8-sig"))
    except Exception as e:
        print(f"  ПОМИЛКА {f.name}: {e}"); continue
    for qid, fields in data.items():
        if not isinstance(fields, dict):
            skipped += 1; continue
        if is_tag(qid):
            tags += 1; continue
        out = {}
        for k in ("title", "description"):
            v = fields.get(k)
            if isinstance(v, str) and v.strip() and CYR.search(v):
                out[k] = v
        if not out:
            skipped += 1; continue
        q[str(qid)] = {**q.get(str(qid), {}), **out}
        added += 1

(DATA / "translations.json").write_text(
    json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"КВЕСТИ: додано/оновлено {added}, пропущено {skipped}, тегів-шуму відкинуто {tags}, разом у базі {len(q)}")
print("Далі: python pipeline/generate_db.py")
