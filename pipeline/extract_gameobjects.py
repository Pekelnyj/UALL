"""Витяг назв об'єктів світу (GameObjects) з wago DB2 — вузли руд/трав, скрині, двері тощо.

GameObjects.db2 (Name_lang) — те, що гравець бачить у тултіпі, наводячись на об'єкт у світі.
EN — джерело перекладу, DE/FR — контекст. Багато назв формульні й повторювані («…Vein»,
«…Deposit», «…Chest»), тож унікальних рядків на переклад значно менше за к-сть ID.

    python extract_gameobjects.py            # -> data/source/gameobjects.json
    python extract_gameobjects.py --build 12.0.7.68256
"""
import csv
import io
import json
import sys
from collections import Counter

from common import DATA_DIR
from extract_wago import download_csv, find_column

OUT = DATA_DIR / "source" / "gameobjects.json"
LOCALES = {"enUS": "en", "deDE": "de", "frFR": "fr"}


def parse_names(text):
    reader = csv.DictReader(io.StringIO(text))
    name_col = find_column(reader.fieldnames, "Name_lang", "Name")
    out = {}
    for row in reader:
        nm = (row.get(name_col) or "").strip()
        if nm:
            out[int(row["ID"])] = nm
    return out


def main():
    build = None
    if "--build" in sys.argv:
        i = sys.argv.index("--build")
        build = sys.argv[i + 1] if i + 1 < len(sys.argv) else None

    names = {}
    for loc, short in LOCALES.items():
        print(f"Локаль {loc}:")
        names[short] = parse_names(download_csv("GameObjects", loc, build))

    source = json.loads(OUT.read_text(encoding="utf-8-sig")) if OUT.exists() else {}
    for gid in sorted(names["en"]):
        entry = source.setdefault(str(gid), {})
        for short in LOCALES.values():
            nm = names[short].get(gid)
            if nm:
                entry.setdefault("name", {})[short] = nm

    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(source, ensure_ascii=False, indent=2), encoding="utf-8")

    uniq = Counter(names["en"].values())
    print(f"\nОб'єктів (ID): {len(names['en'])}")
    print(f"УНІКАЛЬНИХ назв (реальний обсяг перекладу): {len(uniq)}")
    print("Топ-15 найчастіших (формульні — перекладуться шаблонно):")
    for nm, c in uniq.most_common(15):
        print(f"  {c:>4}×  {nm}")
    print(f"-> {OUT}")


if __name__ == "__main__":
    main()
