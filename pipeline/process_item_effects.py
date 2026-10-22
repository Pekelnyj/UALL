"""Готує переклад ЕФЕКТІВ предметів (рядки Equip:/Use: у тултіпі).

Ефект предмета = опис ЗАКЛЯТТЯ, прив'язаного через ItemEffect. Ланцюг:
    ItemSparse(InventoryType) -> ItemXItemEffect(ItemID->ItemEffectID)
    -> ItemEffect(ItemEffectID->SpellID) -> Spell.db2(Description_lang)

Цей скрипт (поки для ТРИНЬОК, InventoryType=12):
  1. будує мапу itemID -> [spellID ефектів];
  2. додає ці spellID у source/spells.json (назва з SpellName, skillLine=ItemEffect),
     щоб extract_spell_descriptions.py витяг описи, а спел-конвеєр переклав;
  3. пише data/source/item_effects.json = {itemID: [spellID,...]} для генерації
     Database/ItemEffects.lua (аддон за itemID дізнається спели ефектів).

Використання:
    python process_item_effects.py            # триньки (InventoryType=12)
    python process_item_effects.py --inv 13   # інший слот (зброя=13 тощо)
    python extract_spell_descriptions.py      # потім: додасть описи
"""

import argparse
import csv
import glob
import json

from common import DATA_DIR

W = DATA_DIR / "wago"
SOURCE = DATA_DIR / "source" / "spells.json"
ITEM_EFFECTS = DATA_DIR / "source" / "item_effects.json"
LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}


def load_csv(table):
    p = glob.glob(str(W / f"{table}.enUS*.csv"))
    if not p:
        raise SystemExit(f"Немає кешу {table} — спершу завантаж.")
    with open(p[0], encoding="utf-8") as f:
        return list(csv.DictReader(f))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--inv", type=int, default=12, help="InventoryType (12=trinket)")
    args = ap.parse_args()
    csv.field_size_limit(10 ** 7)

    eff2spell = {r["ID"]: r["SpellID"] for r in load_csv("ItemEffect")
                 if r.get("SpellID") and r["SpellID"] != "0"}
    item2spells = {}
    for r in load_csv("ItemXItemEffect"):
        s = eff2spell.get(r["ItemEffectID"])
        if s:
            item2spells.setdefault(r["ItemID"], set()).add(s)

    # itemID потрібного слота
    want_items = set()
    with open(glob.glob(str(W / "ItemSparse.enUS*.csv"))[0], encoding="utf-8") as f:
        r = csv.DictReader(f)
        ic = next(c for c in r.fieldnames if c.lower() == "inventorytype")
        for row in r:
            if (row.get(ic) or "") == str(args.inv):
                want_items.add(row["ID"])

    # мапа лише для предметів слота, що мають ефект-спели
    mapping = {}
    spell_ids = set()
    for iid in want_items:
        sp = item2spells.get(iid)
        if sp:
            mapping[int(iid)] = sorted(int(s) for s in sp)
            spell_ids |= sp

    # назви ефект-спелів (en/de/fr) для source
    names = {short: {} for short in LOCALES.values()}
    for loc, short in LOCALES.items():
        paths = glob.glob(str(W / f"SpellName.{loc}*.csv"))
        if not paths:
            continue
        with open(paths[0], encoding="utf-8") as f:
            for row in csv.DictReader(f):
                if row["ID"] in spell_ids:
                    nm = (row.get("Name_lang") or "").strip()
                    if nm:
                        names[short][row["ID"]] = nm

    source = json.loads(SOURCE.read_text(encoding="utf-8-sig"))
    added = 0
    for sid in spell_ids:
        en = names["en"].get(sid)
        if not en:
            continue
        e = source.setdefault(sid, {})
        nm = e.setdefault("name", {})
        nm.setdefault("en", en)
        for short in ("de", "fr"):
            if names[short].get(sid):
                nm.setdefault(short, names[short][sid])
        e.setdefault("talent", True)
        e.setdefault("skillLine", "ItemEffect")
        added += 1
    SOURCE.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")

    # мапа itemID -> spellIDs (для ItemEffects.lua)
    existing = {}
    if ITEM_EFFECTS.exists():
        existing = json.loads(ITEM_EFFECTS.read_text(encoding="utf-8-sig"))
    existing.update({str(k): v for k, v in mapping.items()})
    ITEM_EFFECTS.write_text(json.dumps(existing, ensure_ascii=False), encoding="utf-8")

    print(f"Слот {args.inv}: предметів з ефектами {len(mapping)} | унік. спелів {len(spell_ids)} | додано в source {added}")
    print(f"-> {ITEM_EFFECTS} (усього мап: {len(existing)})")
    print("Тепер: python extract_spell_descriptions.py")


if __name__ == "__main__":
    main()
