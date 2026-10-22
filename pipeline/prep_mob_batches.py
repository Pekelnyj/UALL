"""Підготовка перекладу зібраних мобів: id->en у creatures.json + батчі імен на переклад."""
import json
from pathlib import Path
from common import DATA_DIR

new = json.loads((DATA_DIR / "_tester_new.json").read_text(encoding="utf-8-sig"))
npc = new["npcNames"]   # {id: en}

# 1) додати id->en у creatures.json (для майбутнього merge за id)
cp = DATA_DIR / "source" / "creatures.json"
C = json.loads(cp.read_text(encoding="utf-8-sig"))
added = 0
for cid, en in npc.items():
    if str(cid) not in C:
        C[str(cid)] = {"name": {"en": en}}
        added += 1
    elif not (C[str(cid)].get("name") or {}).get("en"):
        C[str(cid)].setdefault("name", {})["en"] = en
        added += 1
cp.write_text(json.dumps(C, ensure_ascii=False), encoding="utf-8")

# 2) дедуп за en (одна назва — один переклад), батчі по 120
seen, uniq = set(), []
for cid, en in npc.items():
    if en not in seen:
        seen.add(en)
        uniq.append(en)
BD = DATA_DIR / "mob_review"
BD.mkdir(exist_ok=True)
B = 120
n = 0
for i in range(0, len(uniq), B):
    batch = {en: "" for en in uniq[i:i + B]}
    (BD / f"mob_{n:02d}.json").write_text(json.dumps(batch, ensure_ascii=False, indent=1), encoding="utf-8")
    n += 1
print(f"id->en додано: {added} | унікальних назв: {len(uniq)} | батчів: {n}")
