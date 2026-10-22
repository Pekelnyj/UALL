# -*- coding: utf-8 -*-
"""Мердж перекладених діалогів тестера 24 у translations.json (gossip/broadcast бакети)."""
import json, glob, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")

# тип кожного рядка з вхідних батчів
typ = {}
for f in glob.glob(str(B / "data/_dlg24_in/d_*.json")):
    for x in json.loads(Path(f).read_text(encoding="utf-8")):
        typ[x["en"]] = x["type"]

P = B / "data/translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
gos = tr.setdefault("gossip", {})
bro = tr.setdefault("broadcast", {})

ng = nb = skip = 0
for f in sorted(glob.glob(str(B / "data/_dlg24_out/d_*.json"))):
    d = json.loads(Path(f).read_text(encoding="utf-8"))
    for en, ua in d.items():
        if not ua or not isinstance(ua, str):
            skip += 1
            continue
        t = typ.get(en, "broadcast")
        if t == "gossip":
            if en not in gos:
                ng += 1
            gos[en] = ua
        else:
            if en not in bro:
                nb += 1
            bro[en] = ua

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"gossip +{ng} | broadcast +{nb} | пропущено {skip}")
print(f"усього gossip: {len(gos)} | broadcast: {len(bro)}")
