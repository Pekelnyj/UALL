# -*- coding: utf-8 -*-
"""Злити хвилю «Опівніч»: імена істот і назви об'єктів світу.

ДВА РІЗНІ КЛЮЧІ, і плутати їх не можна [[sv-bucket-vs-section-key]]:
  • npcNames    — ключ це ID істоти. Хвиля віддає {англ: укр}, тож ID
    беремо з ДЖЕРЕЛА (creatures.json), а не з батча: у батчі немає пар,
    які зняла перехресна звірка. Одна англійська назва буває в кількох
    ID — тоді пишемо переклад усім.
  • gameObjects — ключ це САМА АНГЛІЙСЬКА НАЗВА, ID не потрібен.

Заслін як у хвилі гілок: ключ відповіді мусить бути серед ключів завдання.
Саме цього бракувало `_merge_uitt_wave.py`, коли хвиля приписала правильні
тіла ключам-сусідам [[kv-shift-substitution]].

Запуск: python _merge_midnight_wave.py <тека> [--apply]
   напр. python _merge_midnight_wave.py bfa --apply
Далі: python generate_db.py && python _check_kv_shift.py
"""
import io
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
CYR = re.compile("[Ѐ-ӿ]")
# Тека батчів — параметр: та сама механіка потрібна кожній добі, не лише
# Опівночі (bfa, df, cata…). Типове значення лишаємо для сумісності.
SUB = next((a for a in sys.argv[1:] if not a.startswith("--")), "midnight")
D = DATA_DIR / "batches" / SUB

P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))


def load_batches(prefix):
    """Ключі ЗАВДАННЯ — лише для заслону. ID сюди не мішаємо."""
    keys = set()
    for f in sorted(D.glob(f"{prefix}_[0-9]*.json")):
        for x in json.loads(f.read_text(encoding="utf-8-sig")):
            keys.add(x["en"])
    return keys


def source_ids(src):
    """англ. -> усі ID із ДЖЕРЕЛА (одна назва буває під кількома ID).

    Раніше ID бралися з батчів, а `asked` був defaultdict — тож для пари,
    якої в батчах немає (а такі є: `_xref_wave` вилучає знайдене з черги),
    звертання мовчки створювало ПОРОЖНІЙ список, і запис зникав у нікуди.
    162 готові пари так і не доїхали б до бази.
    """
    ids = defaultdict(list)
    d = json.loads((DATA_DIR / "source" / src).read_text(encoding="utf-8-sig"))
    for k, v in d.items():
        nm = v.get("name") if isinstance(v, dict) else None
        en = nm.get("en") if isinstance(nm, dict) else None
        if en:
            ids[en].append(k)
    return ids


def collect(prefix):
    out = {}
    for f in sorted(D.glob(f"out_{prefix}_*.json")):
        data = json.loads(f.read_text(encoding="utf-8-sig"))
        for en, ua in data.items():
            out.setdefault(en, (ua, f.name))
    return out


def upper_first(s):
    """Велика перша літера, решта недоторкана.

    У промпті хвилі я написав «описове ім'я — реченнєвим регістром» і дав
    приклад з малої. Це суперечить власній базі: у npcNames 39 135 імен з
    великої проти 313 з малої. П'ять батчів із одинадцяти пішли за хибним
    прикладом, тож 166 імен приїхали з малої. Чіпаємо ЛИШЕ перший символ —
    решту регістру перекладач вирішив свідомо (власні назви всередині).
    """
    return s[:1].upper() + s[1:] if s else s


def run(prefix, section, by_id, src=None):
    asked = load_batches(prefix)
    ids = source_ids(src) if by_id else None
    got = collect(prefix)
    sec = tr.setdefault(section, {})
    add = skip = alien = nocyr = 0
    pending = {}
    for en, (ua, fname) in got.items():
        # `out_*_xref.json` пише не перекладач, а _xref_wave.py: він бере
        # готову пару з БАЗИ і при цьому ВИЛУЧАЄ назву з батчів, щоб її не
        # перекладали вдруге. Отже її ключа в завданні немає за побудовою —
        # заслін тут спрацював би на власному ж інструменті.
        if en not in asked and not fname.endswith("_xref.json"):
            print(f"  ЧУЖИЙ КЛЮЧ [{fname}]: {en[:56]!r} -> {str(ua)[:44]!r}")
            alien += 1
            continue
        if not (isinstance(ua, str) and ua.strip() and CYR.search(ua)):
            print(f"  БЕЗ КИРИЛИЦІ [{fname}]: {en[:50]!r} -> {str(ua)[:40]!r}")
            nocyr += 1
            continue
        ua = upper_first(ua)
        keys = ids.get(en, []) if by_id else [en]
        if by_id and not keys:
            print(f"  НЕМА ID у джерелі: {en[:56]!r}")
            continue
        for k in keys:
            if sec.get(k) == ua:
                skip += 1
            else:
                pending[k] = ua
                add += 1

    left = sorted(set(asked) - set(got))
    print(f"\n{section}: у завданні {len(asked)} | відповідей {len(got)} | "
          f"до запису {add} | без змін {skip} | чужих {alien} | "
          f"без кирилиці {nocyr} | ще не перекладено {len(left)}")
    for m in left[:10]:
        print("    лишилось:", m[:60])
    if APPLY:
        sec.update(pending)
    return len(pending)


n1 = run("npc", "npcNames", by_id=True, src="creatures.json")
n2 = run("gobj", "gameObjects", by_id=False)

if APPLY:
    io.open(P, "w", encoding="utf-8", newline="\n").write(
        json.dumps(tr, ensure_ascii=False, indent=1))
    print(f"\nзаписано: істот {n1}, об'єктів {n2}")
else:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
