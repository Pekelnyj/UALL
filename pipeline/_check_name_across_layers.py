# -*- coding: utf-8 -*-
"""Той самий англійський рядок у РІЗНИХ секціях перекладено по-різному.

Навіщо. Одне ім'я живе в кількох шарах: назва гілки, назва завдання, ціль
трекера, вузол таксі, ім'я істоти, журнал. Перекладали їх різні хвилі й
різного часу, тож база суперечить сама собі частіше, ніж помиляється
окремий перекладач [[base-contradicts-itself-across-layers]]. Гравець
летить у «Десолейс», а журнал каже «Пустограй», і це те саме місце.

Доказ навмисне вузький: беремо ЛИШЕ випадки, де англійський рядок
збігається байт-у-байт, а українські значення розходяться коренем. Тоді
не треба ні вирівнювати слова, ні впізнавати транслітерацію — розбіжність
видно без здогадів.

Чого цей гейт НЕ ловить: ім'я всередині речення («…у Десоласі» в тілі
завдання). Для цього потрібен список конкурентних форм, а він береться з
розбору canon_build.py, не звідси.

Запуск:
    python _check_name_across_layers.py [--top N] [--min-len N]
"""
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

TOP = 30
if "--top" in sys.argv:
    TOP = int(sys.argv[sys.argv.index("--top") + 1])
MINLEN = 4
if "--min-len" in sys.argv:
    MINLEN = int(sys.argv[sys.argv.index("--min-len") + 1])

# Секції з ключем-АНГЛІЙСЬКИМ-РЯДКОМ. Секції з ключем-ID сюди не годяться:
# там ключ не текст, і зіставляти нема чого [[sv-bucket-vs-section-key]].
SECTIONS = [
    "questLines", "questObjectives", "taxiNodes", "gameObjects", "uiTooltips",
    "uiMisc", "uiStrings", "journalSections", "journal_instances", "factions",
    "minimapLabels", "areaPOI", "subnames", "itemNames", "housingUI",
    "instanceDesc", "vignette", "scenario", "gossip", "broadcast",
]
# Рядок-НАЗВА: коротка, без розділових знаків кінця речення. Довгі речення
# законно перекладають по-різному в різних місцях — це не розбіжність імені.
MAXW = 5
SENT = re.compile(r"[.!?]|\n")
ROOT = 5   # «Ґорфієнда» і «Ґорфієнд» — один корінь, «Кровогуб» — інший
UAW = re.compile(r"[А-ЯІЇЄҐа-яіїєґ'’][А-ЯІЇЄҐа-яіїєґ'’-]{2,}")


def ua_of(v):
    if isinstance(v, str):
        return v
    if isinstance(v, dict):
        for f in ("name", "title", "text", "ua", "value"):
            x = v.get(f)
            if isinstance(x, str) and x.strip():
                return x
    return ""


def is_name(s):
    return (len(s) >= MINLEN and len(s.split()) <= MAXW
            and not SENT.search(s) and not s.isdigit())


def roots(s):
    return {w[:ROOT].lower() for w in UAW.findall(s)}


tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))

byen = defaultdict(dict)     # англ. -> {секція: укр.}
for sec in SECTIONS:
    d = tr.get(sec)
    if not isinstance(d, dict):
        continue
    for en, v in d.items():
        if not isinstance(en, str) or not is_name(en):
            continue
        ua = ua_of(v)
        if ua:
            byen[en].setdefault(sec, ua)

rows = []
for en, per in byen.items():
    if len(per) < 2:
        continue
    vals = set(per.values())
    if len(vals) < 2:
        continue
    # відмінок чи регістр — не розбіжність; корінь мусить розійтися
    rs = [roots(v) for v in vals]
    if set.intersection(*rs):
        continue
    rows.append((en, per))

rows.sort(key=lambda x: (-len(x[1]), x[0]))
print(f"назв під наглядом: {len(byen)} | секцій: {len(SECTIONS)}")
print(f"ОДИН КЛЮЧ — РІЗНИЙ ПЕРЕКЛАД: {len(rows)}\n")
for en, per in rows[:TOP]:
    print(f"  {en!r}")
    for sec, ua in sorted(per.items()):
        print(f"      {sec:<18} {ua}")
if len(rows) > TOP:
    print(f"\n…ще {len(rows) - TOP}. Показати більше: --top N")
sys.exit(1 if rows else 0)
