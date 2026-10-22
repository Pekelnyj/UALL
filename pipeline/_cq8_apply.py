# -*- coding: utf-8 -*-
"""Застосувати 7 верифікованих знахідок калькохвилі 8."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))
it = tr["itemNames"]

FIX = {
    "Amber Shardhide": "Бурштиновий Скалкошкур",
    "Arcweaver Spell Sword": "Чаромеч Чароткача",
    "Ashbringer (Extra Effects)": "Попелобій (Додаткові Ефекти)",
    "Blackthorn Antidote": "Тернова Протиотрута",
    "Blackthorn Clay": "Чорнотернова Глина",
    "Bleakwing Assassin's Grips": "Рукавиці Вбивці Похмурокрилих",
    "Bogreaver": "Болотяний Розривач",
}

ok, miss = 0, []
for en, ua in FIX.items():
    if en in it:
        if it[en] != ua:
            print(f"  ✓ {en}: «{it[en]}» → «{ua}»")
            it[en] = ua
            ok += 1
        else:
            print(f"  = {en}: вже «{ua}»")
    else:
        miss.append(en)

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\nзастосовано: {ok} | не знайдено: {miss}")
