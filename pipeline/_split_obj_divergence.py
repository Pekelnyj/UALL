# -*- coding: utf-8 -*-
"""Розкласти розбіжності «неймплейт ≠ ціль квесту» на типи — щоб правити, а не гадати.

Вхід: data/wago_bulk/_obj_real.json (його пише _obj_npc_consistency.py).
Кожну пару відносимо до одного типу, бо лікуються вони по-різному:

  латиниця    — у цілі ім'я лишилось англійським («Зцілити Ermmglmrr III»):
                тут нема про що радитись, ціль просто недоперекладена;
  и/і · Г/Х   — той самий корінь, інша передача літери («Хіллхельм» ⇄ «Гіллгелм»):
                механічний свіп за домінантою;
  чергування  — відмінкове чергування голосних («чайка» ⇄ «чайок», «жнець» ⇄
                «женця»): ХИБНА тривога, шари насправді збігаються;
  слово       — обрано РІЗНІ слова («Курильниця» ⇄ «кадильниця», «Маля
                дикогрива» ⇄ «пташеня Лютогрива»): потрібен вирок власника.

Для типу «слово» показуємо, скільько разів кожна форма вже вжита в базі —
вирок при рівному рахунку лишається за власником [[questline-context-method]].

Запуск: python _split_obj_divergence.py
"""
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
real = json.loads((DATA_DIR / "wago_bulk" / "_obj_real.json")
                  .read_text(encoding="utf-8-sig"))

CYR = "А-Яа-яІіЇїЄєҐґ"
W = re.compile(rf"[{CYR}ʼ']{{4,}}")


def fold(w):
    """Звести написання до скелета: и=і=ї, г=х=ґ, е=є, прибрати знак м'якшення."""
    w = w.lower()
    for a, b in (("і", "и"), ("ї", "и"), ("є", "е"), ("ґ", "г"), ("х", "г"),
                 ("ь", ""), ("'", ""), ("ʼ", "")):
        w = w.replace(a, b)
    return w


def skel(w):
    """Ще грубіше: прибрати голосні — ловить чергування (чайка/чайок)."""
    return re.sub("[аеиоуюяї]", "", fold(w))


# скільки разів форма зустрічається в усій базі
TEXTS = []
for sec, d in tr.items():
    if isinstance(d, dict):
        TEXTS.extend(v for v in d.values() if isinstance(v, str))
BLOB = "\n".join(TEXTS).lower()

buckets = {"латиниця": [], "и/і · Г/Х": [], "чергування": [], "слово": []}
for it in real:
    en, canon, ua = it["en"], it["canon"], it["obj_ua"]
    # 1) ім'я лишилось латиницею в цілі
    if re.search(r"\b" + re.escape(en.split()[0]) + r"\b", ua):
        buckets["латиниця"].append(it)
        continue
    cw, ow = W.findall(canon), W.findall(ua)
    # 2) той самий корінь із іншою літерою
    if any(fold(a)[:5] == fold(b)[:5] for a in cw for b in ow):
        buckets["и/і · Г/Х"].append(it)
        continue
    # 3) чергування голосних у відмінку
    if any(skel(a)[:4] and skel(a)[:4] == skel(b)[:4] for a in cw for b in ow):
        buckets["чергування"].append(it)
        continue
    buckets["слово"].append(it)

for name, items in buckets.items():
    print(f"\n{'=' * 70}\n{name.upper()}: {len(items)}\n{'=' * 70}")
    for it in items:
        print(f"  «{it['en']}»")
        print(f"      плашка: {it['canon']}")
        print(f"      ціль:   {it['obj_ua'][:70]}")
        if name == "слово":
            cnt = []
            for w in W.findall(it["canon"])[:2] + W.findall(it["obj_ua"])[:3]:
                n = BLOB.count(w.lower())
                if n:
                    cnt.append(f"{w}={n}")
            if cnt:
                print(f"      у базі: {', '.join(cnt)}")

out = DATA_DIR / "wago_bulk" / "_obj_split.json"
out.write_text(json.dumps(buckets, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\n-> {out}")
print("  ".join(f"{k}: {len(v)}" for k, v in buckets.items()))
