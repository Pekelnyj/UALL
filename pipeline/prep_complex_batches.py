"""Батчі СКЛАДНИХ описів спелів (з умовами $?spec[A][B]) для заданих класів.

Складний опис залежить від спеки/умов: $?a137028[Divine Toll][Wake of Ashes].
Перекладаються ОБИДВІ гілки, структура умов лишається недоторканною.

Використання:
    python prep_complex_batches.py Paladin
    python prep_complex_batches.py Druid --batch-size 24
"""

import argparse
import json
import io

from common import DATA_DIR

BATCH_DIR = DATA_DIR / "complex_batches"


def main():
    ap = argparse.ArgumentParser(description="Батчі складних описів по класах")
    ap.add_argument("classes", nargs="+", help="класи (skillLine), напр. Paladin Druid")
    ap.add_argument("--batch-size", type=int, default=24)
    args = ap.parse_args()
    wanted_classes = set(args.classes)

    src = json.load(io.open(DATA_DIR / "source" / "spells.json", encoding="utf-8-sig"))
    trans = json.load(io.open(DATA_DIR / "translations.json", encoding="utf-8-sig"))
    spells_tr = trans.get("spells", {})
    done = trans.get("descTemplates", {})

    pending = {}
    for sid, e in src.items():
        if e.get("skillLine") not in wanted_classes or sid not in spells_tr:
            continue
        desc = e.get("description") or {}
        en = desc.get("en")
        if not en or e.get("descComplexity") != "complex" or en in done:
            continue
        p = pending.setdefault(en, {"de": None, "fr": None, "spells": []})
        p["de"] = p["de"] or desc.get("de")
        p["fr"] = p["fr"] or desc.get("fr")
        name_en = e.get("name", {}).get("en")
        if name_en and len(p["spells"]) < 3:
            p["spells"].append({"en": name_en, "ua": spells_tr[sid],
                                "class": e.get("skillLine", "")})

    items = sorted(pending.items())
    BATCH_DIR.mkdir(parents=True, exist_ok=True)
    for old in BATCH_DIR.glob("*.json"):
        old.unlink()

    batches = 0
    for i in range(0, len(items), args.batch_size):
        chunk = dict(items[i:i + args.batch_size])
        batches += 1
        (BATCH_DIR / f"batch_{batches:02d}.json").write_text(
            json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")

    words = sum(len(en.split()) for en in pending)
    print(f"{'+'.join(sorted(wanted_classes))}: складних шаблонів {len(items)} "
          f"(~{words} слів) у {batches} батчах")
    print(f"-> {BATCH_DIR}")


if __name__ == "__main__":
    main()
