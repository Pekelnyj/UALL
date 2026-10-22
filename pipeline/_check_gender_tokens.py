# -*- coding: utf-8 -*-
"""Гейт родових токенів $p(чол:жін): розгортає обидві гілки й шукає покруч.

Проєктна домовленість — ділити КОРІНЬ: «ціл$p(ий:а)» -> «цілий/ціла». Для
дієслів минулого часу цей прийом не працює: «виглядав$p(:ла)» розгортається в
«виглядав» / «виглядавла». Спільного кореня в «виглядав» і «виглядала» немає,
тож у токені мають стояти ПОВНІ слова: «$p(виглядав:виглядала)».

Помилку не видно ні очима в коді, ні чоловічому персонажу в грі — вона
вилазить лише в жінок, тобто в половини гравців.

Запуск: python _check_gender_tokens.py [--all]
        без --all перевіряє лише батчі out_*, з --all — усю базу.
"""
import glob
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

PRX = re.compile(r"\$p\(([^():]*):([^():]*)\)")
# структурна ознака: токен стоїть ПІСЛЯ приголосної, жіноча гілка починається
# на «л», а чоловіча порожня або «ся» — це минулий час на -в/-ла, у якого
# спільного кореня немає: «забув$p(:ла)» -> «забувла».
# «прийш$p(ов:ла)» під правило не підпадає (чоловіча гілка не порожня), як і
# «народи$p(вся:лася)» (перед токеном голосна) — обидва коректні.
STRUCT = re.compile(r"([бвгґджзклмнпрстфхцчшщ])\$p\((|ся):(л[^():]*)\)", re.I)
# другий рубіж — уже за розгорнутим текстом
FEM_GLUE = re.compile(r"[а-яіїєґ]в(ла|ло|ли)\b", re.I)


def expand(s, idx):
    return PRX.sub(lambda m: m.group(1 + idx), s)


def check(label, text, hits):
    if "$p(" not in text:
        return
    # Однакові гілки — завжди помилка набору: «$p(ася:ася)» показує обом родам
    # ту саму форму, тобто токен не працює, хоча виглядає правильним.
    for a, b in PRX.findall(text):
        if a == b:
            hits.append((label, "однакові гілки — токен нічого не змінює",
                         f"$p({a}:{b})"))
            return
    m = STRUCT.search(text)
    if m:
        hits.append((label, "корінь не ділиться (минулий час -в/-ла)",
                     expand(text[max(0, m.start() - 30):m.end() + 20], 1)))
        return
    masc, fem = expand(text, 0), expand(text, 1)
    if FEM_GLUE.search(fem) and not FEM_GLUE.search(masc):
        hits.append((label, "зрощення «-в» + «-ла» в жіночій формі", fem))


hits = []
if "--all" in sys.argv:
    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))

    def walk(o, path):
        if isinstance(o, dict):
            for k, v in o.items():
                walk(v, f"{path}/{k}")
        elif isinstance(o, list):
            for v in o:
                walk(v, path)
        elif isinstance(o, str):
            check(path, o, hits)

    walk(tr, "")
else:
    # лише АКТИВНІ черги: у batches/ лежать і архіви давніх хвиль, і їхні
    # покручі вже або злиті й полагоджені, або відкинуті — шум перед мерджем
    WAVE = ("gossip", "broadcast", "qcap", "objlines", "profui", "uitooltip")
    files = [p for d in WAVE
             for p in glob.glob(str(DATA_DIR / "batches" / d / "out_*.json"))]
    # Обхід має бути РЕКУРСИВНИЙ: qcap-батчі це список словників, у яких
    # переклад лежить у вкладеному "fields". Пласкою перевіркою квестові поля
    # не перевірялися взагалі.
    def walk_batch(o, label):
        if isinstance(o, dict):
            for k, v in o.items():
                walk_batch(v, f"{label}/{k}")
        elif isinstance(o, list):
            for v in o:
                walk_batch(v, label)
        elif isinstance(o, str):
            check(label, o, hits)

    for f in files:
        walk_batch(json.loads(open(f, encoding="utf-8").read()),
                   f.split("batches")[-1])

if hits:
    print(f"⚠️ ЗЛАМАНИХ РОДОВИХ ТОКЕНІВ: {len(hits)}")
    for label, why, form in hits[:40]:
        print(f"  [{label}] {why}: …{form[:90]}")
    sys.exit(1)
print("✅ Родові токени: покручів не знайдено.")
