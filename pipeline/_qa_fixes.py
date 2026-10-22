# -*- coding: utf-8 -*-
"""Правки після QA-рев'ю GameObjects: консистентність, точність, Title Case вивісок."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
TR = Path("g:/Claude Code/WoWUkraine/data/translations.json")

FIX = {
    # консистентність "oil" (Oil Puddle уже = Калюжа нафти)
    "Oil Drum": "Бочка з нафтою",
    # точність: об'єкт, а не система
    "Vent": "Вентиляційний отвір",
    # калька -> природне
    "Food Court": "Зона харчування",
    "Signed Guest Book": "Підписана гостьова книга",
    # рідковживане -> зрозуміле
    "Wyvern Roost": "Гніздо віверн",
    # омонім (лава=lava/церк.) -> однозначне
    "Bench": "Лавка",
    # Title Case назв-вивісок/локацій (правило: місця = кожне слово з великої)
    "The Burning Anvil": "«Палаюче Ковадло»",
    "The Cracked Barrel": "«Тріснута Бочка»",
    "The Golden Keg": "«Золоте Барило»",
    "The Shattered Axe": "«Розтрощена Сокира»",
    "The Eternal Forge": "Вічна Кузня",
    "Soulsteel Forge": "Кузня Душосталі",
}

tr = json.loads(TR.read_text(encoding="utf-8-sig"))
sec = tr.get("gameObjects", {})
changed = []
for en, ua in FIX.items():
    if en in sec and sec[en] != ua:
        changed.append((en, sec[en], ua))
        sec[en] = ua
TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Виправлено {len(changed)} записів:")
for en, old, new in changed:
    print(f"  {en}: {old!r} -> {new!r}")
