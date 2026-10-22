# -*- coding: utf-8 -*-
"""Розкласти вихід _extract_uitt.py у батчі, відсіявши рантайм.

_extract_uitt.py віддає плаский список у tester_all/uitt.json і має власний
короткий фільтр JUNK. Цього замало: у db.uitooltip осідають лічильники цілей,
таймери й суми — рядки, що ніколи не стануть ключем бази (capfilter.py).

-> data/batches/uitooltip/ut_NN.json  [англ. рядок, ...]
Далі: _xref_wave.py uitooltip ut --apply  (зняти те, що вже перекладено)
"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
import capfilter
from playernames import nick_regex

SIZE = int(sys.argv[1]) if len(sys.argv) > 1 else 25
src = json.loads((DATA_DIR / "tester_all" / "uitt.json").read_text(encoding="utf-8"))
# у db.uitooltip осідають і самі ніки гравців (наведення на іншого гравця) —
# у базі їм не місце [[player-name-leak-gate]]
NICK = nick_regex(min_len=4)
# Нік буває не лише окремим рядком, а й УСЕРЕДИНІ: «Predator <нік> (Title)» —
# звання гравця з його ім'ям. Такий ключ мертвий для всіх, крім одного, і
# водночас витік [[player-name-leak-gate]]. Гейт його ловить уже після злиття —
# дешевше не пускати в чергу взагалі.
src = [s for s in src if not NICK.search(s)]

# Наведення на іншого гравця дає в db.uitooltip ГОЛЕ ім'я одним словом. Списком
# ніків їх не покриєш — гравців тисячі. Доказ той самий, що й у гейті ніків:
# якщо слово не трапляється в жодному імені NPC (creatures.json) і його немає
# як ключа в базі, це не ігровий рядок, а чийсь нік.
import re as _re
_tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
_known = {k for d in _tr.values() if isinstance(d, dict)
          for k in d if isinstance(k, str)}
_crea = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
_npc_words = set()
for _v in (_crea.values() if isinstance(_crea, dict) else _crea):
    if not isinstance(_v, dict):
        continue
    _nm = _v.get("name") if isinstance(_v.get("name"), dict) else _v
    _en = _nm.get("en") if isinstance(_nm, dict) else None
    if _en:
        _npc_words |= set(_re.findall(r"[A-Za-zÀ-ÿ']{3,}", _en))
_SOLO = _re.compile(r"[A-ZÀ-Þ][A-Za-zÀ-ÿ']{2,}")

# Дедуп проти БАЗИ робить лише _extract_uitt.py, і робить його один раз. Якщо
# після витягу щось уже злито (а між порціями хвилі це щоразу так), ці рядки
# поверталися в чергу як «нові» й ішли на повторний переклад.
_ui = _tr.get("uiTooltips", {})
_dup = len(src)
src = [s for s in src if s not in _ui]
if _dup != len(src):
    print(f"  знято вже перекладеного: {_dup - len(src)}")

_before = len(src)
src = [s for s in src
       if not (_SOLO.fullmatch(s.strip())
               and s.strip() not in _npc_words and s not in _known)]
if _before != len(src):
    print(f"  відсіяно голих імен гравців (без NPC-якоря): {_before - len(src)}")
good, dropped = capfilter.split(src)
print(f"uitooltip: {len(src)}")
capfilter.report(dropped)

BD = DATA_DIR / "batches" / "uitooltip"
BD.mkdir(parents=True, exist_ok=True)
for f in BD.glob("ut_*.json"):
    f.unlink()
for k in range((len(good) + SIZE - 1) // SIZE):
    (BD / f"ut_{k:02d}.json").write_text(
        json.dumps(good[k * SIZE:(k + 1) * SIZE], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"-> батчів {(len(good) + SIZE - 1) // SIZE} | у черзі {len(good)}")
