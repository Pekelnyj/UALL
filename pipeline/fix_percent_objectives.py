"""Базові (без лічильника) форми для відсоткових цілей + смислові правки.

Проблема: дамп зловив рядки з "(0%)"/"(47%)" — переклади лягли під точні
ключі і працюють лише при тому самому відсотку. Додаємо базові ключі
(спрацьовують за будь-якого прогресу, шаблон у TrackerHooks уже вміє)
як batch_13/out_13, плюс правимо помилки на кшталт «Вбито Клинок
Сутінків» (вбивають БІЙЦІВ загону, не один клинок).
"""

import json

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "batches" / "objectives"

# Базові форми: en-без-лічильника -> ua.
BASES = {
    "Attract Torentia's attention": "Приверніть увагу Торентії",
    "Manaforge disrupted": "Роботу манакузні зірвано",
    "Clues found in Tranquillien": "Знайдено зачіпки у Транквілліені",
    "Fight back the Twilight's Blade": "Відбийте натиск Клинка Сутінків",
    "Troll lumber operations disrupted": "Зірвано лісозаготівлю тролів",
    "Disrupt Twilight forces": "Послабте сили Сутінкового Молота",
    "Hinder the attacking Void forces": "Стримайте наступ сил Порожнечі",
    "Light's Hope defended": "Захищено Каплицю Надії Світла",
    "Defeat Scarlet forces": "Переможіть багряні війська",
    "Defeat Alnscorned enemies in the Rift of Aln":
        "Переможіть зневажених Альном ворогів у Розломі Альну",
    "Lightbloom forces defeated": "Переможено сили Світлоцвіту",
    "Rout the Lightbloom Frenzy": "Розгроміть шал Світлоцвіту",
    "Tasks completed": "Виконано доручення",
    "Skyglass Recovered": "Зібрано небесне скло",
    "Interrogate the captive": "Допитайте полоненого",
    "Wreck camp": "Розгромте табір",
    "Demonstrate your abilities": "Продемонструйте свої здібності",
}

# Смислові правки наявних записів (у будь-якому out-файлі).
FIXES = {
    "Twilight's Blade slain": "Вбито бійців Клинка Сутінків",
    "Fight back the Twilight's Blade (0%)": "Відбийте натиск Клинка Сутінків (0%)",
    "Kill Shadowguards or Kill Players": "Вбивайте бійців Тіньової варти або гравців",
    "Kill Ethereal or Kill Players": "Вбивайте ефіріалів або гравців",
    "Kill Behemoths or Kill Players": "Вбивайте бегемотів або гравців",
}


def main():
    # 1) точкові правки в наявних out-файлах
    fixed = 0
    for path in sorted(BATCH_DIR.glob("out_*.json")):
        items = json.loads(path.read_text(encoding="utf-8"))
        changed = False
        for item in items:
            fix = FIXES.get(item.get("en", ""))
            if fix and item.get("ua") != fix:
                item["ua"] = fix
                changed = True
                fixed += 1
        if changed:
            path.write_text(json.dumps(items, ensure_ascii=False, indent=1),
                            encoding="utf-8")

    # 2) нові базові ключі окремим батчем (щоб merge їх прийняв)
    batch = [{"en": en, "context": "базова форма відсоткової цілі"}
             for en in sorted(BASES)]
    out = [{"en": en, "ua": BASES[en]} for en in sorted(BASES)]
    (BATCH_DIR / "batch_13.json").write_text(
        json.dumps(batch, ensure_ascii=False, indent=1), encoding="utf-8")
    (BATCH_DIR / "out_13.json").write_text(
        json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")

    print(f"Правок у наявних: {fixed} | нових базових: {len(BASES)}")


if __name__ == "__main__":
    main()
