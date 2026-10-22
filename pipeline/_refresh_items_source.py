# -*- coding: utf-8 -*-
"""Долити в data/source/items.json предмети СВІЖОГО білда (en/de/fr + флейвор).

НАВІЩО. generate_db.generate_items ходить по items.json за ID і бере UA з
itemNames за англійською назвою. Якщо предмета немає в items.json, його
переклад лежить у базі, але в гру НЕ ПОТРАПЛЯЄ взагалі — саме так сталося з
хвилею 12.1.5: 1 194 назви злилися в translations.json, а в Items_*.lua не
з'явилося жодної (14.10). Тобто оновлювати треба не лише переклад, а й джерело.

Заодно оновлюємо ItemSparse.enUS.latest.csv — із нього generate_db бере
ExpansionID, тобто розкладку предметів по файлах доповнень.

Запуск: python _refresh_items_source.py --src <тека з CSV> --build 12.1.5.70391
        [--apply]
"""
import csv
import json
import shutil
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(20_000_000)
from common import DATA_DIR

APPLY = "--apply" in sys.argv


def opt(flag, default=""):
    return sys.argv[sys.argv.index(flag) + 1] if flag in sys.argv else default


SRC = Path(opt("--src"))
BUILD = opt("--build", "unknown")
WAGO = DATA_DIR / "wago"
P = DATA_DIR / "source" / "items.json"


def load(path):
    out = {}
    with open(path, encoding="utf-8", newline="") as f:
        rd = csv.DictReader(f)
        c = next(x for x in rd.fieldnames if x.startswith("Display_lang"))
        d = next((x for x in rd.fieldnames if x.startswith("Description_lang")), None)
        for r in rd:
            n = (r.get(c) or "").strip()
            if n:
                out[r["ID"]] = (n, (r.get(d) or "").strip() if d else "")
    return out


# Ім'я файлу з англійськими назвами — параметр: гарячі білди виходять
# частіше, ніж ми тягнемо de/fr (ті по 50 МБ, і заради 16 нових предметів
# їх качати марно). Без de/fr нові записи лягають лише з англійською.
EN_CSV = opt("--en", "it70391.csv")
en = load(SRC / EN_CSV)
de = load(SRC / "it_de.csv") if (SRC / "it_de.csv").exists() else {}
fr = load(SRC / "it_fr.csv") if (SRC / "it_fr.csv").exists() else {}
src = json.loads(P.read_text(encoding="utf-8-sig"))
print(f"items.json: {len(src)} | у білді {BUILD}: {len(en)}")

added = updated = 0
for iid, (name_en, fl_en) in en.items():
    e = src.get(iid)
    if e is None:
        e = {"name": {"en": name_en}}
        if fl_en:
            e["flavor"] = {"en": fl_en}
        src[iid] = e
        added += 1
    else:
        # назву НЕ перезаписуємо: ключ перекладу — англійський текст, і зміна
        # назви під тим самим ID мовчки відв'язала б наявний переклад
        if fl_en and not (e.get("flavor") or {}).get("en"):
            e.setdefault("flavor", {})["en"] = fl_en
            updated += 1
            continue
        else:
            continue
    for loc, data in (("de", de), ("fr", fr)):
        v = data.get(iid)
        if not v:
            continue
        if v[0]:
            e["name"][loc] = v[0]
        if v[1] and e.get("flavor"):
            e["flavor"][loc] = v[1]

print(f"додано нових ID: {added} | дописано флейвор до наявних: {updated} | "
      f"стане: {len(src)}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)

P.write_text(json.dumps(src, ensure_ascii=False, indent=1), encoding="utf-8")
dst = WAGO / f"ItemSparse.enUS.{BUILD}.csv"
shutil.copyfile(SRC / EN_CSV, dst)
shutil.copyfile(SRC / EN_CSV, WAGO / "ItemSparse.enUS.latest.csv")
if (SRC / "it_de.csv").exists():
    shutil.copyfile(SRC / "it_de.csv", WAGO / "ItemSparse.deDE.latest.csv")
if (SRC / "it_fr.csv").exists():
    shutil.copyfile(SRC / "it_fr.csv", WAGO / "ItemSparse.frFR.latest.csv")
print(f"items.json записано; ItemSparse оновлено до {BUILD}")
