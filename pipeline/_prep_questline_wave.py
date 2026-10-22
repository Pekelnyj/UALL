# -*- coding: utf-8 -*-
"""Черга на переклад НАЗВ ГІЛОК квестів (questlines).

Гілка — це заголовок над групою завдань у журналі й на мапі. Назва коротка
й тому оманлива: «Nightfall», «Gorefiend», «The Iron Approach» самі по собі
не кажуть ні про що йдеться, ні якого роду персонаж у назві. Тому в батч
кладемо не голий рядок, а контекст:

  • німецьку й французьку назви — вони знімають рід і число
    (die Magierin = жінка), як велить порядок перекладу;
  • НАЗВИ ЗАВДАНЬ цієї ж гілки, ВЖЕ ПЕРЕКЛАДЕНІ. Це головне: якщо в гілці
    вже є «Ґорфієнд» у назві квесту, то й гілка мусить бути «Ґорфієнд», а
    не «Кровогуб». Саме так утворювався різнобій, коли назву перекладали
    без гілки [[questline-context-method]], [[name-consistency-gate]].

Ключ секції questLines — АНГЛІЙСЬКА НАЗВА, не ID [[sv-bucket-vs-section-key]],
тож і дедуп, і злиття йдуть за назвою: у джерелі той самий рядок трапляється
під кількома ID («The Iron Approach» двічі).

-> data/batches/questlines/ql_NN.json
Далі: переклад -> out_ql_NN.json {англ: укр} -> _merge_questline_wave.py

Запуск: python _prep_questline_wave.py [розмір_батча]
"""
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import nick_regex

SIZE = int(sys.argv[1]) if len(sys.argv) > 1 else 25
MAX_CTX = 8          # скільки назв завдань класти для контексту

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
ql = json.loads((DATA_DIR / "questlines.json").read_text(encoding="utf-8-sig"))
done = tr.get("questLines", {})
quests = tr.get("quests", {})
NICK = nick_regex(min_len=4)

# Заглушки розробників. Мітка DNT стоїть де завгодно — і на початку в
# дужках «(DNT) Campaign», і в хвості «10.0 Faction Swap Protection [DNT]»,
# — тож прив'язка до початку рядка їх пропускала. Версійний префікс
# («10.2.6 Upgrade System Tutorial») — теж внутрішня назва патча.
DEV = re.compile(r"[\[(]?\b(?:DNT|PH|TEST|UNUSED|DEPRECATED)\b[\])]?"
                 r"|\b(?:DO ?NOT ?USE|Placeholder)\b"
                 r"|^\d+\.\d"
                 r"|^\W*$", re.I)


def untouched(x):
    """Blizzard не переклала назву жодною мовою — отже, гравцеві її не видно.

    Сам собою доказ не остаточний: власне ім'я («Gorefiend») законно
    збігається в усіх трьох мовах. Тому це не фільтр, а лише позначка в
    батчі — хай перекладач бачить, що орієнтуватися на de/fr тут нема на що.
    """
    return bool(x["de"]) and x["de"] == x["en"] and x["fr"] == x["en"]


def ua_title(qid):
    q = quests.get(str(qid))
    if isinstance(q, dict):
        t = q.get("title")
        if isinstance(t, str) and t.strip():
            return t
    return None


seen, out = set(), []
dev = nick = dup = 0
for qlid, v in ql.items():
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if not en or done.get(en):
        continue
    if en in seen:
        dup += 1
        continue
    seen.add(en)
    if DEV.search(en):
        dev += 1
        continue
    if NICK.search(en):
        nick += 1
        continue
    ctx = [t for t in (ua_title(q) for q in (v.get("quests") or [])) if t]
    out.append({
        "id": qlid,
        "en": en,
        "de": nm.get("de") or "",
        "fr": nm.get("fr") or "",
        "quests_ua": ctx[:MAX_CTX],
    })

for x in out:
    if untouched(x):
        x["note"] = "Blizzard не переклала ні de, ні fr — орієнтуйся на квести"

out.sort(key=lambda x: x["en"])
no_ctx = sum(1 for x in out if not x["quests_ua"])
raw = sum(1 for x in out if "note" in x)
print(f"Гілки: у джерелі {len(ql)} | перекладено {len(done)} | "
      f"дублікатів назви {dup} | заглушок {dev} | ніків {nick}")
print(f"НА ПЕРЕКЛАД {len(out)}  (без контексту-завдань {no_ctx} | "
      f"без de/fr-орієнтира {raw})")

d = DATA_DIR / "batches" / "questlines"
d.mkdir(parents=True, exist_ok=True)
for f in d.glob("ql_*.json"):
    f.unlink()
n = (len(out) + SIZE - 1) // SIZE
for k in range(n):
    (d / f"ql_{k:02d}.json").write_text(
        json.dumps(out[k * SIZE:(k + 1) * SIZE], ensure_ascii=False, indent=1),
        encoding="utf-8")
print(f"-> батчів {n} по {SIZE} у {d}")
