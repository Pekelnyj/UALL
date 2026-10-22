# -*- coding: utf-8 -*-
"""Гейт: зламані українські слова — латиниця всередині, огризки, русизми.

Це вади, яким не потрібен вирок: рядок не «інакше перекладено», а просто
несправний. Два роди, і змішувати їх не можна:

  [A] ЛАТИНИЦЯ ВСЕРЕДИНІ КИРИЛИЧНОГО СЛОВА — «вiперид» (латинська i),
      «Мoгу», «крокіліскiв». У грі це виглядає як звичайне слово, тож
      очима не ловиться, а пошук по базі за таким словом не працює.
      Причина завжди та сама: набір із перемиканням розкладки. Виправно.

  [B] ІМ'Я, ЩО ЛИШИЛОСЯ ЛАТИНИЦЕЮ ЦІЛКОМ — «L'ura», «Z'rali». Це не
      одрук, а неперекладена назва, і сліпа заміна дала б каліцтво
      «Л'ura». Тільки показуємо.

Тому [A] шукаємо ЛИШЕ там, де латинська літера оточена кирилицею з обох
боків: на краю слова цей доказ не працює.

Запуск: python _check_broken_words.py [--fix-latin]
        (--fix-latin міняє ЛИШЕ латинські двійники на кириличні:
         a e i o p c x y A E I O P C X Y H K M T B — решту не чіпає)
"""
import io
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

FIX = "--fix-latin" in sys.argv

# Латинські літери, що мають однаковий вигляд із кириличними.
TWINS = {"a": "а", "e": "е", "i": "і", "o": "о", "p": "р", "c": "с",
         "x": "х", "y": "у", "A": "А", "E": "Е", "I": "І", "O": "О",
         "P": "Р", "C": "С", "X": "Х", "Y": "У", "H": "Н", "K": "К",
         "M": "М", "T": "Т", "B": "В"}
# Латиниця З ДІАКРИТИКОЮ — окремий рід тієї самої вади, і саме його
# перша версія гейта не бачила, бо шукала лише діапазон [A-Za-z].
# У базі знайшлося 30 таких: «твóрите», «сíм'я», «Циркóновий», «Лускáта».
# Наголос тут не смисловий — це слід набору, тож зводимо до звичайної літери.
TWINS.update({"á": "а", "à": "а", "â": "а", "ä": "а",
              "é": "е", "è": "е", "ê": "е", "ë": "е",
              "í": "і", "ì": "і", "î": "і", "ï": "і",
              "ó": "о", "ò": "о", "ô": "о", "ö": "о",
              "ú": "у", "ù": "у", "û": "у", "ü": "у", "ý": "у",
              "Á": "А", "É": "Е", "Í": "І", "Ó": "О", "Ú": "У"})
LAT = "A-Za-zÀ-ɏ"
CYR = "А-ЯІЇЄҐа-яіїєґ'’"
# Латинська літера, оточена кирилицею З ОБОХ БОКІВ. Тільки цей випадок
# однозначний. Літера на КРАЮ слова — інша хвороба: «L'ura», «Z'rali» це
# імена, що лишилися латиницею цілком, і заміна дала б каліцтво «Л'ura».
# Їх показуємо окремо й не чіпаємо.
MIXED = re.compile(rf"(?<=[{CYR}])([{LAT}])(?=[{CYR}])")
LATIN_NAME = re.compile(rf"(?<![{LAT}])[A-Z][a-z]*['’][a-z]+|"
                        rf"^[A-Za-z]{{3,}}(?=\s+[{CYR}])")


def ua_of(v):
    if isinstance(v, str):
        return v
    if isinstance(v, dict):
        for f in ("name", "title", "text", "ua", "value", "description"):
            x = v.get(f)
            if isinstance(x, str) and x.strip():
                return x
    return ""


def walk(tr):
    for sec, d in tr.items():
        if not isinstance(d, dict):
            continue
        for k, v in d.items():
            if isinstance(v, str):
                yield sec, k, None, v
            elif isinstance(v, dict):
                for f, x in v.items():
                    if isinstance(x, str):
                        yield sec, k, f, x


P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))

latin, spaces = [], []
words = Counter()
for sec, k, fld, s in walk(tr):
    if not re.search(rf"[{CYR}]", s):
        continue
    m = MIXED.search(s)
    if m:
        latin.append((sec, k, fld, s, m.group(1), m.start()))
        words[m.group(1)] += 1
    else:
        mn = LATIN_NAME.search(s)
        if mn:
            spaces.append((sec, k, fld, mn.group(0), s))

print(f"[A] латиниця всередині кириличного слова: {len(latin)}")
if words:
    print("    які саме літери:",
          ", ".join(f"{c}×{n}" for c, n in words.most_common(10)))
for sec, k, fld, s, ch, pos in latin[:20]:
    frag = s[max(0, pos - 22):pos + 22]
    print(f"    [{sec}] {str(k)[:34]!r} …{frag}… (латинська {ch!r})")
if len(latin) > 20:
    print(f"    …ще {len(latin) - 20}")

print(f"\n[B] ім'я лишилося латиницею (НЕ чіпаю — це не одрук): {len(spaces)}")
for sec, k, fld, name, s in spaces[:10]:
    print(f"    [{sec}] {str(k)[:30]!r} {name!r} у {s[:44]!r}")
if len(spaces) > 10:
    print(f"    …ще {len(spaces) - 10}")

if FIX and latin:
    n = 0
    for sec, k, fld, s, _ch, _pos in latin:
        new = MIXED.sub(lambda m: TWINS.get(m.group(0), m.group(0)), s)
        # заміняємо лише те, для чого є кириличний двійник
        if new == s:
            continue
        d = tr[sec]
        if fld is None:
            d[k] = new
        else:
            d[k][fld] = new
        n += 1
    io.open(P, "w", encoding="utf-8", newline="\n").write(
        json.dumps(tr, ensure_ascii=False, indent=1))
    print(f"\nвиправлено рядків: {n}")
elif latin:
    print("\n(звіт; щоб замінити латинські двійники — --fix-latin)")

sys.exit(1 if latin else 0)
