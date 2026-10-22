# -*- coding: utf-8 -*-
"""Write out_006.json — translated item flavor (recipe/teach strings)."""
import json
from pathlib import Path

SRC = Path(r"G:\Claude Code\WoWUkraine\data\flavor_batches\batch_006.json")
OUT = Path(r"G:\Claude Code\WoWUkraine\data\flavor_batches\out_006.json")

T = {
    "Teaches you how to cook Azshari Salad more efficiently.":
        "Навчає вас готувати «Азшарський салат» ефективніше.",
    "Teaches you how to cook Barracuda Mrglgagh more efficiently.":
        "Навчає вас готувати «Барракуду Мрґлґаґ» ефективніше.",
    "Teaches you how to cook Bear Tartare more efficiently.":
        "Навчає вас готувати «Ведмежий тартар» ефективніше.",
    "Teaches you how to cook Crispy Bacon more efficiently.":
        "Навчає вас готувати «Хрусткий бекон» ефективніше.",
    "Teaches you how to cook Deep-Fried Mossgill more efficiently.":
        "Навчає вас готувати «Смажену мохозябру» ефективніше.",
    "Teaches you how to cook Dried Mackerel Strips more efficiently.":
        "Навчає вас готувати «Сушені смужки скумбрії» ефективніше.",
    "Teaches you how to cook Drogbar-Style Salmon more efficiently.":
        "Навчає вас готувати «Лосось по-дроґбарськи» ефективніше.",
    "Teaches you how to cook Faronaar Fizz more efficiently.":
        "Навчає вас готувати «Фаронаарську шипучку» ефективніше.",
    "Teaches you how to cook Fighter Chow more efficiently.":
        "Навчає вас готувати «Солдатську їжу» ефективніше.",
    "Teaches you how to cook Fishbrul Special more efficiently.":
        "Навчає вас готувати «Фішбрул особливий» ефективніше.",
    "Teaches you how to cook Hearty Feast more efficiently.":
        "Навчає вас готувати «Ситний бенкет» ефективніше.",
    "Teaches you how to cook Koi-Scented Stormray more efficiently.":
        "Навчає вас готувати «Штормоската з ароматом коі» ефективніше.",
    "Teaches you how to cook Lavish Suramar Feast more efficiently.":
        "Навчає вас готувати «Розкішний бенкет Сурамару» ефективніше.",
    "Teaches you how to cook Leybeque Ribs more efficiently.":
        "Навчає вас готувати «Ребра по-лейбекю» ефективніше.",
    "Teaches you how to cook Nightborne Delicacy Platter more efficiently.":
        "Навчає вас готувати «Делікатесну тацю нічнороджених» ефективніше.",
    "Teaches you how to cook Pickled Stormray more efficiently.":
        "Навчає вас готувати «Мариновану штормоскату» ефективніше.",
    "Teaches you how to cook Salt and Pepper Shank more efficiently.":
        "Навчає вас готувати «Рульку із сіллю та перцем» ефективніше.",
    "Teaches you how to cook Seed-Battered Fish Plate more efficiently.":
        "Навчає вас готувати «Рибу в зерновій паніровці» ефективніше.",
    "Teaches you how to cook Spiced Rib Roast more efficiently.":
        "Навчає вас готувати «Пряні смажені ребра» ефективніше.",
    "Teaches you how to cook Suramar Surf and Turf more efficiently.":
        "Навчає вас готувати «Море і суходіл Сурамару» ефективніше.",
    "Teaches you how to cook The Hungry Magister more efficiently.":
        "Навчає вас готувати «Голодного магістра» ефективніше.",
    "Teaches you how to craft Battlebound Treads.":
        "Навчає вас виготовляти «Чоботи бойової присяги».",
    "Teaches you how to craft Imbued Silkweave Epaulets.":
        "Навчає вас виготовляти «Просочені наплічники з шовкоплетива».",
    "Teaches you how to craft Imbued Silkweave Gloves.":
        "Навчає вас виготовляти «Просочені рукавички з шовкоплетива».",
    "Teaches you how to craft Imbued Silkweave Pantaloons.":
        "Навчає вас виготовляти «Просочені штани з шовкоплетива».",
    "Teaches you how to craft Imbued Silkweave Slippers.":
        "Навчає вас виготовляти «Просочені капці з шовкоплетива».",
    "Teaches you how to craft Sinister Combatant's Leather Leggings more efficiently.":
        "Навчає вас виготовляти «Шкіряні поножі лиховісного бійця» ефективніше.",
    "Teaches you how to craft a Battlebound Warhelm.":
        "Навчає вас виготовляти «Бойовий шолом бойової присяги».",
    "Teaches you how to craft a Codex of the Tranquil Mind extremely efficiently.":
        "Навчає вас виготовляти «Кодекс спокійного розуму» надзвичайно ефективно.",
    "Teaches you how to craft a Codex of the Tranquil Mind more efficiently.":
        "Навчає вас виготовляти «Кодекс спокійного розуму» ефективніше.",
    "Teaches you how to craft a Deep Amber Loop.":
        "Навчає вас виготовляти «Перстень із глибинного бурштину».",
    "Teaches you how to craft a Famine Evaluator And Snack Table more efficiently.":
        "Навчає вас виготовляти «Оцінювач голоду з перекусним столом» ефективніше.",
    "Teaches you how to craft a Icebane Bracers.":
        "Навчає вас виготовляти «Льодоборні наручі».",
    "Teaches you how to craft a Icebane Breastplate.":
        "Навчає вас виготовляти «Льодоборний нагрудник».",
    "Teaches you how to craft a Icebane Gauntlets.":
        "Навчає вас виготовляти «Льодоборні латні рукавиці».",
    "Teaches you how to craft a Icy Scale Bracers.":
        "Навчає вас виготовляти «Наручі з крижаної луски».",
    "Teaches you how to craft a Icy Scale Breastplate.":
        "Навчає вас виготовляти «Нагрудник з крижаної луски».",
    "Teaches you how to craft a Icy Scale Gauntlets.":
        "Навчає вас виготовляти «Латні рукавиці з крижаної луски».",
    "Teaches you how to craft a Polar Bracers.":
        "Навчає вас виготовляти «Полярні наручі».",
    "Teaches you how to craft a Polar Gloves.":
        "Навчає вас виготовляти «Полярні рукавички».",
    "Teaches you how to craft a Skystone Loop.":
        "Навчає вас виготовляти «Перстень із небокаменю».",
    "Teaches you how to craft a Vantus Rune: Antorus, the Burning Throne more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Анторус, Палаючий трон» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Battle of Dazar'alor more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Битва за Дазар'алор» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Black Rook Hold more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Цитадель Чорного Грака» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Cathedral of Eternal Night more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Собор Вічної Ночі» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Cenarius.":
        "Навчає вас виготовляти «Руну Вантус: Кенарій».",
    "Teaches you how to craft a Vantus Rune: Chronomatic Anomaly.":
        "Навчає вас виготовляти «Руну Вантус: Хрономатична аномалія».",
    "Teaches you how to craft a Vantus Rune: Court of Stars more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Двір Зірок» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Crucible of Storms more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Горнило Бур» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Darkheart Thicket more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Хащі Темносердя» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Dragons of Nightmare.":
        "Навчає вас виготовляти «Руну Вантус: Дракони Жахіття».",
    "Teaches you how to craft a Vantus Rune: Elerethe Renferal.":
        "Навчає вас виготовляти «Руну Вантус: Елерете Ренферал».",
    "Teaches you how to craft a Vantus Rune: Eye of Azshara more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Око Азшари» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Grand Magistrix Elisande.":
        "Навчає вас виготовляти «Руну Вантус: Велика магістрикс Елісанда».",
    "Teaches you how to craft a Vantus Rune: Gul'dan.":
        "Навчає вас виготовляти «Руну Вантус: Ґул'дан».",
    "Teaches you how to craft a Vantus Rune: Halls of Valor more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Зали Доблесті» ефективніше.",
    "Teaches you how to craft a Vantus Rune: High Botanist Tel'arn.":
        "Навчає вас виготовляти «Руну Вантус: Верховний ботанік Тел'арн».",
    "Teaches you how to craft a Vantus Rune: Il'gynoth, The Heart of Corruption.":
        "Навчає вас виготовляти «Руну Вантус: Іл'ґінот, Серце Скверни».",
    "Teaches you how to craft a Vantus Rune: Krosus.":
        "Навчає вас виготовляти «Руну Вантус: Кросус».",
    "Teaches you how to craft a Vantus Rune: Maw of Souls more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Паща Душ» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Neltharion's Lair more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Лігво Нельтаріона» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Nya'lotha, the Waking City.":
        "Навчає вас виготовляти «Руну Вантус: Ня'лота, Пробуджене місто».",
    "Teaches you how to craft a Vantus Rune: Nythendra.":
        "Навчає вас виготовляти «Руну Вантус: Нітендра».",
    "Teaches you how to craft a Vantus Rune: Return to Karazhan (Lower) more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Повернення в Каразан (нижній)» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Return to Karazhan (Upper) more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Повернення в Каразан (верхній)» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Skorpyron.":
        "Навчає вас виготовляти «Руну Вантус: Скорпірон».",
    "Teaches you how to craft a Vantus Rune: Spellblade Aluriel.":
        "Навчає вас виготовляти «Руну Вантус: Чароклинок Алуріель».",
    "Teaches you how to craft a Vantus Rune: Star Augur Etraeus.":
        "Навчає вас виготовляти «Руну Вантус: Зоряний провісник Етрей».",
    "Teaches you how to craft a Vantus Rune: The Arcway more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Чародійний шлях» ефективніше.",
    "Teaches you how to craft a Vantus Rune: The Eternal Palace more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Вічний палац» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Tichondrius.":
        "Навчає вас виготовляти «Руну Вантус: Тікондрій».",
    "Teaches you how to craft a Vantus Rune: Tomb of Sargeras more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Гробниця Саргераса» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Trilliax.":
        "Навчає вас виготовляти «Руну Вантус: Трилліакс».",
    "Teaches you how to craft a Vantus Rune: Uldir more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Улдір» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Ursoc.":
        "Навчає вас виготовляти «Руну Вантус: Урсок».",
    "Teaches you how to craft a Vantus Rune: Vault of the Wardens more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Сховище Вартових» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Violet Hold more efficiently.":
        "Навчає вас виготовляти «Руну Вантус: Фіолетова фортеця» ефективніше.",
    "Teaches you how to craft a Vantus Rune: Xavius.":
        "Навчає вас виготовляти «Руну Вантус: Ксавій».",
    "Teaches you how to craft an Azsunite Loop.":
        "Навчає вас виготовляти «Перстень із азсуніту».",
    "Teaches you how to craft an Embroidered Deep Sea Bag.":
        "Навчає вас виготовляти «Вишиту глибоководну торбу».",
}


def main():
    src = json.loads(SRC.read_text(encoding="utf-8-sig"))
    missing = [k for k in src if k not in T]
    extra = [k for k in T if k not in src]
    if missing:
        raise SystemExit(f"MISSING {len(missing)}: {missing[:3]}")
    if extra:
        raise SystemExit(f"EXTRA {len(extra)}: {extra[:3]}")
    out = {k: T[k] for k in src}  # preserve source order, exact keys
    OUT.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"OK {len(out)}")


if __name__ == "__main__":
    main()
