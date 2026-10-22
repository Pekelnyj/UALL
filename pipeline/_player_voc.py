# -*- coding: utf-8 -*-
"""(1) Відкотити зламані '(вокатив:жін)' без $p. (2) Застосувати правильні $p-токени
безпечних вокативів звертання до гравця."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
P = Path("g:/Claude Code/WoWUkraine/data/translations.json")
tr = json.loads(P.read_text(encoding="utf-8-sig"))

VOC = {
    "смертний": "смертна", "чужинцю": "чужинко", "мандрівнику": "мандрівнице",
    "мандрівниче": "мандрівнице", "герою": "героїне", "чемпіоне": "чемпіонко",
    "шукачу": "шукачко", "незнайомцю": "незнайомко", "захиснику": "захиснице",
    "подорожній": "подорожня", "авантюристе": "авантюристко", "прибульцю": "прибулько",
}
TOKEN = "$" + "p"  # уникаємо будь-яких сюрпризів

# (1) ВІДКАТ зламаних "(M:F)" (без $p перед "(") → лишаємо M
fem_set = set(VOC.keys()) | {v for v in VOC.values()}
BROKEN = re.compile(r"(?<![$\w])\(([А-Яа-яІЇЄҐіїєґ]+):([А-Яа-яІЇЄҐіїєґ]+)\)")
reverted = 0


def unbreak(s):
    global reverted
    def r(m):
        global reverted
        masc = m.group(1)
        if masc.lower() in VOC:
            reverted += 1
            return masc
        return m.group(0)
    return BROKEN.sub(r, s)


# (2) Правильні токени
applied = 0
PAT = re.compile(r"\b(" + "|".join(re.escape(k) for k in VOC) + r")\b", re.IGNORECASE)


def apply_voc(s):
    global applied
    def r(m):
        global applied
        w = m.group(0)
        lw = w.lower()
        f = VOC[lw]
        if w[0].isupper():
            f = f[0].upper() + f[1:]
        applied += 1
        return TOKEN + "(" + w + ":" + f + ")"
    return PAT.sub(r, s)


for qid, q in tr.get("quests", {}).items():
    if not isinstance(q, dict):
        continue
    for fld in ("title", "description", "progress", "completion", "objectives"):
        v = q.get(fld)
        if not isinstance(v, str):
            continue
        v2 = unbreak(v)          # відкат зламаного
        # застосувати токени лише там, де ще нема $p-вокатива (verb-токени не заважають)
        v2 = apply_voc(v2)
        if v2 != v:
            q[fld] = v2

P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"відкочено зламаних: {reverted} | застосовано правильних вокатив-токенів: {applied}")
# контроль
blob = json.dumps(tr["quests"], ensure_ascii=False)
print("$p( усього в квестах:", blob.count(TOKEN + "("))
print("зламаних (X:Y) лишилось:", len([1 for m in BROKEN.finditer(blob) if m.group(1).lower() in VOC]))
