# -*- coding: utf-8 -*-
"""Злити out_g_*.json (діалоги gossip) у translations.gossip."""
import sys, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
g = tr.setdefault("gossip", {})
add = 0
for f in sorted(glob.glob(str(DATA_DIR / "batches" / "gossip" / "out_g_*.json"))):
    data = json.loads(open(f, encoding="utf-8-sig").read())
    for en, ua in data.items():
        if isinstance(ua, str) and ua.strip() and g.get(en) != ua:
            g[en] = ua
            add += 1
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"gossip злито: {add} | усього: {len(g)}")
