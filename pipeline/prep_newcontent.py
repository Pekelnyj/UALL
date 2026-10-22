# -*- coding: utf-8 -*-
# Готує батчі НОВОГО контенту із захоплення тестера (data/_tester_new.json):
#   npc (імена), gossip (діалоги), objLines (заголовки цілей).
# broadcast обробляється окремим пайплайном (prep_broadcast_batches).
# Запуск: python pipeline/prep_newcontent.py
import json, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
new = json.loads((DATA / "_tester_new.json").read_text(encoding="utf-8-sig"))
OUT = DATA / "newcontent"
OUT.mkdir(exist_ok=True)
for f in OUT.glob("*.json"):
    f.unlink()

# npc: {id: en} -> агент пише {id: ua}
npc = new.get("npcNames", {})
(OUT / "npc_in.json").write_text(json.dumps(npc, ensure_ascii=False, indent=1), encoding="utf-8")

# gossip: [en] -> агент пише {en: ua}. Розбити на 2 батчі.
gos = new.get("gossip", [])
half = (len(gos) + 1) // 2
(OUT / "gossip_0.json").write_text(json.dumps(gos[:half], ensure_ascii=False, indent=1), encoding="utf-8")
(OUT / "gossip_1.json").write_text(json.dumps(gos[half:], ensure_ascii=False, indent=1), encoding="utf-8")

# objLines: [en] -> {en: ua}
obj = new.get("objLines", [])
(OUT / "objlines_in.json").write_text(json.dumps(obj, ensure_ascii=False, indent=1), encoding="utf-8")

print(f"npc: {len(npc)} | gossip: {len(gos)} (2 батчі по ~{half}) | objLines: {len(obj)}")
print(f"-> {OUT}")
