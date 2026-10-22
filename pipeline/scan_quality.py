# -*- coding: utf-8 -*-
"""Скан якості перекладу: русизми-літери, модель «-град», русизми-слова.

Секція 1 — щойно перекладені батчі (--dir, типово exp_batches/out_*.json).
Секція 2 — уся translations.json по секціях.
"""
import sys, io, json, glob, argparse
from collections import Counter
import re

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

LETTERS = re.compile("[ыъэёЫЪЭЁ]")
# Штормград/Залізоград, але НЕ виноград/градус: капіталізований стем 2+ літери + межа.
GRAD = re.compile("[А-ЯІЇЄҐ][а-яіїєґʼ'’]{2,}град\\b")
GRAD_OK = {"виноград"}  # справжнє укр. слово — не русизм
# \bполуч — щоб НЕ ловити «Сполучення/Сполучник» (там «получ» усередині слова).
WORDS = re.compile(
    "(печать|вожак|\\bслідуюч|приймати участь|на протязі|співпада|сребр[а-яіїєґ]*|серебр[а-яіїєґ]*|\\bполуч[а-яіїєґ]*|"
    "больш[а-яіїєґ]*|вообще|обладат[а-яіїєґ]*|защит[а-яіїєґ]*|оружи[а-яіїєґ]*)",
    re.I,
)


def walk(o):
    if isinstance(o, str):
        yield o
    elif isinstance(o, dict):
        for v in o.values():
            yield from walk(v)
    elif isinstance(o, list):
        for v in o:
            yield from walk(v)


def scan(label, strings):
    strings = list(strings)
    let = []
    grad = Counter()
    wrd = Counter()
    for s in strings:
        if LETTERS.search(s):
            let.append(s[:70])
        for m in GRAD.findall(s):
            if m.lower() not in GRAD_OK:
                grad[m] += 1
        for m in WORDS.findall(s):
            wrd[m.lower()] += 1
    flag = "OK  " if not (let or grad or wrd) else "WARN"
    print(f"{flag} {label}: рядків {len(strings)}")
    print(f"      ы/ъ/э/ё: {len(let)}", (let[:3] if let else ""))
    print(f"      -град:   {sum(grad.values())}", (dict(grad.most_common(8)) if grad else ""))
    print(f"      русизми: {sum(wrd.values())}", (dict(wrd.most_common(10)) if wrd else ""))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dir", default="exp_batches", help="папка з out_*.json свіжої хвилі")
    args = ap.parse_args()

    # 1) щойно перекладені батчі
    new = []
    for f in sorted(glob.glob(f"data/{args.dir}/out_*.json")):
        new += list(walk(json.loads(open(f, "rb").read().decode("utf-8-sig"))))
    if new:
        scan(f"СВІЖА ХВИЛЯ ({args.dir})", new)
        print()

    # 2) вся база по секціях
    tr = json.loads(open("data/translations.json", "rb").read().decode("utf-8-sig"))
    for sect in ("itemNames", "itemFlavors", "quests", "questObjectives", "gossip",
                 "spells", "descTemplates", "achievements", "npcNames", "currencies",
                 "gameTips", "bookTexts"):
        d = tr.get(sect)
        if isinstance(d, dict):
            scan(f"translations.json :: {sect}", walk(d))


if __name__ == "__main__":
    main()
