# -*- coding: utf-8 -*-
"""Застосувати 20 верифікованих знахідок калькохвилі 7 (по EN-ключу itemNames)."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))
it = tr["itemNames"]

FIX = {
    "Dragonhawk Pants": "Штани Драконояструба",
    "Fragile Sprite Darter Egg": "Крихке Яйце Стрімкокрилого Спрайта",
    "Darkmoon Draught of Divergence": "Дистилят Темного Місяця: Розгалуження",
    "Quilboar Sticker": "Штрикач Шипогривів",
    "Clefthoof Britches": "Штани Роздвоєнокопита",
    "Nathrian Duelist's Fleshrender": "Плоторозривач Натрійського Дуелянта",
    "Plundered Iceshard Bite": "Награбований Укус Льодоскалки",
    "Crescent Vale Leggings": "Поножі Долини Півмісяця",
    "Gnollbreaker's Boots": "Чоботи Гнолоруйнівника",
    "Devilsaur Barb": "Шип Дияволозавра",
    "The Blackrock Slicer": "Різак Блекрок",
    "Shipwrecker Maul": "Молот Згубника Кораблів",
    "Reverent Forgelite's Breeches": "Штани Шанобливого Форджлайта",
    "Silversnap Bottle Opener": "Відкривачка для Пляшок «Сільверснап»",
    "The Fleshshaper": "Плототворець",
    "Fleshrender's Painbringer": "Боленосець Плотероздирача",
    "Rip-Flayer Leggings": "Поножі Розривача-Білувача",
    "Akunda's Shocksplitter": "Розрядорозкол Акунди",
    "Eternally Folded Blade": "Нескінченно Складаний Клинок",
    "Demonbreaker Legplates": "Латні Поножі Винищувача Демонів",
}

ok, miss = 0, []
for en, ua in FIX.items():
    if en in it:
        old = it[en]
        if old != ua:
            print(f"  ✓ {en}: «{old}» → «{ua}»")
            it[en] = ua
            ok += 1
        else:
            print(f"  = {en}: вже «{ua}»")
    else:
        miss.append(en)

# Сиблінг-фікс: Discordant Forgelite's Breeches теж має зламане «Ковалесвіт»
for en, ua in list(it.items()):
    if "Forgelite" in en and ("Ковалесвіт" in ua or "Ковалесвіт" in ua):
        new = ua.replace("Ковалесвітла", "Форджлайта").replace("Ковалесвіта", "Форджлайта").replace("Ковалесвіт", "Форджлайт")
        if new != ua:
            print(f"  ✓ [sib] {en}: «{ua}» → «{new}»")
            it[en] = new
            ok += 1

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\nзастосовано: {ok} | не знайдено ключів: {miss}")
