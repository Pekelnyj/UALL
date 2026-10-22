# -*- coding: utf-8 -*-
"""Разовий ремонт підміни ключ<->значення в uiTooltips (26.08.2026).

Хвиля підказок приписала 8 готових українських тіл ключам-сусідам по
абетці. Найпомітніше в грі: під «Warlock - Demonology» лежало двохрядкове
тіло підказки іграшки «Wyrmhole Generator», тож у вікні швидкого вступу
замість спеціалізації показувало «Генератор вирмодір: Драконові Острови»,
а другий рядок затуляв напис сусіда-паладина.

Правильні ключі для всіх 8 значень у базі вже є — це зайві копії, а не
втрачений переклад, тож чужі пари просто знімаємо.

Заразом закриваємо те, що спливло під час розбору:
  • «Holy» перекладено як «Свято» (свято в календарі) — і в uiTooltips,
    і в garrison. Holy — це святість;
  • з 39 комбінацій «клас — спеціалізація» бракувало 12, тобто в грі вони
    лишалися англійськими.

Канон спеціалізацій узято з того, що база вже вживає (гарнізонні
спеціалізації Blizzard уживають ті самі англійські слова + частотність у
назвах заклять), а не вигадано [[verify-names-by-id-anchor]].
Класи — за таблицею glossary.md §Класи.

Запуск: python _fix_kv_shift_0826.py [--apply]
Далі: python generate_db.py && python _check_kv_shift.py
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv

# --- 1. Чужі пари: значення належить іншому ключу -----------------------------
# Ті, для яких у базі є доказовий якір, не викидаємо, а замінюємо на нього.
DROP = [
    "Waking Dream",            # questObjectives «Марення Наяву» vs spell «Сон
                               # наяву» — контекст підказки невідомий, не гадаємо
    "Warded Lockbox",          # предмет без перекладу в itemNames
    "Warlord Malaja",          # ім'я істоти без якоря в creatures.json
    "Waterfowl",
    "Venomgall Tyrant",        # ім'я істоти без якоря
]
REFILL = {
    # якір: vignette «Бойова Барабанщиця Зурула»
    "Wardrummer Zurula": "Бойова Барабанщиця Зурула",
    # якір: «Warband M+ Score» -> «Рейтинг М+ бойової ватаги»
    "Warband Completed Quests": "Виконані завдання бойової ватаги",
}

# --- 2. Клас — спеціалізація --------------------------------------------------
# Наявні 26 записів уживають тире «—», тримаємося тієї самої форми.
SPECS = {
    "Evoker - Devastation": "Пробуджувач — Спустошення",
    "Evoker - Preservation": "Пробуджувач — Збереження",
    "Evoker - Augmentation": "Пробуджувач — Посилення",
    "Hunter - Survival": "Мисливець — Виживання",
    "Mage - Frost": "Маг — Мороз",
    "Monk - Mistweaver": "Монах — Туманник",
    "Priest - Holy": "Жрець — Святість",
    "Shaman - Enhancement": "Шаман — Вдосконалення",
    "Warlock - Affliction": "Чорнокнижник — Гноблення",
    "Warlock - Demonology": "Чорнокнижник — Демонологія",
    "Warlock - Destruction": "Чорнокнижник — Руйнування",
    "Warrior - Fury": "Воїн — Лють",
    "Warrior - Protection": "Воїн — Захист",
    # «Свято» — це календарне свято, а не Holy
    "Paladin - Holy": "Паладин — Святість",
    # назви класу Evoker у базі не було зовсім
    "Evoker": "Пробуджувач",
}

# --- 3. Родина «Visit the Candy Buckets in …» ---------------------------------
# Шість із семи рядків родини тримали геть чужі тіла («Замовлення на роботу»,
# «Дивовижна риба»), і довжина цього не показала: 39 символів проти 36. Видав
# їх спільний англійський початок при різних українських.
# Правильну форму беремо не з голови, а з їхнього ж цілого побратима:
# «Visit the Candy Buckets in Eastern Kingdoms.» -> «Відвідай Відра цукерок
# у Східних Королівствах.» Назви обширів — за точними ключами бази
# (Аутленд, Нортренд, Пандарія).
CANDY = {
    "Visit the Candy Buckets in Kalimdor.":
        "Відвідай Відра цукерок у Калімдорі.",
    "Visit the Candy Buckets in Northrend.":
        "Відвідай Відра цукерок у Нортренді.",
    "Visit the Candy Buckets in Outland.":
        "Відвідай Відра цукерок в Аутленді.",
    "Visit the Candy Buckets in Pandaria.":
        "Відвідай Відра цукерок у Пандарії.",
    "Visit the Candy Buckets in Cataclysm zones.":
        "Відвідай Відра цукерок у зонах Катаклізму.",
    "Visit the Candy Buckets in the Dragon Isles zones.":
        "Відвідай Відра цукерок у зонах Драконових Островів.",
}

# --- 4. Підміна, рознесена нашим власним інструментом -------------------------
# `_xref_wave.py` перевикористовує готові переклади з бази за англійським
# ключем — і слухняно скопіював зіпсоване «Слалом Дикого Заповідника…» з
# підказок ще й в ім'я істоти 258779. Тобто підміна не лежала, а
# РОЗМНОЖУВАЛАСЯ; заслін тепер стоїть у самому xref.
# Форма за домінантою бази: Vilescar = Скверношрам (5 форм, ця найчастіша).
NPC_FIX = {"258779": "Браконьєр Скверношраму"}

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
ui = tr.setdefault("uiTooltips", {})
npc = tr.setdefault("npcNames", {})
gar = tr.setdefault("garrison", {})

print("--- зняти чужі пари ---")
dropped = 0
for k in DROP:
    if k in ui:
        print(f"  - {k!r}\n      було: {ui[k][:64]!r}")
        if APPLY:
            del ui[k]
        dropped += 1
    else:
        print(f"  ? {k!r} — уже немає")

print("\n--- замінити на якір з бази ---")
for k, v in REFILL.items():
    old = ui.get(k, "")
    print(f"  ~ {k!r}\n      було: {old[:56]!r}\n      стало: {v!r}")
    if APPLY:
        ui[k] = v

print("\n--- клас — спеціалізація ---")
added = fixed = 0
for k, v in SPECS.items():
    old = ui.get(k)
    if old == v:
        continue
    if old:
        print(f"  ~ {k!r}: {old[:44]!r} -> {v!r}")
        fixed += 1
    else:
        print(f"  + {k!r} = {v!r}")
        added += 1
    if APPLY:
        ui[k] = v

print("\n--- родина «Candy Buckets» ---")
for k, v in CANDY.items():
    old = ui.get(k)
    if old == v:
        continue
    print(f"  ~ {k[:52]!r}\n      було: {str(old)[:46]!r}\n      стало: {v!r}")
    if APPLY:
        ui[k] = v

print("\n--- імена істот ---")
for k, v in NPC_FIX.items():
    old = npc.get(k)
    if old == v:
        continue
    print(f"  ~ id {k}: {str(old)[:50]!r} -> {v!r}")
    if APPLY:
        npc[k] = v

print("\n--- garrison ---")
if gar.get("Holy") == "Свято":
    print("  ~ 'Holy': 'Свято' -> 'Святість'")
    if APPLY:
        gar["Holy"] = "Святість"
else:
    print(f"  ? 'Holy' = {gar.get('Holy')!r} — не чіпаю")

print(f"\nзнято {dropped} | замінено {len(REFILL)} | "
      f"додано {added} | виправлено {fixed}")
if APPLY:
    io.open(P, "w", encoding="utf-8", newline="\n").write(
        json.dumps(tr, ensure_ascii=False, indent=1))
    print("translations.json записано")
else:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
