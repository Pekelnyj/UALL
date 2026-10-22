# -*- coding: utf-8 -*-
"""ГЕЙТ: у НАЗВАХ ПРЕДМЕТІВ (itemNames) шоломовий елемент Visor/Faceguard/Faceplate =
«забрало» (середній рід), НІКОЛИ «забороло» (глосарій §13a). «Забороло» — то парапет/
укріплення на стіні (інше значення), тож у назвах обладунку це калька-помилка.
Звужено до itemNames, щоб не чіпати легітимні «забороло» деінде (описи фортець).
Запуск перед мерджем/релізом: python pipeline/_zabralo_gate.py
"""
from pathlib import Path
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
ROOT = str(Path(__file__).resolve().parent.parent)

tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
bad = []
# секції предметного контексту: тут «забороло» ЗАВЖДИ = шоломовий елемент (=забрало)
for sec in ("itemNames", "itemFlavors", "recipes"):
    d = tr.get(sec, {})
    if not isinstance(d, dict):
        continue
    for k, v in d.items():
        s = v if isinstance(v, str) else (v.get("name") if isinstance(v, dict) else None)
        if isinstance(s, str) and re.search(r"[Зз]аборол", s):
            bad.append((sec + "/" + str(k), s))

if bad:
    print(f"❌ ГЕЙТ ЗАБРАЛО: {len(bad)} назв предметів із «забороло» (має бути «забрало»)")
    for k, v in bad[:40]:
        print(f"   {k!r} -> {v}")
    sys.exit(1)
print("✅ ГЕЙТ ЗАБРАЛО: чисто (Visor/Faceguard/Faceplate = забрало, не забороло).")
