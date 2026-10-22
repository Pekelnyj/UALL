# -*- coding: utf-8 -*-
"""Свіп власних назв до канону — БЕЗПЕЧНОЮ частиною.

Вирок користувача лягає в data/canon.json як {canon, forbidden[]}. Далі
заміна ділиться надвоє, і об'єднувати ці половини не можна:

  [1] ЦІЛЕ ЗНАЧЕННЯ — коли українське значення і є сама назва
      (taxiNodes «Nijel's Point, Desolace» -> «Пункт Найджела, Десолас»
      сюди НЕ входить, а gameObjects/factions/areaPOI, де значення це
      рівно «Десолас», — входять). Відмінка немає, роду немає, ризику
      немає: міняємо рядок цілком.

  [2] У РЕЧЕННІ — «мешканці Лісу Срібної Сосни». Тут сліпа заміна ЛАМАЄ
      відмінок і рід [[term-rename-spread-and-gender]]: «Ліс» чоловічого
      роду, «Срібнолісся» середнього, тож усе узгодження навколо стає
      хибним. Скрипт такі місця лише РАХУЄ і показує — правити їх має
      перекладач, а не регекс.

Запуск:
    python _normalize_names.py                 # звіт по всьому канону
    python _normalize_names.py --only Desolace
    python _normalize_names.py --apply         # виконати ЛИШЕ частину [1]
"""
import io
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
ONLY = None
if "--only" in sys.argv:
    ONLY = sys.argv[sys.argv.index("--only") + 1]

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
canon = json.loads((DATA_DIR / "canon.json").read_text(encoding="utf-8-sig"))


def ua_of(v):
    if isinstance(v, str):
        return v
    if isinstance(v, dict):
        for f in ("name", "title", "text", "ua", "value"):
            x = v.get(f)
            if isinstance(x, str) and x.strip():
                return x
    return ""


def set_ua(d, k, new):
    v = d[k]
    if isinstance(v, str):
        d[k] = new
        return
    for f in ("name", "title", "text", "ua", "value"):
        if isinstance(v.get(f), str) and v[f].strip():
            v[f] = new
            return


whole = Counter()
inline = Counter()
changes = []

for en, rec in canon.items():
    if ONLY and ONLY.lower() not in en.lower():
        continue
    good = rec.get("canon")
    bad_forms = [b for b in (rec.get("forbidden") or []) if b]
    if not good or not bad_forms:
        continue
    # Заборонені форми в canon.json бувають записані як фрагмент кореня
    # («Чорнокам»), тож дозволяємо коротке закінчення, але не словотвір.
    pats = [(b, re.compile(re.escape(b) + r"\w{0,3}\b", re.I)) for b in bad_forms]

    for sec, d in tr.items():
        if not isinstance(d, dict):
            continue
        for k in list(d):
            u = ua_of(d[k])
            if not u:
                continue
            for b, pat in pats:
                m = pat.fullmatch(u.strip())
                if m:
                    whole[en] += 1
                    changes.append((sec, k, u, good, en))
                    if APPLY:
                        set_ua(d, k, good)
                    break
                if pat.search(u):
                    inline[en] += 1
                    break

print(f"{'назва':<26}{'ціле значення':>15}{'у реченні':>12}")
print("-" * 55)
for en in sorted(set(whole) | set(inline)):
    print(f"{en:<26}{whole[en]:>15}{inline[en]:>12}")

if changes:
    print(f"\nЗАМІНА ЦІЛОГО ЗНАЧЕННЯ ({len(changes)}):")
    for sec, k, old, new, en in changes[:25]:
        print(f"  [{sec}] {str(k)[:40]!r}: {old!r} -> {new!r}")
    if len(changes) > 25:
        print(f"  …ще {len(changes) - 25}")

tot_inline = sum(inline.values())
if tot_inline:
    print(f"\nУ РЕЧЕННІ: {tot_inline} — НЕ чіпаю. Заміна всередині тексту "
          f"ламає відмінок і рід; це робота перекладача, не регексу.")

if APPLY and changes:
    io.open(P, "w", encoding="utf-8", newline="\n").write(
        json.dumps(tr, ensure_ascii=False, indent=1))
    print(f"\nзаписано змін: {len(changes)}")
elif not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
