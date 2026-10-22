# -*- coding: utf-8 -*-
"""Злиття хвилі «назви заклять у лінках» (див. _prep_spell_links_wave.py).

Вихід агента data/batches/spelllinks/out_sl_NN.json:
  {"<n>": {"links": ["форма для 1-го лінка з черги", ...],
           "edits": [["старий фрагмент", "новий фрагмент"], ...]}}

Підстановка детермінована: у дужки лінка лягає лише назва, коди |c/|H/|h/|r,
$bullet;, $s1, числа й переноси не зачіпаються. Правка узгодження приймається,
лише якщо старий фрагмент трапляється РІВНО один раз, не зачіпає розмітку і
не довший за 60 символів — інакше це вже переписування, а не узгодження.

Відмова по рядку (рядок лишається як був) і причина в звіті, якщо:
  • поточне значення в базі змінилося після підготовки черги;
  • кількість форм ≠ кількості лінків у черзі;
  • форма без кирилиці, з латиницею, з дужками чи розміткою;
  • форма кардинально інша за spells[ID] (немає спільного кореня);
  • скелет розмітки після підстановки не збігся з оригіналом.

Запуск: python _merge_spell_links_wave.py [--apply]
Далі:   python generate_db.py
"""
import io
import json
import re
import sys
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
B = DATA_DIR / "batches" / "spelllinks"
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
ba = tr["bossAbilities"]

LINK = re.compile(r"\|Hspell:(\d+)\|h\[([^\]]+)\]\|h")
CYR = re.compile(r"[А-Яа-яІіЇїЄєҐґ]")
LAT = re.compile(r"[A-Za-z]{2,}")
MARKUP = re.compile(r"\|c[0-9A-Fa-f]{8}|\|r|\|H[^|]*\|h|\|h|\|T[^|]*\|t|\|A[^|]*\|a"
                    r"|\$[A-Za-z]+;|\$\[|\$\]|\$\d*[A-Za-z]+\d*|\n|\d+")
BAD_FORM = re.compile(r"[\[\]|$\n]")
CODE = re.compile(r"(?<=\s)[A-Za-z0-9]*\d[A-Za-z0-9-]*$|(?<=\s)[A-Z]{1,3}\d[\w-]*$")


def skeleton(s):
    """Розмітка й числа поза дужками лінків — мусять лишитися тими самими."""
    return MARKUP.findall(LINK.sub(lambda m: "|Hspell:" + m.group(1) + "|h[]|h", s))


def stems(s):
    # короткі назви («Сон», «Око рою») теж мусять мати корінь: слова від 2 літер,
    # префікс до 3 — інакше обидві множини порожні й форма, тотожна `ua`,
    # відхилялася (хвиля 13.09, sl_02)
    return {w[:3].lower() for w in re.findall(r"[А-Яа-яІіЇїЄєҐґ'’]{2,}", s)}


# Журнал перевикористовує ID закляття під ІНШОЮ назвою: ID 1243002 стоїть у
# лінках «Fangs of the Crucible», «Fury of the War God» і «Dreadmarch», а spells
# має переклад лише однієї з них. Такий лінк лишаємо англійським — краще
# непереклад, ніж чужа назва. Сумісні: однакові слова з точністю до числа/регістру.
try:
    _src = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
except OSError:
    _src = {}


_anchor_path = DATA_DIR / "batches" / "spelllinks" / "_spell_anchor.json"
_anchor = json.loads(_anchor_path.read_text(encoding="utf-8")) if _anchor_path.exists() else {}


def src_en(sid):
    v = _src.get(sid)
    if isinstance(v, dict):
        n = v.get("name")
        e = n.get("en") if isinstance(n, dict) else (n if isinstance(n, str) else None)
        if e:
            return e
    # немає в джерелі — звіряємо з назвою, під яку _fill_spell_names_from_base.py
    # узяв переклад (інакше перевикористаний ID пропустив би чужу назву)
    return _anchor.get(sid)


def en_compatible(link_en, sid):
    s = src_en(sid)
    if not s:
        return True
    a = {w[:4].lower() for w in re.findall(r"[A-Za-z]{3,}", link_en)}
    b = {w[:4].lower() for w in re.findall(r"[A-Za-z]{3,}", s)}
    return bool(a & b)


kept_en = Counter()
queue = {}
for f in sorted(B.glob("sl_*.json")):
    for it in json.loads(f.read_text(encoding="utf-8")):
        queue[str(it["n"])] = it
index = json.loads((B / "_index.json").read_text(encoding="utf-8"))

answers = {}
for f in sorted(B.glob("out_sl_*.json")):
    try:
        d = json.loads(f.read_text(encoding="utf-8-sig"))
    except ValueError as e:
        print(f"ПОМИЛКА JSON {f.name}: {e}")
        continue
    for n, a in d.items():
        answers[str(n)] = a

ok, rej = 0, Counter()
subs_total = edits_total = 0
examples, rejects = [], []
for n, a in answers.items():
    it = queue.get(n)
    key = index.get(n)
    if not it or key is None:
        rej["n не з черги"] += 1
        continue
    cur = ba.get(key)
    if cur != it["text"]:
        rej["значення змінилося після підготовки"] += 1
        continue
    forms = a.get("links") if isinstance(a, dict) else None
    if not isinstance(forms, list) or len(forms) != len(it["links"]):
        rej["кількість форм ≠ лінкам"] += 1
        rejects.append((n, "кількість форм"))
        continue
    want = {}
    for j, l in enumerate(it["links"]):
        form = forms[j]
        # Код моделі в каноні («Ракетний залп X21-01A», «…9000-XL») — частина
        # назви. Промпт хвилі забороняв цифри й латиницю у формі, і агенти коди
        # зрізали; повертаємо код, якщо канон ним закінчується, а форма — ні.
        if isinstance(form, str):
            code = CODE.search(l["ua"])
            if code and code.group(0) not in form:
                form = form.rstrip() + " " + code.group(0)
        want[l["i"]] = (l, form)
    bad = None
    for l, form in want.values():
        lat_ok = isinstance(form, str) and all(t in l["ua"] for t in LAT.findall(form))
        if not isinstance(form, str) or not form.strip() or not CYR.search(form) \
                or not lat_ok or BAD_FORM.search(form):
            bad = f"хибна форма «{form}»"
            break
        # «Сон» → «Сну»: у коротких назвах відмінок вибиває голосну з кореня,
        # тож для назви з одного слова до 3 літер досить першої літери
        short = re.fullmatch(r"[А-Яа-яІіЇїЄєҐґ]{1,3}", l["ua"].strip())
        if short and form.strip()[:1].lower() == l["ua"].strip()[:1].lower():
            pass
        elif not (stems(form) & stems(l["ua"])):
            bad = f"форма «{form}» не з кореня «{l['ua']}»"
            break
    if bad:
        rej["хибна форма"] += 1
        rejects.append((n, bad))
        continue

    counter = [-1]

    def rep(m):
        counter[0] += 1
        hit = want.get(counter[0])
        if not hit:
            return m.group(0)
        if not en_compatible(hit[0]["en"], m.group(1)):
            kept_en[(m.group(1), hit[0]["en"], src_en(m.group(1)))] += 1
            return m.group(0)
        return "|Hspell:" + m.group(1) + "|h[" + hit[1].strip() + "]|h"

    new = LINK.sub(rep, cur)
    edits = a.get("edits") or []
    for e in edits:
        if not (isinstance(e, list) and len(e) == 2 and all(isinstance(x, str) for x in e)):
            bad = "правка не пара рядків"
            break
        old, nw = e
        if not old or len(old) > 60 or MARKUP.search(old) or MARKUP.search(nw) \
                or "[" in old or "]" in old:
            bad = f"правка зачіпає розмітку/задовга: «{old}»"
            break
        if new.count(old) != 1:
            bad = f"фрагмент «{old}» трапляється {new.count(old)} разів"
            break
        new = new.replace(old, nw)
    if bad:
        rej["правка відхилена"] += 1
        rejects.append((n, bad))
        continue
    if skeleton(new) != skeleton(cur):
        rej["розмітка/числа змінилися"] += 1
        rejects.append((n, "скелет"))
        continue
    ok += 1
    subs_total += len(want)
    edits_total += len(edits)
    if len(examples) < 8 and edits:
        examples.append((cur, new))
    if APPLY:
        ba[key] = new

print(f"відповідей: {len(answers)} з {len(queue)} | прийнято рядків: {ok} | "
      f"лінків: {subs_total} | правок узгодження: {edits_total}")
print("відхилено:", dict(rej))
print(f"лишено англ. (під тим самим ID інша назва): {sum(kept_en.values())} лінків, "
      f"{len(kept_en)} пар")
for (sid, le, se), c in list(kept_en.items())[:15]:
    print(f"   {sid}: лінк [{le}] / закляття [{se}] ×{c}")
for n, why in rejects[:25]:
    print(f"   n={n}: {why}")
for old, new in examples:
    print("\n  - " + old[:200].replace("\n", " ⏎ "))
    print("  + " + new[:200].replace("\n", " ⏎ "))
if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print("\ntranslations.json записано")
