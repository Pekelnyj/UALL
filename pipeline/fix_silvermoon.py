# -*- coding: utf-8 -*-
"""Підчистка: описовий Silvermoon (Срібний Місяць/Срібномістя) -> Сільвермун.

БЕЗПЕЧНО: чіпає лише записи, де АНГЛІЙСЬКЕ джерело містить 'Silvermoon'
(тож буквальний 'silver moon' у лорі не зачіпається). Відмінки збережено.
"""
import json, re, sys
from common import DATA_DIR
sys.stdout.reconfigure(encoding="utf-8")

# довші/специфічні форми — раніше; і великі, і малі літери -> завжди велика (власна назва)
REPL = [
    ("Срібного Місяця", "Сільвермуна"), ("срібного місяця", "Сільвермуна"),
    ("Срібному Місяці", "Сільвермуні"), ("срібному місяці", "Сільвермуні"),
    ("Срібному Місяцю", "Сільвермуну"), ("срібному місяцю", "Сільвермуну"),
    ("Срібним Місяцем", "Сільвермуном"), ("срібним місяцем", "Сільвермуном"),
    ("Срібний Місяцю", "Сільвермуне"),
    ("Срібний Місяць", "Сільвермун"), ("срібний місяць", "Сільвермун"),
    ("Срібномістям", "Сільвермуном"), ("Срібномістю", "Сільвермуном"),
    ("Срібномістя", "Сільвермун"), ("Срібномісті", "Сільвермуні"),
]


def fix(s):
    if not isinstance(s, str):
        return s, False
    o = s
    for a, b in REPL:
        s = s.replace(a, b)
    return s, (s != o)


def main():
    p = DATA_DIR / "translations.json"
    tr = json.loads(p.read_text(encoding="utf-8-sig"))
    creatures = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
    quests_src = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))

    changed = 0
    samples = []

    def maybe(d, key, en_has):
        nonlocal changed
        if not en_has:
            return
        v = d.get(key)
        nv, ch = fix(v)
        if ch:
            d[key] = nv
            changed += 1
            if len(samples) < 12:
                samples.append((v[:50], nv[:50]))

    # пласкі en-ключовані секції
    for sect in ("itemNames", "itemFlavors", "questObjectives", "gossip"):
        d = tr.get(sect, {})
        for k in list(d):
            maybe(d, k, "silvermoon" in k.lower())

    # npcNames: en через creatures.json
    npc = tr.get("npcNames", {})
    for cid in list(npc):
        en = (creatures.get(cid, {}).get("name") or {}).get("en", "")
        maybe(npc, cid, "silvermoon" in en.lower())

    # quests: en із джерела (title+description+objectives)
    quests = tr.get("quests", {})
    for qid, fields in quests.items():
        src = quests_src.get(qid, {})
        en_blob = " ".join([
            (src.get("title") or {}).get("en", ""),
            (src.get("description") or {}).get("en", ""),
            (src.get("objectives") or {}).get("en", ""),
        ]).lower()
        if "silvermoon" not in en_blob or not isinstance(fields, dict):
            continue
        for fk in list(fields):
            maybe(fields, fk, True)

    p.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Виправлено рядків: {changed}")
    for a, b in samples:
        print(f"  {a!r} -> {b!r}")


if __name__ == "__main__":
    main()
