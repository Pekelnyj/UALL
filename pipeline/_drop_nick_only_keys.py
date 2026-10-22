# -*- coding: utf-8 -*-
"""Зняти ключі, які ЦІЛКОМ є іменем гравця.

Підказка при наведенні на іншого гравця дає голе ім'я, і збирач кладе його
як звичайний рядок. Такий ключ не лише витік [[guild-names-never-translate]],
а й мертвий: він спрацює рівно в однієї людини.

Ім'я беремо з playernames.known_nicks — там і meta.playerName, і збір за
системними рядками «Ім'я-Реалм has left the instance group».

Запуск: python _drop_nick_only_keys.py [--apply]
Далі:   python generate_db.py
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import known_nicks

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
nicks = known_nicks(min_len=4, drop_ambiguous=True)

# ЗАСЛІН ДАТАМАЙНОМ. Збіг із ніком сам по собі нічого не доводить: серед
# тисяч гравців хтось назвався як предмет чи здібність. «Cryptmaker» — це
# зброя, «Inked» — риса послідовника, «Brandolf» — гілка завдань; усі троє
# потрапили в чернетку саме так. Якщо назва є в ДЖЕРЕЛІ, це ігровий контент
# [[verify-names-by-id-anchor]].
GAME = set()
for _f, _field in (("items.json", "name"), ("creatures.json", "name"),
                   ("spells.json", "name"), ("gameobjects.json", "name"),
                   ("achievements.json", "title")):
    _p = DATA_DIR / "source" / _f
    if not _p.exists():
        continue
    try:
        _d = json.loads(_p.read_text(encoding="utf-8-sig"))
    except (OSError, ValueError):
        continue
    for _v in (_d.values() if isinstance(_d, dict) else _d):
        if isinstance(_v, str):
            GAME.add(_v.strip())
        elif isinstance(_v, dict):
            _n = _v.get(_field)
            _en = _n.get("en") if isinstance(_n, dict) else _n
            if isinstance(_en, str):
                GAME.add(_en.strip())
print(f"назв у джерелах датамайну: {len(GAME)}")

# ТІЛЬКИ ТІ СЕКЦІЇ, куди голе ім'я взагалі може потрапити. Механізм один:
# гравець наводить курсор на іншого гравця — і в підказці стоїть саме голе
# ім'я. У секціях, що живляться з датамайну, голе слово має інше походження:
# «Brandolf» — гілка завдань, «Inked» — риса послідовника гарнізону. Обидва
# були в чернетці, поки заслоном служило лише джерело [[sv-bucket-vs-section-key]].
HOVER_SECTIONS = {"uiTooltips", "subnames", "npcNames"}

drop, kept_game, kept_sec = [], [], []
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    if sec not in HOVER_SECTIONS:
        kept_sec += [(sec, k) for k in d
                     if isinstance(k, str) and k.strip() in nicks]
        continue
    for k in list(d):
        if isinstance(k, str) and k.strip() in nicks:
            if k.strip() in GAME:
                kept_game.append((sec, k))
                continue
            drop.append((sec, k))
if kept_sec:
    print(f"поза hover-секціями (не чіпаємо): {len(kept_sec)} -> "
          f"{[f'{s}/{k}' for s, k in kept_sec[:6]]}")
if kept_game:
    print(f"лишено як ігровий контент: {len(kept_game)} -> "
          f"{[f'{s}/{k}' for s, k in kept_game[:6]]}")

print(f"ключів, що цілком є ніком: {len(drop)}")
for sec, k in drop:
    v = tr[sec][k]
    ua = v if isinstance(v, str) else (v.get("ua") if isinstance(v, dict) else "")
    print(f"  [{sec}] «{k}» -> «{ua}»")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
for sec, k in drop:
    tr[sec].pop(k, None)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print(f"\nзнято {len(drop)}")
