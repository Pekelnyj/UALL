# -*- coding: utf-8 -*-
"""Знайти ІМЕНА з ґ/г-розбіжністю у квестах. Для кожного прапор-імені (зі скану
консистентності) беремо канон-UA-форму, для кожного слова з 'ґ'/'г' генеруємо
ґ↔г-варіант, рахуємо обидва в корпусі квестів. Обидва>0 = розбіжність.
Канон = форма за glossary (g→ґ) — але пропонуємо унікати до ДОМІНАНТНОЇ, бо
EN не завжди g (буває h→г). Вивід — список на ревʼю."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
nc = json.loads((DATA_DIR / "_name_consist.json").read_text(encoding="utf-8"))
tq = tr.get("quests", {})

corpus = []
for qid, t in tq.items():
    for f in ("title", "description", "objectives", "progress", "completion"):
        v = t.get(f)
        if isinstance(v, str):
            corpus.append(v)
C = "\n".join(corpus)


SWAP = {"ґ": "г", "г": "ґ", "Ґ": "Г", "Г": "Ґ"}


def variants_gh(word):
    """усі варіанти слова зі свопом ґ↔г / Ґ↔Г у кожній позиції."""
    pos = [i for i, ch in enumerate(word) if ch in SWAP]
    if not pos:
        return []
    res = set()
    for i in pos:  # один своп за раз (зазвичай різниться одна літера)
        res.add(word[:i] + SWAP[word[i]] + word[i + 1:])
    return [v for v in res if v != word]


flagged = {m["en"]: m["ua"] for m in nc["mixed"]}
flagged.update({a["en"]: a["ua"] for a in nc["allmiss"]})

seen_words = set()
report = []
for en, ua in flagged.items():
    for w in re.findall(r"[А-ЯЇІЄҐ][а-яїієґ'ґг]{2,}", ua):
        if "ґ" not in w and "г" not in w:
            continue
        if w in seen_words:
            continue
        seen_words.add(w)
        c0 = C.count(w)
        for v in variants_gh(w):
            cv = C.count(v)
            if c0 > 0 and cv > 0:
                # обидві форми вживані = розбіжність
                dom, mino = (w, v) if c0 >= cv else (v, w)
                report.append((max(c0, cv), min(c0, cv), dom, mino, en))

# унікальні за (dom,mino), сорт за частотою меншості (скільки правити)
uniq = {}
for big, small, dom, mino, en in report:
    key = tuple(sorted((dom, mino)))
    if key not in uniq or small > uniq[key][1]:
        uniq[key] = (dom, small, mino, big, en)

rows = sorted(uniq.values(), key=lambda x: -x[1])
print(f"ґ/г-розбіжних імен-слів: {len(rows)}")
print(f"{'ДОМІНАНТ':16s} {'×':>4s} | {'МЕНШІСТЬ(правити)':18s} {'×':>4s} | приклад-EN")
for dom, small, mino, big, en in rows:
    print(f"{dom:16s} {big:>4d} | {mino:18s} {small:>4d} | {en}")
json.dump([{"dom": d, "mino": m, "en": e} for d, s, m, b, e in rows],
          open(DATA_DIR / "_gh_fix.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
