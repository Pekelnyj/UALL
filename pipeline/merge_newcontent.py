# -*- coding: utf-8 -*-
# Зливає перекладений НОВИЙ контент (тестер) у translations.json:
#   newcontent_out/npc.json       -> npcNames (за id)
#   newcontent_out/gossip_*.json  -> gossip (за en)
#   newcontent_out/objlines.json  -> questObjectives (за en)
# Кирилиця обов'язкова. Потім: python pipeline/generate_db.py
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
CYR = re.compile("[Ѐ-ӿ]")
OUT = DATA / "newcontent_out"
tr = json.loads((DATA / "translations.json").read_text(encoding="utf-8-sig"))

def load(name):
    p = OUT / name
    if not p.exists():
        return {}
    return json.loads(p.read_text(encoding="utf-8-sig"))

def merge(data, section, by_id=False):
    bucket = tr.setdefault(section, {})
    added = 0
    for k, v in data.items():
        if isinstance(v, str) and v.strip() and CYR.search(v):
            bucket[str(k)] = v.strip()
            added += 1
    return added

n_npc = merge(load("npc.json"), "npcNames")
n_g = (merge(load("gossip_0.json"), "gossip") + merge(load("gossip_1.json"), "gossip")
       + merge(load("gossip_2.json"), "gossip"))
n_o = (merge(load("objlines.json"), "questObjectives")
       + merge(load("objlines_0.json"), "questObjectives")
       + merge(load("objlines_1.json"), "questObjectives"))

(DATA / "translations.json").write_text(
    json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"npcNames +{n_npc} (разом {len(tr['npcNames'])})")
print(f"gossip +{n_g} (разом {len(tr['gossip'])})")
print(f"questObjectives +{n_o} (разом {len(tr['questObjectives'])})")
