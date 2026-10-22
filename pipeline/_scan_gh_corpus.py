# -*- coding: utf-8 -*-
"""Корпус-driven скан ґ/г-розбіжностей ІМЕН: збираємо всі великі-літерні кириличні
слова-стеми (потенційні імена) з ґ/г/Ґ/Г, рахуємо в корпусі квестів; де існує й
ґ-, і г-варіант того самого слова — розбіжність. Канон за glossary = ґ-форма
(g→ґ), правимо г-форму до ґ-форми. Вивід — пари на ревʼю + автофікс-кандидати."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})
parts = []
for qid, t in tq.items():
    for f in ("title", "description", "objectives", "progress", "completion"):
        v = t.get(f)
        if isinstance(v, str):
            parts.append(v)
C = "\n".join(parts)

# великі-літерні слова-стеми (ім'я-подібні): перша велика, далі кир.літери/апостроф.
# Нормалізуємо апострофи. Стем = слово без хвостового відмінкового закінчення —
# беремо як є; частоти рахуємо по точному слову.
WORD = re.compile(r"[А-ЯЇІЄҐ][а-яїієґ'’ʼ]{3,}")
from collections import Counter
freq = Counter(WORD.findall(C))

SWAP = {"ґ": "г", "г": "ґ", "Ґ": "Г", "Г": "Ґ"}


def gh_variant(word):
    """Якщо у слові є ґ/г/Ґ/Г — повернути варіант з одним свопом (перший збіг)."""
    out = []
    for i, ch in enumerate(word):
        if ch in SWAP:
            out.append(word[:i] + SWAP[ch] + word[i + 1:])
    return out


pairs = {}
for w, c in freq.items():
    if "ґ" not in w.lower() and "Ґ" not in w and "г" not in w.lower():
        continue
    for v in gh_variant(w):
        cv = freq.get(v, 0)
        if cv > 0:
            key = tuple(sorted((w, v)))
            if key not in pairs:
                # ґ-форма = канон (g→ґ); але показуємо обидві частоти
                a, b = key
                ga = a if ("ґ" in a or "Ґ" in a) else b   # ґ-форма
                gg = b if ga == a else a                   # г-форма
                pairs[key] = (ga, freq.get(ga, 0), gg, freq.get(gg, 0))

rows = sorted(pairs.values(), key=lambda x: -(x[1] + x[3]))
print(f"ґ/г-пар імен-стемів у корпусі: {len(rows)}")
print(f"{'ґ-ФОРМА(канон)':18s} {'×':>4s} | {'г-форма':18s} {'×':>4s}")
for ga, ca, gg, cg in rows:
    print(f"{ga:18s} {ca:>4d} | {gg:18s} {cg:>4d}")
json.dump([{"canon": ga, "drift": gg, "ca": ca, "cg": cg} for ga, ca, gg, cg in rows],
          open(DATA_DIR / "_gh_pairs.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
