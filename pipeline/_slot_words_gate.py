# -*- coding: utf-8 -*-
"""ГЕЙТ СЛОТОВИХ СЛІВ: слот спорядження мусить зватись ОДНАКОВО на всіх поверхнях
(тултіп предмета ItemHooks, журнал EncounterJournalHooks, глобалки INVTYPE_*/…SLOT) —
і збігатися з канон-таблицею глосарія («слот спорядження»). Історія: Trinket був
«Дрібничка» (глосарій/EJ) і «Брязкальце» (ItemHooks); Feet — «Стопи»/«Ступні»;
Back-глобалки отруєні «Назад». Пасивний рядок у глосарії не впіймав — тому гейт.

Винятки: EJ ["Back"]="Назад" — то КНОПКА Journeys, не слот (слот у EJ приходить
уже українським з INVTYPE-глобалок).
Запуск перед мерджем/релізом: python pipeline/_slot_words_gate.py
"""
from pathlib import Path
import sys, re, os
sys.stdout.reconfigure(encoding="utf-8")
ROOT = str(Path(__file__).resolve().parent.parent)

# (файл, ключ) які СВІДОМО відрізняються від слот-канону
EXCEPTIONS = {
    ("EncounterJournalHooks.lua", "Back"),      # кнопка Journeys, не слот
    # value-рівневі записи: голе "Chest"/"Legs" поза слотом буває скринею/предметом;
    # однозначні слот-глобалки (INVTYPE_*/…SLOT) покриті GS_NAME_OVERRIDES у generate_db
    ("UIStringsDisplay.lua", "Chest"),
    ("UIStringsDisplay.lua", "Legs"),
    ("UIStringsDisplay.lua", "Back"),           # кнопка «Назад» у walk-UI, не слот
    # 18.10.2026: та сама причина, але інший файл. generate_db зливає секцію
    # gameObjects в uiTooltips, а там ["Chest"]="Скриня" — це СВІТОВА СКРИНЯ,
    # яку гравець обшукує, не слот. Слот на цій поверхні закритий глобалками:
    # INVTYPE_CHEST і CHESTSLOT обидві «Груди». Спроба «виправити» це в базі
    # зробила б із світової скрині «Груди».
    ("UITooltips.lua", "Chest"),
}

# канон із глосарія: рядки «| X | слот спорядження | UA |»
canon = {}
for ln in open(ROOT + "/pipeline/glossary.md", encoding="utf-8"):
    # «слот спорядження» може мати примітку в дужках («слот спорядження (плащ)») —
    # без [^|]* рядок Back випадав з канону і гейт був сліпий до Back=Назад
    m = re.match(r"\|\s*([^|]+?)\s*\|\s*слот спорядження[^|]*\|\s*([^|(]+)", ln)
    if m:
        canon[m.group(1).strip()] = m.group(2).strip()

if not canon:
    print("❌ ГЕЙТ СЛОТІВ: не знайшов таблиці «слот спорядження» у глосарії")
    sys.exit(1)

bad = []
# 1) словники хуків + згенеровані UI-бази з голими слот-словами.
#    ChrCustomization СВІДОМО НЕ скануємо: там Waist="Талія" = повзунок статури
#    в барбершопі (тіло, не слот спорядження) — інший контекст, і він правильний.
SCAN = ["ItemHooks.lua", "EncounterJournalHooks.lua",
        "Database/UITooltips.lua", "Database/UIStringsDisplay.lua"]
for fname in SCAN:
    txt = open(ROOT + "/addon/UALL/" + fname, encoding="utf-8").read()
    for en, ua_canon in canon.items():
        for m in re.finditer(r'\["' + re.escape(en) + r'"\]\s*=\s*"([^"]+)"', txt):
            ua = m.group(1)
            if ua != ua_canon and (os.path.basename(fname), en) not in EXCEPTIONS:
                bad.append((fname, en, ua, ua_canon))

# 2) глобалки-омоніми (мінімальний спот-чек найнебезпечніших)
gs = open(ROOT + "/addon/UALL/Database/GlobalStrings.lua", encoding="utf-8").read()
for name, want in [("INVTYPE_CLOAK", "Спина"), ("BACKSLOT", "Спина"),
                   ("INVTYPE_TRINKET", canon.get("Trinket", "Дрібничка"))]:
    m = re.search(r'\["' + name + r'"\]\s*=\s*"([^"]+)"', gs)
    if m and m.group(1) != want:
        bad.append(("GlobalStrings.lua", name, m.group(1), want))

if bad:
    print(f"❌ ГЕЙТ СЛОТІВ: {len(bad)} розбіжностей зі слот-каноном глосарія")
    for f, en, ua, want in bad:
        print(f"   {f}: {en!r} = «{ua}» → канон «{want}»")
    sys.exit(1)
print(f"✅ ГЕЙТ СЛОТІВ: чисто ({len(canon)} слот-слів звірено по поверхнях; Trinket=Дрібничка).")
