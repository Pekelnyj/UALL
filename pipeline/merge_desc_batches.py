"""Злиття перекладених описів спелів + СУВОРА валідація формул.

Переклад приймається лише якщо:
  - мультимножина $-токенів збігається з оригіналом;
  - послідовність умов $?a123 і кількість дужок [ ] збігаються
    (для складних описів з гілками).
Відхилене лишається на наступну хвилю.

Використання:
    python merge_desc_batches.py                      # звичайні (desc_batches)
    python merge_desc_batches.py --dir complex_batches  # складні
"""

import argparse
import json
import io
import re
from collections import Counter

from common import DATA_DIR

TOKEN_RE = re.compile(r"\$\{[^{}]*\}|\$<\w+>|\$proc[a-z]+|\$@[a-zA-Z]+\d*|\$(\d+)?[sdatxmMunhoArRwWeEbc]\d*")
COND_RE = re.compile(r"\$\?!?[a-zA-Z]*\d+")


def tokens(text: str) -> Counter:
    return Counter(m.group(0) for m in TOKEN_RE.finditer(text))


def structure(text: str):
    """Підпис структури умов: умови по порядку + кількість дужок."""
    return (COND_RE.findall(text), text.count("["), text.count("]"))


def main():
    ap = argparse.ArgumentParser(description="Злиття перекладів описів")
    ap.add_argument("--dir", default="desc_batches", help="папка з батчами")
    args = ap.parse_args()
    batch_dir = DATA_DIR / args.dir

    trans_path = DATA_DIR / "translations.json"
    trans = json.load(io.open(trans_path, encoding="utf-8-sig"))
    done = trans.setdefault("descTemplates", {})

    accepted = rejected = 0
    rejects = []
    for out in sorted(batch_dir.glob("out_*.json")):
        data = json.loads(out.read_text(encoding="utf-8-sig"))
        for en, ua in data.items():
            if not isinstance(ua, str) or not ua.strip():
                rejected += 1
                rejects.append((out.name, en[:60], "порожній"))
                continue
            if tokens(en) != tokens(ua):
                rejected += 1
                rejects.append((out.name, en[:60], "токени не збігаються"))
                continue
            if structure(en) != structure(ua):
                rejected += 1
                rejects.append((out.name, en[:60], "структура умов не збігається"))
                continue
            done[en] = ua.strip()
            accepted += 1

    trans_path.write_text(json.dumps(trans, ensure_ascii=False, indent=1),
                          encoding="utf-8")
    print(f"Прийнято: {accepted} | відхилено: {rejected} | усього шаблонів: {len(done)}")
    for name, en, why in rejects[:20]:
        print(f"  ВІДХИЛЕНО [{name}] {why}: {en}...")
    if len(rejects) > 20:
        print(f"  ... і ще {len(rejects) - 20}")


if __name__ == "__main__":
    main()
