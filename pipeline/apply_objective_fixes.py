"""Точкові виправлення цілей за рецензією (data/review_objectives_*.md).

Правки застосовуються до out-файлів (джерело істини для merge),
далі merge_objective_batches.py перезбирає translations.json і Lua-базу.
"""

import json

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "batches" / "objectives"

FIXES = {
    "Coalesced Fire touched": "Торкнуто згуслого вогню",
    "Decrepit Ranger Constructs activated": "Активовано занедбані конструкти слідопитів",
    "Escape on the Empowered Dragonhawk": "Втечіть на посиленому драконоястребі",
    "Guns Destroyed with Cannon": "Знищено гармати з бортової гармати",
    "Hawkstrider Fledgling sent back": "Повернуто пташеня яструбоступа",
    "Miscreant Baras stopped": "Зупинено Бараса-негідника",
    "Ranger Lethvalin slain": "Вбито слідопита Летваліна",
    "Riftblade Maella found": "Знайдено Маеллу, Клинка Розлому",
    "Roots tended": "Доглянуто коріння",
    "Sharpmaw approached": "Наблизилися до Гостропащі",
    "Spore Spewing Shrooms Destroyed": "Знищено гриби, що розсівають спори",
    "Stellar Vortex entered": "Пройдено у зоряний вир",
    "Subdue Creatures or Kill Players (0%)": "Приборкуйте істот або вбивайте гравців (0%)",
    "Subdue Void Creatures or Kill Players (0%)": "Приборкуйте істот Порожнечі або вбивайте гравців (0%)",
    "The Echoless Flame used to slay Rift manifestations": "Знищено прояви Розлому Полум'ям без відлуння",
    "Tomes of Polymorph collected": "Зібрано фоліанти Перетворення",
    "Vanatha confronted": "Кинуто виклик Ванаті",
    "Void Anomalies Dispersed": "Розвіяно аномалії Порожнечі",
    "Void Echoes collected": "Зібрано Відлуння Порожнечі",
    "Witherbark Rings sped through": "Пройдено кільця Візербарків",
    "Wreck camp (0%)": "Розгромте табір (0%)",
}


def main():
    applied = 0
    for path in sorted(BATCH_DIR.glob("out_*.json")):
        items = json.loads(path.read_text(encoding="utf-8"))
        changed = False
        for item in items:
            fix = FIXES.get(item.get("en", ""))
            if fix and item.get("ua") != fix:
                item["ua"] = fix
                changed = True
                applied += 1
        if changed:
            path.write_text(json.dumps(items, ensure_ascii=False, indent=1),
                            encoding="utf-8")
    print(f"Застосовано виправлень: {applied}/{len(FIXES)}")


if __name__ == "__main__":
    main()
