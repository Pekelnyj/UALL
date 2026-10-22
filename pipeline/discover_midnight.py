"""Визначення questID доповнення Midnight без гри і без ключів.

Ланцюжок по клієнтських таблицях (wago.tools):
    QuestV2CliTask.ContentTuningID -> ContentTuning.ExpansionID

ExpansionID: 9 = Dragonflight, 10 = The War Within, 11 = Midnight.

Використання:
    python discover_midnight.py            # ExpansionID=11 -> data/midnight_ids.txt
    python discover_midnight.py --exp 10   # інше доповнення
Друкує розподіл квестів за доповненнями для самоперевірки.
"""

import argparse
import csv
import io
from collections import Counter

import requests

from common import DATA_DIR

CACHE_DIR = DATA_DIR / "wago"
IDS_PATH = DATA_DIR / "midnight_ids.txt"

MIDNIGHT_EXPANSION_ID = 11

EXP_NAMES = {
    8: "Shadowlands", 9: "Dragonflight", 10: "The War Within", 11: "Midnight",
}


def load_content_tuning(build: str | None) -> dict[int, int]:
    """ContentTuningID -> ExpansionID (таблиця без тексту, локаль неважлива)."""
    cache = CACHE_DIR / f"ContentTuning.{build or 'latest'}.csv"
    if cache.exists():
        text = cache.read_text(encoding="utf-8")
    else:
        params = {"build": build} if build else {}
        resp = requests.get("https://wago.tools/db2/ContentTuning/csv",
                            params=params, timeout=120)
        resp.raise_for_status()
        text = resp.text
        CACHE_DIR.mkdir(parents=True, exist_ok=True)
        cache.write_text(text, encoding="utf-8")
    reader = csv.DictReader(io.StringIO(text))
    return {int(r["ID"]): int(r["ExpansionID"]) for r in reader}


def main():
    ap = argparse.ArgumentParser(description="Пошук questID за доповненням")
    ap.add_argument("--exp", type=int, default=MIDNIGHT_EXPANSION_ID,
                    help="ExpansionID (типово 11 = Midnight)")
    ap.add_argument("--build", help="білд клієнта (типово останній)")
    args = ap.parse_args()

    tuning_exp = load_content_tuning(args.build)

    cli_task = CACHE_DIR / f"QuestV2CliTask.enUS.{args.build or 'latest'}.csv"
    if not cli_task.exists():
        raise SystemExit(f"Немає {cli_task} — спочатку запустіть extract_wago.py")
    reader = csv.DictReader(io.StringIO(cli_task.read_text(encoding="utf-8")))
    title_col = next(c for c in reader.fieldnames if "QuestTitle" in c)
    ct_col = next(c for c in reader.fieldnames if "ContentTuningID" in c)

    per_expansion = Counter()
    target_ids: list[int] = []
    for row in reader:
        if not (row.get(title_col) or "").strip():
            continue  # без назви — службові записи
        try:
            exp = tuning_exp.get(int(row.get(ct_col) or 0), -1)
        except ValueError:
            exp = -1
        per_expansion[exp] += 1
        if exp == args.exp:
            target_ids.append(int(row["ID"]))

    print("Розподіл квестів (із назвами) за доповненнями:")
    for exp, count in sorted(per_expansion.items()):
        name = EXP_NAMES.get(exp, f"exp {exp}" if exp >= 0 else "невідомо/0")
        print(f"  {exp:>3}  {name:<16} {count}")

    target_ids.sort()
    IDS_PATH.write_text("\n".join(map(str, target_ids)) + "\n", encoding="utf-8")
    exp_name = EXP_NAMES.get(args.exp, str(args.exp))
    print(f"\n{exp_name}: {len(target_ids)} квестів -> {IDS_PATH}")
    if target_ids:
        print(f"Діапазон ID: {target_ids[0]}..{target_ids[-1]}")


if __name__ == "__main__":
    main()
