# -*- coding: utf-8 -*-
"""Для заданих EN-імен показати РЕАЛЬНІ UA-форми, вжиті в квестах (контекст біля
імені), щоб побачити справжню розбіжність і яка форма домінує."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
qsrc = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})

PROBES = sys.argv[1:] or ["Gul'dan", "Xal'atath", "Garrosh", "Grommash",
                          "Khadgar", "Sylvanas", "Mekkatorque", "Gelbin"]

# для імені знайти квести, де EN присутній, і витягти cyr-токени поряд (евристика:
# у UA шукаємо великі-літерні кир. слова, рахуємо частоти стемів)
from collections import Counter
for probe in PROBES:
    pat = re.compile(r"\b" + re.escape(probe))
    forms = Counter()
    examples = {}
    for qid, qd in qsrc.items():
        if qid not in tq:
            continue
        qen = ((qd.get("title", {}) or {}).get("en", "") + " " +
               (qd.get("description", {}) or {}).get("en", ""))
        if not pat.search(qen):
            continue
        t = tq[qid]
        qua = (t.get("title", "") or "") + " " + (t.get("description", "") or "")
        # усі великі-літерні кириличні слова (потенційні форми імені)
        for w in re.findall(r"[А-ЯЇІЄҐ][а-яїієґ']{2,}", qua):
            forms[w] += 1
            examples.setdefault(w, qid)
    # показати топ кириличних слів (імена-кандидати)
    top = [(w, c) for w, c in forms.most_common(40)]
    print(f"### {probe}  (квестів: знайдено) — топ кир.слів у їх перекладах:")
    print("   ", ", ".join(f"{w}×{c}" for w, c in top[:18]))
    print()
