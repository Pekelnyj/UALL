"""Готує батчі імен NPC до перекладу: неперекладені creatures -> batch_NNN.json.

Бере data/source/creatures.json, відкидає вже перекладені (data/translations.json
ключ 'npcNames'), пакує решту по N у data/batches/creatures/batch_NNN.json
у форматі [{"id","en","de","fr"}, ...].
"""
import argparse
import json
import math
from pathlib import Path

from common import DATA_DIR

SRC = DATA_DIR / "source" / "creatures.json"
TR = DATA_DIR / "translations.json"
OUT = DATA_DIR / "batches" / "creatures"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--size", type=int, default=80)
    args = ap.parse_args()

    src = json.loads(SRC.read_text(encoding="utf-8"))
    tr = json.loads(TR.read_text(encoding="utf-8")) if TR.exists() else {}
    done = set((tr.get("npcNames") or {}).keys())

    # НЕАНГЛІЙСЬКИЙ КЛІЄНТ. Збирач плашок записує ім'я таким, яким його показує
    # гра, тож тестер із німецьким клієнтом заносить у датамайн «англійське»
    # ім'я німецькою («Schattenjäger Ty'jin», «Kräcka Einauge» — 33 такі 13.09).
    # Переклад за таким EN дав би в NpcNames.lua ключ, що в англійського
    # гравця не зматчиться ніколи.
    import capfilter
    todo, foreign = [], []
    for cid, v in src.items():
        if cid in done:
            continue
        n = v.get("name", {})
        if not (n.get("en") or "").strip():
            continue
        if capfilter.is_foreign(n["en"]):
            foreign.append(n["en"])
            continue
        todo.append({"id": cid, "en": n["en"], "de": n.get("de", ""), "fr": n.get("fr", "")})
    if foreign:
        print(f"відсіяно імен неанглійського клієнта: {len(foreign)} -> {foreign[:5]}")

    todo.sort(key=lambda x: int(x["id"]))
    OUT.mkdir(parents=True, exist_ok=True)
    for f in OUT.glob("batch_*.json"):
        f.unlink()

    n = args.size
    nb = math.ceil(len(todo) / n)
    for i in range(nb):
        chunk = todo[i * n:(i + 1) * n]
        (OUT / f"batch_{i+1:03d}.json").write_text(
            json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"До перекладу імен: {len(todo)} | батчів по {n}: {nb}")


if __name__ == "__main__":
    main()
