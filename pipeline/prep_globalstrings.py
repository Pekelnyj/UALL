# -*- coding: utf-8 -*-
"""Батчі для перекладу GlobalStrings (інтерфейс гри).

Джерело: data/source/globalstrings.json = {NAME: en}. Дедуп за ЗНАЧЕННЯМ (один
переклад на унікальний англ. рядок -> застосується до всіх NAME із цим значенням).
Відсів: SLASH_* (тригери команд), KEY_* (назви клавіш), рядки лише з форматів/символів.
Пріоритет: короткі БЕЗ форматів спершу (кнопки/підписи — найвидиміше й найбезпечніше).

Вихід: data/batches/globalstrings/batch_NNN.json = [{"en": "англ"}].
Переклад -> out_NNN.json = [{"en","ua"}] -> merge_globalstrings.py.

Запуск: python prep_globalstrings.py [--size 15] [--limit N]
"""
import argparse, json, re
from common import DATA_DIR

FMT = re.compile(r"%[%\d.$+\-]*[sdfxiu]|%\d+\$")


def skip(name, val):
    if name.startswith("SLASH_") or name.startswith("KEY_"):
        return True
    if not re.search(r"[A-Za-z]", val):
        return True
    if len(val.strip()) < 3:           # 1-2 символи: скорочення чисел/часу (M, PM, w)
        return True
    return False


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--size", type=int, default=15)
    ap.add_argument("--limit", type=int, default=0, help="лише перші N унікальних (пробна хвиля)")
    args = ap.parse_args()

    gs = json.loads((DATA_DIR / "source" / "globalstrings.json").read_text(encoding="utf-8-sig"))
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    done = tr.get("globalStrings", {})  # {en: ua}

    uniq = {}
    for name, en in gs.items():
        if skip(name, en) or en in done:
            continue
        uniq.setdefault(en, True)
    values = list(uniq.keys())
    # пріоритет: спершу справжні ПІДПИСИ — фрази з пробілом, БЕЗ форматів, помірної
    # довжини (кнопки/меню найвидиміше). Абревіатури (1 слово) і формат-рядки — далі.
    def rank(v):
        return (
            0 if (" " in v and not FMT.search(v) and len(v) <= 40) else 1,
            1 if FMT.search(v) else 0,
            len(v),
        )
    values.sort(key=rank)
    if args.limit:
        values = values[:args.limit]

    out = DATA_DIR / "batches" / "globalstrings"
    out.mkdir(parents=True, exist_ok=True)
    for f in out.glob("batch_*.json"):
        f.unlink()
    n = 0
    for i in range(0, len(values), args.size):
        n += 1
        chunk = [{"en": v} for v in values[i:i + args.size]]
        (out / f"batch_{n:03d}.json").write_text(
            json.dumps(chunk, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"globalstrings: до перекладу {len(values)} унікальних | батчів по {args.size}: {n} -> {out}")


if __name__ == "__main__":
    main()
