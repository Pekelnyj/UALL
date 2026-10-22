# -*- coding: utf-8 -*-
"""Витягти неперекладені tracker-цілі (db.objLines) з капчурів у батчі.

Приймає КІЛЬКА файлів і об'єднує їх. Раніше брався лише один шлях, а кожен
запуск затирав батчі попереднього — тож із трьох зборів у чергу потрапляв
тільки останній [[patch-refresh-gotchas]].

Запуск: python _prep_objlines_wave.py "<файл1>" ["<файл2>" ...] [--size N]
-> data/batches/objlines/ol_NN.json  [англ. рядок, ...]"""
import sys, re, json, glob
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

args = sys.argv[1:]
size = 15
if "--size" in args:
    i = args.index("--size")
    size = int(args[i + 1])
    del args[i:i + 2]
paths = args or glob.glob(
    r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/WoWUkraine.lua")
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
qo = set(tr.get("questObjectives", {}))
CYR = re.compile("[Ѐ-ӿ]")
# Ознаки НІМЕЦЬКОГО клієнта: умляути/ß або службові слова, яких в
# англійському тексті гри не буває. «Quest» сюди класти НЕ можна — воно
# англійське, і перша спроба з ним дала 900 фальшивок на всю базу.
DE = re.compile(
    r"[äöüÄÖÜß]|\b(Abbrechen|Zurueck|Fertig|besiegt|Euch|Eure|nicht|werden|"
    r"wurde|einem|einer|eines|durch|gegen|sowie|bereits|Gegenstand|erhalten|"
    r"abgeschlossen|Ehrt|Beute|Truhe|Schluessel)\b")


def block(key):
    m = re.search(r'\["' + key + r'"\]\s*=\s*\{', s)
    if not m:
        return ""
    i, depth = m.end(), 1
    instr = esc = False
    start = i
    while i < len(s) and depth > 0:
        c = s[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return s[start:i - 1]


def un(x):
    x = x.replace("\\\\", "\x00")
    x = x.replace('\\"', '"').replace("\\n", "\n").replace("\\r", "\r").replace("\\t", "\t")
    return x.replace("\x00", "\\")


# block() читає глобальний s, тож перевизначаємо його на кожен файл і
# ДОДАЄМО ключі, а не заміняємо: інакше з трьох зборів лишався б останній
keys = []
for _p in paths:
    s = open(_p, encoding="utf-8", errors="replace").read()
    keys += re.findall(r'\["((?:[^"\\]|\\.)*)"\]', block("objLines"))
new, seen = [], set()
for k in keys:
    u = un(k).strip()
    if not u or u in seen or u in qo:
        continue
    if not re.search(r"[A-Za-z]{3}", u):   # без латинських слів — пропуск
        continue
    if CYR.search(u):                       # уже містить укр. — пропуск
        continue
    # НАБІР У ПОЛІ ПОШУКУ. Збирач ловить і рядок пошуку трекера, поки гравець
    # його друкує, тож у чергу лягає драбинка: «the» -> «the s» -> «the sh».
    # Ознака — дуже короткий рядок без розділових знаків і без другого слова
    # з великої. Справжня ціль коротшою за це не буває.
    if len(u) < 8 and not re.search(r"[0-9/:]|[A-Z][a-z]{2}", u):
        continue
    # НІМЕЦЬКИЙ КЛІЄНТ. Частина тестерів грає не англійською, і збір бере
    # текст таким, яким його показує гра. Такий ключ не зматчиться в
    # англійського гравця НІКОДИ — переклад змарновано, запис мертвий.
    # 12.09 з 197 цілей 77 виявилися німецькими («Abbrechen», «Zurück»,
    # «Frostfürst besiegt»), а в базі вже лежало 23 німецькі репліки.
    if DE.search(u):
        continue
    seen.add(u)
    new.append(u)

# Відсів рантайму: у db.objLines осідають таймери («Time Left: 5 Min»),
# лічильники й вимоги рівня — рядки, у які гра підставляє число, тож ключем
# бази вони не стануть ніколи.
import capfilter
new, _dropped = capfilter.split(new)
capfilter.report(_dropped)

# Тіла квестових листів приходять із шапкою на ім'я гравця («Pekelnyj,\n\n…»).
# У базі такий рядок лежить шаблоном із {NAME}, тож без підстановки дедуп його
# не бачить і лист вертається в чергу з кожним новим тестером — і водночас
# це витік ніка [[player-name-leak-gate]].
from playernames import nick_regex
_NICK = nick_regex(min_len=4)
_b = len(new)
new = [_NICK.sub("{NAME}", s) for s in new]
_tok = sum(1 for s in new if "{NAME}" in s)
if _tok:
    print(f"  шаблонізовано ніків у {{NAME}}: {_tok}")
# після підстановки частина рядків уже є в базі — знімаємо повторно
new = [s for s in new if s not in qo]
if _b != len(new):
    print(f"  знято вже перекладеного після шаблонізації: {_b - len(new)}")

OUT = DATA_DIR / "batches" / "objlines"
OUT.mkdir(parents=True, exist_ok=True)
for f in OUT.glob("ol_*.json"):
    f.unlink()
for f in OUT.glob("out_ol_*.json"):
    f.unlink()
nb = (len(new) + size - 1) // size
for k in range(nb):
    (OUT / f"ol_{k:02d}.json").write_text(
        json.dumps(new[k * size:(k + 1) * size], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"objLines неперекладених: {len(new)} -> батчів {nb} (по {size})")
