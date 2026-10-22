"""Злити перекладене з _tester_ua.json у translations.json (npcNames за id, gossip за en)."""
import json
from common import DATA_DIR

T = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
ua = json.loads((DATA_DIR / "_tester_ua.json").read_text(encoding="utf-8-sig"))

npc = T.setdefault("npcNames", {})
n_npc = 0
for k, v in ua.get("npcNames", {}).items():
    if v and v.strip():
        npc[str(k)] = v.strip()
        n_npc += 1

gos = T.setdefault("gossip", {})
n_g = 0
for k, v in ua.get("gossip", {}).items():
    if v and v.strip() and k not in gos:
        gos[k] = v.strip()
        n_g += 1

(DATA_DIR / "translations.json").write_text(
    json.dumps(T, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"npcNames злито: {n_npc} | gossip злито: {n_g}")
