# -*- coding: utf-8 -*-
"""ГЕЙТ: ловить «Keystone→наріжний камінь» (глос. §459 — має бути «ключ»).
Запускати перед релізом / у name-consistency. Виходить кодом 1, якщо є порушення.
Глосарій — ПАСИВНИЙ; цей чекер — АКТИВНИЙ (саме брак його дав рецидив бага)."""
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
qsrc = json.loads((B / "data/source/quests.json").read_text(encoding="utf-8-sig"))
asrc = json.loads((B / "data/source/achievements.json").read_text(encoding="utf-8-sig"))
NAR = re.compile(r"наріжн\w*\s+камін|наріжн\w*\s+камен")

def en_of(src, qid, fields):
    v = src.get(qid, {}); out = ""
    for f in fields:
        n = v.get(f)
        if isinstance(n, dict): out += " " + (n.get("en", "") or "")
    return out

viol = []
for qid, uv in tr.get("quests", {}).items():
    if isinstance(uv, dict) and "Keystone" in en_of(qsrc, qid, ("title", "description")):
        for f in ("title", "description", "objectives", "progress", "completion"):
            if isinstance(uv.get(f), str) and NAR.search(uv[f]):
                viol.append(f"quests/{qid}/{f}")
for aid, uv in tr.get("achievements", {}).items():
    if isinstance(uv, dict) and "Keystone" in en_of(asrc, aid, ("title", "desc")):
        for f in ("title", "desc"):
            if isinstance(uv.get(f), str) and NAR.search(uv[f]):
                viol.append(f"achievements/{aid}/{f}")
for sect in ("questObjectives", "itemNames", "uiTooltips", "globalStrings", "spells"):
    for k, v in tr.get(sect, {}).items():
        if "Keystone" in str(k) and isinstance(v, str) and NAR.search(v):
            viol.append(f"{sect}/{k}")

if viol:
    print(f"❌ ГЕЙТ KEYSTONE: {len(viol)} порушень (Keystone→наріжний камінь, має бути «ключ»):")
    for x in viol[:40]:
        print("  ", x)
    sys.exit(1)
print("✅ ГЕЙТ KEYSTONE: чисто (жодного Keystone→наріжний камінь)")
