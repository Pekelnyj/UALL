# -*- coding: utf-8 -*-
"""Звести ґ/г-розбіжності ІМЕН до УСТАЛЕНОЇ (домінантної) форми. НЕ сліпе g→ґ.
Принцип: усталена форма перемагає за частотою (Легіон=г лишається; Ґул'дан=ґ
лишається), правимо лише викиди-меншість. Групуємо ВІДМІНКИ одного імені за
префікс-ключем, агрегуємо ґ vs г по всій групі, обираємо ОДИН бік канону.
DRY-RUN за замовч.; з --apply пише у translations.json."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})

parts = []
for qid, t in tq.items():
    for f in ("title", "description", "objectives", "progress", "completion"):
        v = t.get(f)
        if isinstance(v, str):
            parts.append(v)
C = "\n".join(parts)
WORD = re.compile(r"[А-ЯЇІЄҐ][а-яїієґ'’ʼ]{3,}")
from collections import Counter
freq = Counter(WORD.findall(C))

DENY = {"легіон", "гора", "грім", "грей", "голу", "гонка", "грати", "горло",
        "горіх", "гомін", "гордо", "гарно", "гірко", "гущав"}
SWAP = {"ґ": "г", "г": "ґ", "Ґ": "Г", "Г": "Ґ"}


def skeleton(w):
    return w.replace("Ґ", "Г").replace("ґ", "г").lower()


def has_g(w):
    return "ґ" in w or "Ґ" in w


def keyof(skel):
    return skel[:7]  # префікс-ключ: групує відмінки одного імені


# зібрати поверхневі форми з ґ/г
surf_by_key = {}
for w, c in freq.items():
    sk = skeleton(w)
    if "г" not in sk:
        continue
    if len(sk) < 6:
        continue
    k = keyof(sk)
    surf_by_key.setdefault(k, {})[w] = c

fixmap = {}
plan = []
for k, surf in surf_by_key.items():
    if any(skeleton(w) in DENY for w in surf):
        continue
    g_side = {w: c for w, c in surf.items() if has_g(w)}
    h_side = {w: c for w, c in surf.items() if not has_g(w)}
    if not g_side or not h_side:
        continue
    gc, hc = sum(g_side.values()), sum(h_side.values())
    total = gc + hc
    if total < 5:
        continue
    canon_is_g = gc >= hc
    big = gc if canon_is_g else hc
    if big / total < 0.70:
        continue
    minority = h_side if canon_is_g else g_side
    canon_form = max((g_side if canon_is_g else h_side).items(), key=lambda x: x[1])[0]
    for w in minority:
        cf = "".join(SWAP[ch] if ch in SWAP else ch for ch in w)
        # гард: відмінок того самого імені (близька довжина), не компаунд-колізія
        if has_g(cf) == canon_is_g and cf != w and abs(len(w) - len(canon_form)) <= 4:
            fixmap[w] = cf
    plan.append((canon_form, big, total, sorted(minority.items(), key=lambda x: -x[1])))

plan.sort(key=lambda x: -sum(c for _, c in x[3]))
print(f"{'РЕЖИМ: ЗАСТОСУВАННЯ' if APPLY else 'РЕЖИМ: DRY-RUN (перегляд)'}")
print(f"імен до зведення: {len(plan)} | поверхневих форм-викидів: {len(fixmap)}\n")
print(f"{'КАНОН(усталене)':18s} {'×канон':>6s} {'%':>4s} | викиди → канон")
for canon, big, total, mins in plan:
    pct = round(100 * big / total)
    fixes = ", ".join(f"{w}×{c}→{fixmap.get(w,'?')}" for w, c in mins)
    print(f"  {canon:18s} {big:>6d} {pct:>3d}% | {fixes}")

if APPLY:
    total_repl = 0
    for qid, t in tq.items():
        for f in ("title", "description", "objectives", "progress", "completion"):
            v = t.get(f)
            if not isinstance(v, str):
                continue
            nv = v
            for bad, good in fixmap.items():
                if bad in nv:
                    nv = re.sub(r"(?<![А-Яа-яЇїІіЄєҐґ'’])" + re.escape(bad) +
                                r"(?![А-Яа-яЇїІіЄєҐґ'’])", good, nv)
            if nv != v:
                total_repl += 1
                t[f] = nv
    P.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"\nполів змінено: {total_repl}")
