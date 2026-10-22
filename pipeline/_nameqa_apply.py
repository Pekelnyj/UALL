# -*- coding: utf-8 -*-
"""Звести EN-імена з розбіжними UA до канону (QA імен персонажів)."""
import json, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
P = B / "data/translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
npc = tr["npcNames"]

id2en = {}
for f in ["creatures.json", "api_creatures_full.json", "captured_creatures.json", "_midnight_creatures.json"]:
    try:
        d = json.loads((B / "data/source" / f).read_text(encoding="utf-8-sig"))
    except Exception:
        continue
    for k, v in d.items():
        en = v if isinstance(v, str) else (v.get("en") if isinstance(v, dict) else None)
        if en and str(k) not in id2en:
            id2en[str(k)] = en

CANON = {
    "Coy Sunwhisker": "Кой Санвіскер",          # named — транслітерація (не калька)
    "Imp Gang Boss": "Бос-ватажок бісів",        # «Дикий біс» хибно
    "Lesser Ghoul": "Менший вурдалак",           # ghoul=вурдалак (не упир)
    "Erratic Spore": "Нестабільна спора",
    "Silvermoon Noble": "Вельможа Сільвермуна",
    "Living Springwood": "Живе весняне дерево",
    "Dreadwing Terror": "Жахокрилий жах",
}
n = 0
for cid, ua in list(npc.items()):
    en = id2en.get(str(cid))
    if en in CANON and isinstance(ua, str) and ua.strip() != CANON[en]:
        print(f"  ✓ {en}: «{ua}» → «{CANON[en]}»")
        npc[cid] = CANON[en]; n += 1
P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("зведено:", n)
