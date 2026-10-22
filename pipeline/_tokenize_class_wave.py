# -*- coding: utf-8 -*-
"""Шаблонізувати звертання за КЛАСОМ у черзі: «paladin» -> {class}/{classv}.

Навіщо. Капча запікає клас гравця просто в англійський ключ: той самий рядок
Blizzard для паладина приходить як «Good luck out there, paladin.», а для мага —
«…, mage.». У базі він лежить ОДИН раз, шаблоном із {class}
[[class-token-mechanism]]. Дедуп у препі порівнює сирий рядок із ключем-шаблоном,
не збігається — і кожен новий тестер із новим класом повертає ті самі репліки
в чергу. Це рівно той самий дефект, що був із іменами гравців, і лікується так
само: шаблонізувати ДО дедупу.

Доказ підстановки — суто з даних, без здогадів: заміна визнається лише тоді,
коли отриманий ключ УЖЕ Є в базі. Якщо шаблону нема — рядок лишається
перекладачеві, нічого не вигадуємо.

{class} — називний (звертання «паладине»), {classv} — кличний; яку саме форму
взяти, вирішує наявний ключ бази, а не ми.

Запуск: python _tokenize_class_wave.py <тека> <префікс> [--apply]
   напр. python _tokenize_class_wave.py broadcast bc --apply
"""
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR, batch_files

SUB = sys.argv[1]
PRE = sys.argv[2]
APPLY = "--apply" in sys.argv

# секція бази, проти якої звіряємо чергу
SECTION = {"broadcast": "broadcast", "gossip": "gossip",
           "objlines": "questObjectives", "qcap": "quests"}.get(SUB, SUB)

CLASSES = [
    "death knight", "demon hunter", "dracthyr", "druid", "evoker", "hunter",
    "mage", "monk", "paladin", "priest", "rogue", "shaman", "warlock", "warrior",
]
# найдовші спершу, щоб «death knight» не розпався на «knight»
RX = re.compile(r"\b(%s)\b" % "|".join(sorted(CLASSES, key=len, reverse=True)),
                re.IGNORECASE)

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
base = tr.get(SECTION, {})

files = batch_files(SUB, PRE)
rekeyed, rest, seen = {}, [], set()
for f in files:
    for s in json.loads(f.read_text(encoding="utf-8")):
        t = s["en"] if isinstance(s, dict) else s
        if not RX.search(t):
            rest.append(s)
            continue
        for tok in ("{class}", "{classv}"):
            k = RX.sub(tok, t)
            if k in base:
                rekeyed[t] = k
                break
        else:
            rest.append(s)
            seen.add(RX.search(t).group(0).lower())

print(f"{SUB}: рядків {sum(1 for f in files for _ in json.loads(f.read_text(encoding='utf-8')))} "
      f"| шаблонізовано (є в базі): {len(rekeyed)} | лишається: {len(rest)}")
for a, b in list(rekeyed.items())[:6]:
    print(f"      ✔ {a[:52]:<54}-> {b[:52]}")
if seen:
    print(f"      ? зі згадкою класу, але шаблону в базі нема: {sorted(seen)}")

if not APPLY:
    print("\n(звіт; щоб застосувати — --apply)")
    sys.exit()

BD = DATA_DIR / "batches" / SUB
size = 15
for f in files:
    f.unlink()
for k in range((len(rest) + size - 1) // size):
    (BD / f"{PRE}_{k:02d}.json").write_text(
        json.dumps(rest[k * size:(k + 1) * size], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"-> у черзі лишилось: {len(rest)} (батчів {(len(rest) + size - 1) // size})")
