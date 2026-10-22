# -*- coding: utf-8 -*-
"""Черга неперекладених КВЕСТІВ, згрупована ГІЛКАМИ.

Чому гілками, а не поспіль за ID: гілка — це те, що гравець читає підряд,
і саме в її межах ім'я мусить звучати однаково. Коли завдання однієї
сюжетної лінії розповзаються по різних порціях і різних перекладачах,
народжується той самий різнобій, який ми потім вичищаємо
[[questline-context-method]].

До кожної порції додаємо ВЖЕ ПЕРЕКЛАДЕНІ завдання тієї ж гілки — як якір
канону: перекладач бачить, як тут уже названо персонажів і місця.

Відсів: службові рядки розробників. У квестах їх особливо багато —
«[DNT] QUEST NOT USED», «[PH] Go Home», «TEST», «DEPRECATED»: у гру вони
не потрапляють, а в базі стають сміттям [[no-overclaiming-coverage]].

-> data/batches/quests/q_NN.json
Далі: переклад -> out_q_NN.json -> _merge_quest_wave.py

Запуск: python _prep_quest_wave.py [гілок_на_батч] [--report]
"""
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

SIZE = int(sys.argv[1]) if len(sys.argv) > 1 and sys.argv[1].isdigit() else 3
REPORT = "--report" in sys.argv
MAX_ANCHOR = 6      # скільки перекладених сусідів класти для канону

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
src = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))
ql = json.loads((DATA_DIR / "questlines.json").read_text(encoding="utf-8-sig"))
tq = tr.get("quests", {})

DEV = re.compile(
    r"[\[(]?\b(?:DNT|PH|TEST|UNUSED|DEPRECATED|OLD|TEMP)\b[\])]?"
    r"|\bDO ?NOT ?USE\b|\bNOT USED\b|\bPlaceholder\b"
    r"|\bHIDDEN QUEST\b|\bTracking Quest\b"
    r"|^\d+\.\d"
    r"|^\W*$", re.I)
# Внутрішні кошики рівнів: «Dragonflight (70) E», «BFA 120 E»,
# «The War Within (70-79) E». Гравець їх не бачить ніколи — це службова
# розбивка кампаній за рівнями, і саме вона складала 391 із 400
# «неперекладених» завдань.
BRACKET = re.compile(
    r"^(?:Dragonflight|Midnight|The War Within|Shadowlands|BFA|BfA|Legion|"
    r"WoD|MoP|Cata|Cataclysm|TBC|Classic|Vanilla|Warlords|Pandaria)\b"
    r"[\s\d()–—-]*(?:[EH])?$")


def en_of(v, fld):
    x = v.get(fld) if isinstance(v, dict) else None
    return x.get("en") if isinstance(x, dict) else (x if isinstance(x, str) else "")


# завдання -> гілка
q2ql = {}
for qlid, v in ql.items():
    nm = v.get("name") if isinstance(v, dict) else None
    name = nm.get("en") if isinstance(nm, dict) else None
    for q in (v.get("quests") or []):
        q2ql.setdefault(str(q), name or "")

miss = defaultdict(list)
dev = orphan = 0
for k, v in src.items():
    if not isinstance(v, dict):
        continue
    t, d = en_of(v, "title"), en_of(v, "description")
    if not (t or d):
        continue
    u = tq.get(str(k))
    if isinstance(u, dict) and (u.get("title") or u.get("description")):
        continue
    # Найнадійніша ознака справжнього завдання — ОПИС. Blizzard дає його
    # всьому, що гравець бачить; службові записи («zz», «reuse me»,
    # «Useless quest record», «LFGDungeons - …») йдуть без опису або з
    # огризком. Саме цей критерій відсіяв 108 із 122, які пережили
    # текстові маски.
    # Мітку розробника шукаємо і в ОПИСІ, не лише в назві. Blizzard ставить
    # її на початку тіла: «[PH] Shoot a marked target.», а найвідвертіше —
    # «[Test Quest - Do Not Translate]». Поки перевірялася сама назва, всі
    # 11 таких завдань виглядали справжніми й поїхали були на переклад.
    if (DEV.search(t or "") or DEV.search(d[:64])
            or BRACKET.match((t or "").strip()) or len(d) < 20):
        dev += 1
        continue
    line = q2ql.get(str(k))
    if not line:
        orphan += 1
        line = "(поза гілками)"
    miss[line].append({"id": str(k), "en_title": t, "en_desc": d,
                       "de_title": (v.get("title") or {}).get("de", ""),
                       "fr_title": (v.get("title") or {}).get("fr", "")})

total = sum(len(v) for v in miss.values())
print(f"без перекладу: {total + dev} | службових відсіяно: {dev} | "
      f"НА ПЕРЕКЛАД {total} у {len(miss)} гілках (поза гілками: {orphan})")

rows = []
for line, items in sorted(miss.items(), key=lambda x: -len(x[1])):
    # якорі канону: вже перекладені завдання тієї самої гілки
    anchors = []
    for qlid, v in ql.items():
        nm = v.get("name") if isinstance(v, dict) else None
        if (nm.get("en") if isinstance(nm, dict) else None) != line:
            continue
        for q in (v.get("quests") or []):
            u = tq.get(str(q))
            if isinstance(u, dict) and u.get("title"):
                anchors.append(u["title"])
        break
    rows.append({"questline": line,
                 "ua_questline": tr.get("questLines", {}).get(line, ""),
                 "anchors": anchors[:MAX_ANCHOR],
                 "quests": items})

if REPORT:
    for r in rows[:20]:
        print(f"\n  {r['questline']} — {len(r['quests'])} завдань"
              f"{' | якорі: ' + ', '.join(r['anchors'][:3]) if r['anchors'] else ''}")
        for q in r["quests"][:3]:
            print(f"      {q['id']}  {q['en_title'][:56]}")
    sys.exit()

d = DATA_DIR / "batches" / "quests"
d.mkdir(parents=True, exist_ok=True)
for f in d.glob("q_*.json"):
    f.unlink()
n = (len(rows) + SIZE - 1) // SIZE
for k in range(n):
    (d / f"q_{k:02d}.json").write_text(
        json.dumps(rows[k * SIZE:(k + 1) * SIZE], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"-> батчів {n} по {SIZE} гілок у {d}")
