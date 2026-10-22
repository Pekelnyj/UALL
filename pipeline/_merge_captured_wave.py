# -*- coding: utf-8 -*-
"""Злити ЛИШЕ out_cap_*.json (зібрані істоти цієї хвилі) у translations.npcNames,
+ uitt_out.json у translations.uiTooltips, + gossip Penny. Валідація id/рос.літер."""
import sys, json, glob, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

TR = DATA_DIR / "translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
src = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
RUS = re.compile("[ыъэёЫЪЭЁ]")

# --- npc imen ---
npc = tr.setdefault("npcNames", {})
added = skipped = rus = 0
for p in sorted(glob.glob(str(DATA_DIR / "batches" / "creatures" / "out_cap_*.json"))):
    items = json.loads(open(p, encoding="utf-8-sig").read())
    for it in items:
        cid = str(it.get("id", "")).strip()
        ua = (it.get("ua") or "").strip()
        if not cid or not ua or cid not in src:
            skipped += 1
            continue
        if RUS.search(ua):
            rus += 1
            print("  РОС.ЛІТЕРА:", cid, repr(ua))
            continue
        npc[cid] = ua
        added += 1
print(f"npcNames злито: {added} | пропущено: {skipped} | рос: {rus} | у базі: {len(npc)}")

# --- uitooltips ---
ui = tr.setdefault("uiTooltips", {})
uo = json.load(open(DATA_DIR / "batches" / "uitt_out.json", encoding="utf-8-sig"))
ua_add = 0
for en, ua in uo.items():
    if en and ua and en not in ui:
        ui[en] = ua
        ua_add += 1
print(f"uiTooltips злито: {ua_add} | у базі: {len(ui)}")

# --- gossip Penny ---
g = tr.setdefault("gossip", {})
if "Penny" not in g:
    g["Penny"] = "Пенні"
    print("gossip: +Penny -> Пенні")

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("translations.json збережено.")
