"""Витяг ТАЛАНТІВ класів із wago.tools — без ключів і без гри.

Таланти в retail йдуть не через SkillLineAbility, а через Trait-систему
(дерева талантів, включно з геройськими). Тултіп таланта — це звичайний
spell-тултіп, тож SpellHooks.lua підхопить переклад автоматично, щойно
spellID таланта з'явиться в базі.

Ланцюжок таблиць:
    SkillLine (CategoryID=7)  -> класові лінії
    SkillLineXTraitTree       -> дерево талантів кожного класу
    TraitNode                 -> вузли дерева (включно з геройськими)
    TraitNodeXTraitNodeEntry  -> вузол -> варіанти вибору
    TraitNodeEntry            -> TraitDefinitionID
    TraitDefinition           -> SpellID + OverrideName_lang (per locale)
    SpellName                 -> назви заклять per locale (en/de/fr)

Результат: злиття у data/source/spells.json (той самий формат, що в
extract_spells.py) з позначкою "talent": true.

Використання:
    python extract_talents.py
"""

import csv
import io
import json

import requests

from common import DATA_DIR

SOURCE_PATH = DATA_DIR / "source" / "spells.json"
CACHE_DIR = DATA_DIR / "wago"

LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}
CLASS_CATEGORY_ID = 7


def download_csv(table: str, locale: str, build=None) -> str:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cache_path = CACHE_DIR / f"{table}.{locale}.{build or 'latest'}.csv"
    if cache_path.exists():
        print(f"  {cache_path.name}: з кешу")
        return cache_path.read_text(encoding="utf-8")
    print(f"  {cache_path.name}: завантажую...")
    params = {"locale": locale}
    if build:
        params["build"] = build
    resp = requests.get(f"https://wago.tools/db2/{table}/csv", params=params, timeout=600)
    resp.raise_for_status()
    cache_path.write_text(resp.text, encoding="utf-8")
    return resp.text


def find_column(fieldnames, *needles):
    for needle in needles:
        for name in fieldnames:
            if needle.lower() == name.lower():
                return name
    for needle in needles:
        for name in fieldnames:
            if needle.lower() in name.lower():
                return name
    raise KeyError(f"Немає колонки {needles}: {fieldnames[:25]}")


def rows(table: str, locale: str = "enUS", build=None):
    return csv.DictReader(io.StringIO(download_csv(table, locale, build)))


def main():
    # 1. Класові лінії та їхні дерева талантів.
    r = rows("SkillLine")
    cat_col = find_column(r.fieldnames, "CategoryID")
    name_col = find_column(r.fieldnames, "DisplayName_lang", "DisplayName")
    class_lines = {int(x["ID"]): (x.get(name_col) or "").strip()
                   for x in r if x.get(cat_col) and int(x[cat_col]) == CLASS_CATEGORY_ID}
    print(f"Класів: {len(class_lines)}")

    r = rows("SkillLineXTraitTree")
    line_col = find_column(r.fieldnames, "SkillLineID")
    tree_col = find_column(r.fieldnames, "TraitTreeID")
    tree_to_class = {}
    for x in r:
        try:
            line = int(x[line_col])
            if line in class_lines:
                tree_to_class[int(x[tree_col])] = class_lines[line]
        except (KeyError, ValueError):
            continue
    print(f"Дерев талантів: {len(tree_to_class)}")

    # 2. Вузли дерев -> варіанти -> TraitDefinitionID.
    r = rows("TraitNode")
    tree_col = find_column(r.fieldnames, "TraitTreeID")
    node_to_class = {}
    for x in r:
        try:
            tree = int(x.get(tree_col) or 0)
            if tree in tree_to_class:
                node_to_class[int(x["ID"])] = tree_to_class[tree]
        except (KeyError, ValueError):
            continue
    print(f"Вузлів талантів: {len(node_to_class)}")

    r = rows("TraitNodeXTraitNodeEntry")
    node_col = find_column(r.fieldnames, "TraitNodeID")
    entry_col = find_column(r.fieldnames, "TraitNodeEntryID")
    entry_to_class = {}
    for x in r:
        try:
            node = int(x[node_col])
            if node in node_to_class:
                entry_to_class[int(x[entry_col])] = node_to_class[node]
        except (KeyError, ValueError):
            continue

    r = rows("TraitNodeEntry")
    def_col = find_column(r.fieldnames, "TraitDefinitionID")
    def_to_class = {}
    for x in r:
        try:
            eid = int(x["ID"])
            if eid in entry_to_class:
                d = int(x.get(def_col) or 0)
                if d:
                    def_to_class[d] = entry_to_class[eid]
        except (KeyError, ValueError):
            continue
    print(f"Визначень (TraitDefinition): {len(def_to_class)}")

    # 3. TraitDefinition per locale: SpellID + OverrideName_lang.
    #    Якщо в таланта є override-назва — у тултіпі показується саме вона.
    spell_to_class = {}
    override = {short: {} for short in LOCALES.values()}  # spellID -> назва
    for loc, short in LOCALES.items():
        r = rows("TraitDefinition", loc)
        spell_col = find_column(r.fieldnames, "SpellID")
        over_col = find_column(r.fieldnames, "OverrideName_lang", "OverrideName")
        for x in r:
            try:
                did = int(x["ID"])
            except (KeyError, ValueError):
                continue
            if did not in def_to_class:
                continue
            try:
                sid = int(x.get(spell_col) or 0)
            except ValueError:
                continue
            if sid <= 0:
                continue
            spell_to_class[sid] = def_to_class[did]
            name = (x.get(over_col) or "").strip()
            if name:
                override[short][sid] = name
    print(f"Спелів талантів: {len(spell_to_class)}")

    # 4. Назви заклять (де немає override).
    wanted = set(spell_to_class)
    names = {}
    for loc, short in LOCALES.items():
        r = rows("SpellName", loc)
        name_col = find_column(r.fieldnames, "Name_lang", "Name")
        names[short] = {}
        for x in r:
            try:
                sid = int(x["ID"])
            except (KeyError, ValueError):
                continue
            if sid in wanted:
                val = (x.get(name_col) or "").strip()
                if val:
                    names[short][sid] = val

    # 5. Злиття у спільне джерело спелів.
    source = {}
    if SOURCE_PATH.exists():
        source = json.loads(SOURCE_PATH.read_text(encoding="utf-8-sig"))

    added = new = 0
    for sid in sorted(wanted):
        en = override["en"].get(sid) or names["en"].get(sid)
        if not en:
            continue
        key = str(sid)
        if key not in source:
            new += 1
        entry = source.setdefault(key, {})
        entry.setdefault("name", {})
        for short in LOCALES.values():
            val = override[short].get(sid) or names[short].get(sid)
            if val:
                entry["name"].setdefault(short, val)
        entry.setdefault("skillLine", spell_to_class[sid])
        entry["talent"] = True
        added += 1

    SOURCE_PATH.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Талантів із назвами: {added} (нових у джерелі: {new}). "
          f"Усього спелів у джерелі: {len(source)}")
    print(f"-> {SOURCE_PATH}")


if __name__ == "__main__":
    main()
