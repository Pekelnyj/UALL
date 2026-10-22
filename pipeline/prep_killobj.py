# -*- coding: utf-8 -*-
# Готує батчі kill-цілей «{Моб} slain» для ЯКІСНОГО перекладу (з відмінком).
# Джерело: QuestObjective.db2 (Type=0, ObjectID=creatureID). Для кожного унік. моба
# беремо en-ім'я (creatures/api_creatures_full) + наш ua-переклад (npcNames за id).
# Агент робить «Вбито {ua у знахідному}». Запуск: python pipeline/prep_killobj.py
import json, sys, csv, io
from pathlib import Path
import requests
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
def L(p): return json.loads((DATA / p).read_text(encoding="utf-8-sig"))

BUILD = "12.0.7.68235"
print("Тягну QuestObjective.db2...")
r = requests.get("https://wago.tools/db2/QuestObjective/csv",
                 params={"locale": "enUS", "build": BUILD}, timeout=300)
rows = list(csv.DictReader(io.StringIO(r.text)))
# kill-цілі: Type=0, порожній опис, ObjectID != 0
kill_ids = set()
for x in rows:
    if x.get("Type") == "0" and not (x.get("Description_lang") or "").strip():
        oid = (x.get("ObjectID") or "").strip()
        if oid and oid != "0":
            kill_ids.add(oid)
print(f"унікальних creatureID у kill-цілях: {len(kill_ids)}")

cr = L("source/creatures.json")
acf = L("source/api_creatures_full.json")
tr = L("translations.json")
npc = tr.get("npcNames", {})        # id -> ua
qo = tr.get("questObjectives", {})  # вже перекладені цілі

def en_of(cid):
    e = (cr.get(str(cid), {}).get("name") or {}).get("en") if cr.get(str(cid)) else None
    if e: return e
    n = (acf.get(str(cid)) or {}).get("name")
    return n.get("en") if isinstance(n, dict) else n

items = []
seen = set()
no_name = no_ua = already = 0
for cid in kill_ids:
    en = en_of(cid)
    if not en:
        no_name += 1; continue
    obj_en = en + " slain"
    if obj_en in seen:
        continue
    seen.add(obj_en)
    if obj_en in qo:
        already += 1; continue          # уже перекладено (капчура) — не чіпаємо
    ua_name = npc.get(str(cid))
    if not ua_name:
        no_ua += 1; continue            # імені нема в перекладі — пропускаємо (підстановка не спрацює теж)
    items.append({"id": cid, "obj_en": obj_en, "ua_name": ua_name})

print(f"на переклад: {len(items)} | без en-імені: {no_name} | без ua-імені: {no_ua} | вже є: {already}")
B = 200
d = DATA / "killobj_batches"
d.mkdir(exist_ok=True)
for f in d.glob("*.json"): f.unlink()
n = 0
for i in range(0, len(items), B):
    (d / f"kill_{n:02d}.json").write_text(
        json.dumps(items[i:i+B], ensure_ascii=False, indent=1), encoding="utf-8")
    n += 1
print(f"батчів по {B}: {n}")
