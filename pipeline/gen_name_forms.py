"""Генерує Database/NameForms.lua — мапа кириличний СТЕМ імені -> латинський
оригінал. Використовується опцією «оригінальні імена»: аддон замінює будь-яке
слово, що починається на стем (усі відмінки), на англійський оригінал.

Кілька стемів можуть вказувати на одне ім'я (наші різночитання: Сильван/Сільван).

Використання: python gen_name_forms.py
"""

import json
from common import DATA_DIR

OUT = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "NameForms.lua")

# стем (кириличний, з великої) -> англійський оригінал.
# Стем = незмінний префікс перед відмінковим закінченням. Кілька варіантів —
# на випадок наших різночитань. Підбирай стем досить довгим, щоб не чіпати
# звичайні слова (матчимо лише з великої літери + початок слова).
NAME_STEMS = {
    "Вратіон": "Wrathion",
    "Іллідан": "Illidan",
    "Кадґар": "Khadgar", "Кадгар": "Khadgar",
    "Тралл": "Thrall",
    "Сільван": "Sylvanas", "Сильван": "Sylvanas",
    "Андуїн": "Anduin",
    "Тіранд": "Tyrande", "Тиранд": "Tyrande",
    "Малфуріон": "Malfurion", "Мальфуріон": "Malfurion",
    "Джайн": "Jaina",
    "Болвар": "Bolvar",
    "Тураліон": "Turalyon",
    "Аллорі": "Alleria", "Аллері": "Alleria",
    "Велен": "Velen",
    "Саурфанг": "Saurfang", "Сорфанг": "Saurfang",
    "Натанос": "Nathanos",
    "Артас": "Arthas",
    "Утер": "Uther",
    "Кель'тас": "Kael'thas", "Келя'тас": "Kael'thas",
    "Вереса": "Vereesa",
    "Ліадрін": "Liadrin",
    "Валір": "Valeera",
    "Ксал'атат": "Xal'atath",
    "Лор'темар": "Lor'themar",
    "Генн": "Genn",
    "Майєв": "Maiev", "Маїв": "Maiev",
    "Тіріон": "Tirion",
    "Вол'джин": "Vol'jin",
    "Бейн": "Baine",
    "Талісра": "Thalyssra", "Таліссра": "Thalyssra",
    "Роммат": "Rommath",
    "Гальдурон": "Halduron", "Галдурон": "Halduron",
    "Тельдрассіл": "Teldrassil",
    "Бвонсамді": "Bwonsamdi",
    "Варіан": "Varian",
    "Магні": "Magni",
    # --- Канон ТРАНСЛІТЕРОВАНИХ ПРІЗВИЩ (опція «оригінал» показує EN і для них) ---
    "Віндраннер": "Windrunner",
    "Стормрейдж": "Stormrage",
    "Геллскрім": "Hellscream",
    "Бладгуф": "Bloodhoof",
    "Віспервінд": "Whisperwind",
    "Бронзбірд": "Bronzebeard",
    "Ґреймейн": "Greymane", "Греймейн": "Greymane",
    "Шедовсонг": "Shadowsong",
    "Вайлдгаммер": "Wildhammer",
    "Троллбейн": "Trollbane",
    "Рейвенкрест": "Ravencrest",
    "Блекгенд": "Blackhand",
    "Ґрімтотем": "Grimtotem", "Грімтотем": "Grimtotem",
    "Рейджтотем": "Ragetotem",
    "Думгаммер": "Doomhammer",
    "Ертф'юрі": "Earthfury",
    "Бладф'юрі": "Bloodfury",
    "Санф'юрі": "Sunfury",
    "Дедай": "Deadeye",
    "Найтвінд": "Nightwind",
    "Брайтвінг": "Brightwing",
    "Донблейд": "Dawnblade",
    "Мунблейд": "Moonblade",
    "Блейдвінд": "Bladewind",
    "Фелсторм": "Felstorm",
    "Гаймаунтейн": "Highmountain",
    "Сонстрайдер": "Sunstrider",
    "Менетіл": "Menethil",
    # --- Імена відомих персонажів, яких бракувало ---
    "Ґаррош": "Garrosh", "Гаррош": "Garrosh",
    "Ґром": "Grom", "Ґроммаш": "Grommash",
    "Кайрн": "Cairne",
    "Мурадін": "Muradin",
    "Бранн": "Brann",
    "Фалстад": "Falstad",
    "Кілроґ": "Kilrogg", "Кілроґґ": "Kilrogg",
    "Тесс": "Tess",
}

HEADER = """-- WoWUkraine: мапа СТЕМ кириличного імені -> латинський оригінал.
-- ЦЕЙ ФАЙЛ ГЕНЕРУЄТЬСЯ АВТОМАТИЧНО (pipeline/gen_name_forms.py) — не редагуй вручну.
-- Використовує опція «Імена персонажів: оригінал». Аддон замінює слово, що
-- починається на стем (будь-який відмінок), на англійський оригінал.

local _, ns = ...

ns.nameForms = {
"""


def lua_q(s):
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"') + '"'


def main():
    lines = [HEADER]
    for stem in sorted(NAME_STEMS):
        lines.append(f"    [{lua_q(stem)}] = {lua_q(NAME_STEMS[stem])},\n")
    lines.append("}\n")
    OUT.write_text("".join(lines), encoding="utf-8")
    uniq = len(set(NAME_STEMS.values()))
    print(f"NameForms.lua: {len(NAME_STEMS)} стемів -> {uniq} імен")


if __name__ == "__main__":
    main()
