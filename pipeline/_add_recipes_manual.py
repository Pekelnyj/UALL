# -*- coding: utf-8 -*-
"""Ручний переклад залишку рецептів (крафт-енчанти/стати) — канон статів із glossary.md,
узгодження роду. Застосовується до всіх recipe-ID із відповідною EN-назвою."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
BASE = Path("g:/Claude Code/WoWUkraine")
TR = BASE / "data/translations.json"

M = {
    # Accord / Binding / Breath / Gift / Pact / Seal / Word — енчант-«X статy» (родовий)
    "Accord of Critical Strike": "Згода Критичного удару",
    "Accord of Haste": "Згода Поспіху",
    "Accord of Mastery": "Згода Майстерності",
    "Accord of Versatility": "Згода Універсальності",
    "Binding of Agility": "Зв'язування Спритності",
    "Binding of Critical Strike": "Зв'язування Критичного удару",
    "Binding of Haste": "Зв'язування Поспіху",
    "Binding of Intellect": "Зв'язування Інтелекту",
    "Binding of Mastery": "Зв'язування Майстерності",
    "Binding of Strength": "Зв'язування Сили",
    "Binding of Versatility": "Зв'язування Універсальності",
    "Breath of Critical Strike": "Подих Критичного удару",
    "Breath of Haste": "Подих Поспіху",
    "Breath of Mastery": "Подих Майстерності",
    "Breath of Versatility": "Подих Універсальності",
    "Gift of Critical Strike": "Дар Критичного удару",
    "Gift of Haste": "Дар Поспіху",
    "Gift of Mastery": "Дар Майстерності",
    "Gift of Versatility": "Дар Універсальності",
    "Pact of Critical Strike": "Пакт Критичного удару",
    "Pact of Haste": "Пакт Поспіху",
    "Pact of Mastery": "Пакт Майстерності",
    "Pact of Versatility": "Пакт Універсальності",
    "Seal of Critical Strike": "Печатка Критичного удару",
    "Seal of Haste": "Печатка Поспіху",
    "Seal of Mastery": "Печатка Майстерності",
    "Seal of Versatility": "Печатка Універсальності",
    "Word of Agility": "Слово Спритності",
    "Word of Critical Strike": "Слово Критичного удару",
    "Word of Haste": "Слово Поспіху",
    "Word of Intellect": "Слово Інтелекту",
    "Word of Mastery": "Слово Майстерності",
    "Word of Strength": "Слово Сили",
    "Word of Versatility": "Слово Універсальності",
    "Writ of Avoidance": "Грамота Уникнення",
    "Writ of Leech": "Грамота Висмоктування",
    "Writ of Speed": "Грамота Швидкості",
    # Голі стати
    "Agility": "Спритність",
    "Strength": "Сила",
    "Intellect": "Інтелект",
    "Stamina": "Витривалість",
    "Spellpower": "Сила заклять",
    "Protection": "Захист",
    "Dodge": "Ухилення",
    "Perception": "Сприйняття",
    "Precision": "Точність",
    "Accuracy": "Влучність",
    "Deftness": "Вправність",
    "Finesse": "Витонченість",
    "Ingenuity": "Винахідливість",
    "Resourcefulness": "Ощадливість",
    "Multicraft": "Множинне виготовлення",
    "Concentration": "Зосередження",
    "Skill": "Навичка",
    "Quality": "Якість",
    "Knowledge": "Знання",
    "Sparks": "Іскри",
    "Stats": "Характеристики",
    "Assault": "Натиск",
    "Siphoning": "Поглинання",
    # Ступені + стат (рід узгоджено)
    "Greater Agility": "Велика Спритність",
    "Greater Assault": "Великий Натиск",
    "Greater Critical Strike": "Великий Критичний удар",
    "Greater Dodge": "Велике Ухилення",
    "Greater Haste": "Великий Поспіх",
    "Greater Intellect": "Великий Інтелект",
    "Greater Speed": "Велика Швидкість",
    "Greater Spellpower": "Велика Сила заклять",
    "Greater Stamina": "Велика Витривалість",
    "Greater Stats": "Великі характеристики",
    "Greater Strength": "Велика Сила",
    "Greater Versatility": "Велика Універсальність",
    "Lesser Agility": "Менша Спритність",
    "Lesser Dodge": "Менше Ухилення",
    "Lesser Intellect": "Менший Інтелект",
    "Lesser Protection": "Менший Захист",
    "Lesser Stamina": "Менша Витривалість",
    "Lesser Versatility": "Менша Універсальність",
    "Major Agility": "Значна Спритність",
    "Major Armor": "Значна Броня",
    "Major Healing": "Значне Зцілення",
    "Major Intellect": "Значний Інтелект",
    "Major Spellpower": "Значна Сила заклять",
    "Major Stamina": "Значна Витривалість",
    "Major Strength": "Значна Сила",
    "Major Versatility": "Значна Універсальність",
    "Minor Agility": "Незначна Спритність",
    "Minor Health": "Незначне Здоров'я",
    "Minor Stamina": "Незначна Витривалість",
    "Mighty Intellect": "Могутній Інтелект",
    "Mighty Versatility": "Могутня Універсальність",
    "Superior Agility": "Вища Спритність",
    "Superior Dodge": "Вище Ухилення",
    "Superior Intellect": "Вищий Інтелект",
    "Superior Stamina": "Вища Витривалість",
    "Exceptional Spellpower": "Виняткова Сила заклять",
    "Exceptional Strength": "Виняткова Сила",
    "Exceptional Versatility": "Виняткова Універсальність",
    "Versatility Prime": "Найкраща Універсальність",
    # Mark of the X
    "Mark of the Ancient Priestess": "Знак Прадавньої жриці",
    "Mark of the Claw": "Знак Кігтя",
    "Mark of the Deadly": "Знак Смертоносного",
    "Mark of the Distant Army": "Знак Далекої армії",
    "Mark of the Heavy Hide": "Знак Товстої шкури",
    "Mark of the Hidden Satyr": "Знак Прихованого сатира",
    "Mark of the Master": "Знак Майстра",
    "Mark of the Quick": "Знак Спритного",
    "Mark of the Trained Soldier": "Знак Вишколеного солдата",
    "Mark of the Versatile": "Знак Універсального",
    # Navigation-енчанти (TWW) + морські
    "Deadly Navigation": "Смертоносна навігація",
    "Masterful Navigation": "Майстерна навігація",
    "Quick Navigation": "Швидка навігація",
    "Stalwart Navigation": "Незламна навігація",
    "Versatile Navigation": "Універсальна навігація",
    "Coastal Surge": "Прибережна хвиля",
    "Oceanic Restoration": "Океанічне відновлення",
    "Torrent of Elements": "Потік стихій",
    # Інше
    "Heart in a Bottle": "Серце в пляшці",
    "Machinist's Brilliance": "Блиск механіка",
    "Force Multiplier": "Множник сили",
    "Gale-Force Striking": "Удар штормової сили",
    "Naga Hide": "Шкура наги",
    "Osmenite Deposit": "Поклад осменіту",
    "Osmenite Seam": "Жила осменіту",
    "Swift Hearthing": "Прискорене повернення",
    "Recraft Equipment": "Переробка спорядження",
    "Carve Meat": "Розбирання м'яса",
    "Transmute: Cloth to Skins": "Трансмутація: Тканина в шкури",
    "Transmute: Fish to Gems": "Трансмутація: Риба в самоцвіти",
    "Transmute: Meat to Pet": "Трансмутація: М'ясо в улюбленця",
    # Refine X — зберігаємо |A:...|a-код як є
    "Refine Herbs - |A:Professions-ChatIcon-Quality-Tier2:20:20|a": "Обробка трав - |A:Professions-ChatIcon-Quality-Tier2:20:20|a",
    "Refine Herbs - |A:Professions-ChatIcon-Quality-Tier3:20:20|a": "Обробка трав - |A:Professions-ChatIcon-Quality-Tier3:20:20|a",
    "Refine Hides - |A:Professions-ChatIcon-Quality-Tier2:20:20|a": "Обробка шкур - |A:Professions-ChatIcon-Quality-Tier2:20:20|a",
    "Refine Hides - |A:Professions-ChatIcon-Quality-Tier3:20:20|a": "Обробка шкур - |A:Professions-ChatIcon-Quality-Tier3:20:20|a",
    "Refine Leather - |A:Professions-ChatIcon-Quality-Tier2:20:20|a": "Обробка шкіри - |A:Professions-ChatIcon-Quality-Tier2:20:20|a",
    "Refine Leather - |A:Professions-ChatIcon-Quality-Tier3:20:20|a": "Обробка шкіри - |A:Professions-ChatIcon-Quality-Tier3:20:20|a",
}

tr = json.loads(TR.read_text(encoding="utf-8-sig"))
rc = json.loads((BASE / "data/source/api_recipes.json").read_text(encoding="utf-8-sig"))
rct = tr.setdefault("recipes", {})

applied = 0
missing = set()
for k, v in rc.items():
    if k in rct:
        continue
    en = v.get("name", {}).get("en", "")
    if en in M:
        rct[k] = {"name": M[en]}
        applied += 1
    elif en:
        missing.add(en)

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Застосовано до {applied} recipe-ID | рецептів усього: {len(rct):,}")
print(f"Словник покрив: {len(M)} EN-назв")
if missing:
    print(f"НЕ покрито ({len(missing)} унікальних):")
    for e in sorted(missing):
        print("   ", e)
