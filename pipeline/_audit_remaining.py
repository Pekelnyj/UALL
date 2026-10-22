# -*- coding: utf-8 -*-
"""Аудит залишку перекладу по всіх категоріях: джерело vs перекладено."""
import json
import sys
import re
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))


def L(f):
    p = B / "data/source" / f
    return json.loads(p.read_text(encoding="utf-8-sig")) if p.exists() else {}


def count_field(src, field, sub="en"):
    """скільки УНІКАЛЬНИХ en-текстів у полі field.

    Рахувати записи було помилкою, і помилка була велика. Секції на кшталт
    itemNames/itemFlavors ключуються АНГЛІЙСЬКИМ ТЕКСТОМ, тож однакові назви
    злипаються в один рядок бази. Коли джерело рахували за ID, а базу — за
    ключами, різниця бралася з повітря: у items.json 172 802 записи, але лише
    136 971 унікальна назва, і аудит показував «лишилось 35 820» там, де
    насправді не лишилось нічого. Те саме давало фальшиві 10 058 у флейворі.
    """
    seen = set()
    for v in src.values():
        if isinstance(v, dict):
            fv = v.get(field)
            if isinstance(fv, dict):
                t = (fv.get(sub) or "").strip()
                if t:
                    seen.add(t)
            elif field == "_self" and isinstance(v.get("name"), str):
                seen.add(v["name"].strip())
    return len(seen)


rows = []  # (категорія, джерело, перекладено, лишилось, нота)

# Предмети: назви / флейвор / ефекти
items = L("items.json")
it_names = count_field(items, "name")
it_flav = count_field(items, "flavor")
rows.append(("Предмети: назви", it_names, len(tr.get("itemNames", {})), None, "старі доповн., хронологічно"))
rows.append(("Предмети: флейвор", it_flav, len(tr.get("itemFlavors", {})), None, "опис-настрій"))
eff = L("item_effects.json")
rows.append(("Предмети: ефекти", len(eff), len(tr.get("descTemplates", {})), None, "use/equip-ефекти (descTemplates спільні)"))

# Закляття: назви + описи
spells = L("spells.json")
sp_names = count_field(spells, "name")
sp_desc = count_field(spells, "description")
rows.append(("Закляття: назви", sp_names, len(tr.get("spells", {})), None, ""))
# описи заклять - де лежать? спробуємо порахувати окремо
sp_desc_tr = len(tr.get("spellDescriptions", {})) or "?"
rows.append(("Закляття: описи", sp_desc, sp_desc_tr, None, "перевір розділ spellDescriptions"))

# Квести (реальні)
q = L("quests.json")
junk = re.compile(r"\[DNT\]|\[PH\]|\bTest\b|\bLFG\b", re.I)
realq = sum(1 for v in q.values() if isinstance(v, dict)
            and len((v.get("description") or {}).get("en") or "") > 15
            and not junk.search(((v.get("title") or {}).get("en") or "") + ((v.get("description") or {}).get("en") or "")))
rows.append(("Квести (реальні)", realq, len(tr.get("quests", {})), None, "решта=сміття DNT/тест"))

# Прості мапи id->name
simple = [
    ("Журнал-секції", "api_journal_sections.json", "journalSections"),
    ("Журнал-абілки", "api_journal.json", "journal"),
    ("Досягнення", "achievements.json", "achievements"),
    ("Улюбленці", "api_pets.json", "pets"),
    ("Маунти", "api_mounts.json", "mounts"),
    ("Валюти", "currencies.json", "currencies"),
    ("Титули", "api_titles.json", "titles"),
    ("Фракції", "api_factions.json", "factions"),
    ("Набори предметів", "api_item_sets.json", "itemSets"),
    ("Професії", "api_professions.json", "professions"),
    ("Рецепти", "api_recipes.json", "recipes"),
    ("NPC-імена(creatures)", "creatures.json", "npcNames"),
]
for label, srcf, sec in simple:
    src = L(srcf)
    rows.append((label, len(src), len(tr.get(sec, {})), None, ""))

print(f"{'Категорія':<26}{'Джерело':>10}{'Зробл.':>10}{'Лишилось':>10}   Нота")
print("-" * 80)
for label, total, done, _, note in rows:
    if isinstance(done, int):
        left = max(0, total - done)
        mark = " ✅" if left <= max(5, total * 0.01) else ""
        print(f"{label:<26}{total:>10,}{done:>10,}{left:>10,}{mark}   {note}")
    else:
        print(f"{label:<26}{total:>10,}{str(done):>10}{'?':>10}   {note}")
