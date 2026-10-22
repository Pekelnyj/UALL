# -*- coding: utf-8 -*-
"""Витяг усіх перекладних НАЗВ системи Житла (Housing) з wago DB2.
Джерела показуються в Каталозі декору, редакторі дому й на панелі житла; ключ
показу = англійська назва (ns.housing[Name]), підміняє хук HousingHooks.

Таблиці (Name_lang):
  HouseDecor            — назви декору (найбільше)
  DecorCategory         — категорії каталогу (ліві вкладки)
  DecorSubcategory      — підкатегорії
  HouseRoom             — кімнати
  HouseTheme            — теми дому
  HouseDecorThemeSet    — набори тем
  NeighborhoodInitiative— ініціативи (Endeavors), + Description_lang
  HouseLevelRewardInfo  — нагороди за рівень дому, + Description_lang

Запуск:  python pipeline/extract_housing.py
Результат: data/source/housing_names.json  (усі назви {name:{en,table,id}})
           data/_housing_todo.json          (лише неперекладені — черга на хвилю)
           звіт покриття проти translations["housing"].
"""
import csv, io, json, os, re, sys, urllib.request
sys.stdout.reconfigure(encoding="utf-8")
csv.field_size_limit(10_000_000)

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
CYR = re.compile(r"[а-яіїєґ]", re.I)
NOISE = re.compile(r"\[DNT\]|DO NOT USE|DONOTUSE|\bTest\b|\bWMO\b|placeholder|Partition|^Unused", re.I)

# таблиця: (колонка назви, чи є опис)
TABLES = {
    "HouseDecor": ("Name_lang", None),
    "DecorCategory": ("Name_lang", None),
    "DecorSubcategory": ("Name_lang", None),
    "HouseRoom": ("Name_lang", None),
    "HouseTheme": ("Name_lang", None),
    "HouseDecorThemeSet": ("Name_lang", None),
    "NeighborhoodInitiative": ("Name_lang", "Description_lang"),
    "HouseLevelRewardInfo": ("Name_lang", "Description_lang"),
}

def fetch(tbl):
    url = f"https://wago.tools/db2/{tbl}/csv?locale=enUS"
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(req, timeout=60) as r:
                return list(csv.DictReader(io.StringIO(r.read().decode("utf-8", "replace"))))
        except Exception as e:
            if attempt == 2:
                print(f"  !! {tbl}: {type(e).__name__} (пропускаю)")
                return []
    return []

def main():
    names, descs = {}, {}
    per_table = {}
    for tbl, (namecol, desccol) in TABLES.items():
        rows = fetch(tbl)
        cnt = 0
        for r in rows:
            n = (r.get(namecol) or "").strip()
            if n and not NOISE.search(n) and re.search(r"[A-Za-z]{2}", n):
                if n not in names:
                    names[n] = {"en": n, "table": tbl, "id": r.get("ID")}
                    cnt += 1
                if desccol:
                    d = (r.get(desccol) or "").strip()
                    if d and not NOISE.search(d):
                        descs[d] = {"en": d, "table": tbl, "id": r.get("ID")}
        per_table[tbl] = cnt
    # запис джерел
    os.makedirs(os.path.join(ROOT, "data", "source"), exist_ok=True)
    json.dump(names, open(os.path.join(ROOT, "data", "source", "housing_names.json"), "w",
              encoding="utf-8"), ensure_ascii=False, indent=1)
    # покриття
    t = json.load(open(os.path.join(ROOT, "data", "translations.json"), encoding="utf-8-sig"))
    h = t.get("housing", {})
    hui = t.get("housingUI", {})
    done_names = {k for k, v in h.items() if isinstance(v, str) and CYR.search(v)}
    miss_names = {n: d for n, d in names.items() if n not in done_names}
    miss_descs = {n: d for n, d in descs.items() if n not in hui and not (isinstance(hui.get(n), str))}
    queue = {"names": miss_names, "descriptions": miss_descs}
    json.dump(queue, open(os.path.join(ROOT, "data", "_housing_todo.json"), "w",
              encoding="utf-8"), ensure_ascii=False, indent=1)
    # звіт
    print(f"\n{'ТАБЛИЦЯ':26}{'нових назв':>12}")
    print("-" * 40)
    for tbl, c in per_table.items():
        print(f"{tbl:26}{c:>12}")
    print("-" * 40)
    print(f"{'УСЬОГО унікальних назв':26}{len(names):>12}")
    print(f"{'  з них перекладено':26}{len(names) - len(miss_names):>12}")
    print(f"{'  НЕ перекладено (черга)':26}{len(miss_names):>12}")
    print(f"{'описів (Initiative/Reward)':26}{len(descs):>12}  (не перекл. {len(miss_descs)})")
    print(f"\nчерга -> data/_housing_todo.json")

if __name__ == "__main__":
    main()
