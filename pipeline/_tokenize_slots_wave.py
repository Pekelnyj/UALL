# -*- coding: utf-8 -*-
"""Знайти в черзі СЛОТИ імені гравця, яких немає в списку ніків.

У збір потрапляють імена інших гравців (група, рейд, арена). Списком їх не
покриєш — але слот видно з даних, двома самоочевидними доказами:

  1. ШАБЛОН УЖЕ В БАЗІ: якщо, замінивши одне латинське слово на {NAME}, дістаємо
     ключ, який у базі вже є, — те слово було змінною. База зібрана з інших
     капч, тож збіг не випадковий.
  2. ЗГОРТАННЯ: два рядки черги різняться рівно одним латинським словом —
     отже, це слот, а не власна назва (репліки NPC не приходять десятком
     варіантів із різними іменами).

Слово зі NPC-якорем (EN+de+fr у creatures.json) не чіпаємо.

Запуск: python _tokenize_slots_wave.py broadcast [--apply]
        python _tokenize_slots_wave.py gossip [--apply]
"""
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

SUB = sys.argv[1] if len(sys.argv) > 1 else "broadcast"
APPLY = "--apply" in sys.argv
CFG = {"broadcast": ("bc", "{NAME}", "broadcast"),
       "gossip": ("g", "{name}", "gossip")}[SUB]
PRE, TOK, SEC = CFG

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
base_d = tr.get(SEC, {})


def norm(s):
    return re.sub(r"\s+", " ", s).strip().lower()


base = {norm(k) for k in base_d}

crea = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
npc = set()
for v in (crea.values() if isinstance(crea, dict) else crea):
    if not isinstance(v, dict):
        continue
    nm = v.get("name") if isinstance(v.get("name"), dict) else v
    if isinstance(nm, dict) and nm.get("en") and nm.get("de") and nm.get("fr"):
        for w in re.findall(r"[A-Z][A-Za-z'À-ÿ]+", nm["en"]):
            npc.add(w)

BD = DATA_DIR / "batches" / SUB
# Маска з РІВНО двох цифр губила батчі ol_100+ (препи роблять сотні
# файлів): старі лишалися нечищеними й задвоювали чергу.
files = sorted(BD.glob(f"{PRE}_[0-9]*.json"),
               key=lambda f: int(re.search(r"(\d+)", f.stem).group(1)))
items = []
for f in files:
    items += json.loads(f.read_text(encoding="utf-8"))
if not items:
    print("черга порожня")
    sys.exit()

# Ім'я в слоті буває й КИРИЛИЦЕЮ («A treasure chest has spawned for Кабандин!»):
# без цього такі рядки лишалися в черзі як «нові» щоразу.
TOKRX = re.compile(r"\b[A-ZÀ-ÞА-ЯЇІЄҐ][A-Za-zÀ-ÿА-Яа-яЇїІіЄєҐґ']{2,}"
                   r"(?:-[A-ZА-ЯЇІЄҐ][A-Za-zА-Яа-я']+)?\b")
_WORD = re.compile(r"[A-Za-zÀ-ÿА-Яа-яЇїІіЄєҐґ']{2,}")


def enough_context(head, tail):
    """Шаблон вартий довіри лише коли поза словом лишається реальний текст.

    Без цього однослівні репліки («HELP!», «Incredible!») збігаються з наявним
    у базі шаблоном «{NAME}!» — і рядок знищується підміною на токен.

    Одного слова досить: «Kill {NAME}!» — законний шаблон, який справді є в
    базі, а бар'єр у три слова відкидав його разом зі сміттям. Нуль слів
    («HELP!») лишається відсіяним, і це саме той випадок, від якого гейт.
    """
    return len(_WORD.findall(head + " " + tail)) >= 1


def text_of(it):
    return it["en"] if isinstance(it, dict) else it


# --- доказ 1: шаблон із бази -----------------------------------------------
found = {}
for i, it in enumerate(items):
    s = text_of(it)
    for m in TOKRX.finditer(s):
        w = m.group(0)
        # Апостроф у класі символів потрібен для «Zul'jin», але він жадібно
        # ковтає й присвійне «'s»: «<нік>'s» матчилося цілком, і підстановка
        # давала «{NAME} accomplishment» замість «{NAME}'s accomplishment».
        end = m.end()
        if w.endswith("'s") or w.endswith("’s"):
            w, end = w[:-2], end - 2
        if len(w) < 3 or w in npc:
            continue
        head, tail = s[:m.start()], s[end:]
        if not enough_context(head, tail):
            continue
        if norm(head + TOK + tail) in base:
            found.setdefault(i, set()).add(w)
            break
        # Ім'я трапляється в рядку ДЕКІЛЬКА разів («{NAME} has defeated…
        # All hail {NAME}!»): заміна лише першого входження шаблон не дає.
        allsub = re.sub(r"\b" + re.escape(w) + r"\b", TOK, s)
        if allsub != s and norm(allsub) in base:
            found.setdefault(i, set()).add(w)
            break

# --- доказ 2: згортання ----------------------------------------------------
cand = defaultdict(lambda: defaultdict(list))
for i, it in enumerate(items):
    s = text_of(it)
    for m in TOKRX.finditer(s):
        w = m.group(0)
        if w in npc:
            continue
        if not enough_context(s[:m.start()], s[m.end():]):
            continue
        cand[s[:m.start()] + "\x00" + s[m.end():]][w].append(i)
for ws in cand.values():
    if len(ws) >= 2:
        for w, idxs in ws.items():
            for i in idxs:
                found.setdefault(i, set()).add(w)

names = sorted({w for ws in found.values() for w in ws})
print(f"{SUB}: рядків {len(items)} | зі слотом {len(found)} | "
      f"імен у слотах {len(names)}")
if names:
    print("  " + ", ".join(names[:40]) + (" …" if len(names) > 40 else ""))

if not APPLY:
    print("\n(звіт; щоб застосувати — --apply)")
    sys.exit()

out, seen, stat = [], set(), defaultdict(int)
for i, it in enumerate(items):
    s = text_of(it)
    for w in sorted(found.get(i, ()), key=len, reverse=True):
        s = re.sub(r"\b" + re.escape(w) + r"\b", TOK, s)
        s = re.sub(r"\b" + re.escape(w.upper()) + r"\b", TOK, s)
    if s != text_of(it):
        stat["шаблонізовано"] += 1
    if norm(s) in base:
        stat["уже в базі"] += 1
        continue
    if norm(s) in seen:
        stat["дубль знято"] += 1
        continue
    seen.add(norm(s))
    if isinstance(it, dict):
        it = dict(it)
        it["en"] = s
        out.append(it)
    else:
        out.append(s)
for k, v in sorted(stat.items()):
    print(f"  {k}: {v}")
print(f"лишилось: {len(out)}")

size = max(1, (len(out) + len(files) - 1) // max(1, len(files)))
for f in files:
    f.unlink()
for k in range((len(out) + size - 1) // size):
    (BD / f"{PRE}_{k:02d}.json").write_text(
        json.dumps(out[k * size:(k + 1) * size], ensure_ascii=False, indent=1),
        encoding="utf-8")
