"""Підготовка батчів валют на переклад (з en/de/fr для звірки).

Вхід:  data/source/currencies.json
Вихід: data/batches/currencies/cur_NN.json
       [{id, en, de, fr, desc_en, desc_de, desc_fr}]
Пропускає вже перекладені (translations.json["currencies"][id]).
"""

import json
import re
from collections import Counter

from common import DATA_DIR

SRC = DATA_DIR / "source" / "currencies.json"
OUT = DATA_DIR / "batches" / "currencies"
BATCH = 40

# Реальна валюта гравця = має ОПИС і не позначена [DNT]/(Hidden).
# Решта (954) — службові лічильники Mythic+/housing/тести, не перекладаємо.
DNT = re.compile(r"\[DNT\]|\(Hidden\)|\bDNT\b", re.I)


def is_real(e) -> bool:
    en = (e.get("name", {}) or {}).get("en", "").strip()
    if not en or DNT.search(en):
        return False
    return bool((e.get("description", {}) or {}).get("en", "").strip())


def main():
    src = json.loads(SRC.read_text(encoding="utf-8-sig"))
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    done = set(tr.get("currencies", {}))

    items = []
    for cid, e in src.items():
        if cid in done or not is_real(e):
            continue
        name = e.get("name", {})
        en = (name.get("en") or "").strip()
        if not en:
            continue
        items.append({
            "id": int(cid),
            "en": en,
            "de": name.get("de", ""),
            "fr": name.get("fr", ""),
            "desc_en": (e.get("description", {}) or {}).get("en", ""),
            "desc_de": (e.get("description", {}) or {}).get("de", ""),
            "desc_fr": (e.get("description", {}) or {}).get("fr", ""),
        })
    items.sort(key=lambda x: x["id"])

    OUT.mkdir(parents=True, exist_ok=True)
    for old in OUT.glob("cur_*.json"):
        old.unlink()
    n = 0
    for i in range(0, len(items), BATCH):
        n += 1
        (OUT / f"cur_{n:02d}.json").write_text(
            json.dumps(items[i:i + BATCH], ensure_ascii=False, indent=1),
            encoding="utf-8")

    # частотність останніх слів — підказка для глосарія повторюваних термінів
    last = Counter(x["en"].split()[-1] for x in items if x["en"].split())
    print(f"Валют на переклад: {len(items)} | батчів: {n} (по {BATCH})")
    print("Найчастіші останні слова (терміни для глосарія):")
    for w, c in last.most_common(25):
        print(f"  {w:16} {c}")


if __name__ == "__main__":
    main()
