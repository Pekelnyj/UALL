# -*- coding: utf-8 -*-
"""Скан КВЕСТІВ на описові епітети-дрейфи (мають бути транслітерацією).
Витягує входження з EN-контекстом (title+description) — щоб агент розрізнив
особу (Garrosh Hellscream→Геллскрім), фракцію (Hellscream's Reach), буквальне."""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
src = json.loads((DATA_DIR / "source" / "quests.json").read_text(encoding="utf-8-sig"))

# описові форми, які НЕ мають бути в перекладі (дрейф від транслітерації)
FORMS = {
    "Hellscream": ["Пеклокрик", "Пекельнокрик", "Пекельний Крик", "Пеклокрику",
                   "Пеклокрика", "Пеклокриком", "Пеклокрикові"],
    "Doomhammer": ["Молот Долі", "Молот Судьби", "Молот Фатуму", "Фатумомолот"],
    "Bloodhoof":  ["Кровокопит", "Кривавокопит", "Кровокопито"],
    "Blackhand":  ["Чорнорук", "Чорнору"],
    "Bladefist":  ["Клинкокулак", "Лезокулак", "Клинокулак"],
    "Sunstrider": ["Сонцеступ"],
    "Windrunner": ["Вітрогін", "Вітробіг", "Вітрогона", "Вітрогону"],
    "Stormrage":  ["Лютошторм", "Штормолют"],
    "Whisperwind":["Шепіт Вітру", "Шепотіння Вітру", "Шепітвітру"],
    "Bronzebeard":["Бронзоборід", "Бронзобородь", "Бронзобород"],
    "Shadowsong": ["Тіньоспів", "Тіньопісня"],
    "Deathwing":  ["Смертокрил", "Смертокрила"],
    "Grimtotem":  ["Похмуротот", "Похмурий Тотем"],
    "Ragetotem":  ["Лютотот", "Тотем Люті"],
    "Ravencrest": ["Воронячий Гребінь", "Вороногерб"],
    "Greymane":   ["Сивогрив", "Сірогрив"],
    "Proudmoore": ["Гордомор", "Гордовир"],
    "Bloodfury":  ["Кровожер", "Кривава Лють"],
    "Wrynn":      ["Гнівень"],
    "Saurfang":   ["Зауроклик", "Ящероклик"],
}
allforms = []
for canon, fs in FORMS.items():
    for f in fs:
        allforms.append((f, canon))
rx = re.compile("|".join(re.escape(f) for f, _ in allforms))

qt = tr.get("quests", {})
out = []
for qid, v in qt.items():
    if not isinstance(v, dict):
        continue
    for sub in ("title", "description", "objectives", "progress", "completion"):
        txt = v.get(sub)
        if isinstance(txt, str) and rx.search(txt):
            s = src.get(qid, {})
            en_t = (s.get("title") or {}).get("en", "")
            en_d = (s.get("description") or {}).get("en", "")
            hits = sorted(set(m.group(0) for m in rx.finditer(txt)))
            out.append({
                "qid": qid, "field": sub, "hits": hits,
                "ua": txt,
                "en_title": en_t,
                "en_desc": en_d[:600],
            })

json.dump(out, open(DATA_DIR / "_quest_epithet_in.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
# зведення по формах
from collections import Counter
c = Counter()
for o in out:
    for h in o["hits"]:
        c[h] += 1
print(f"квест-входжень: {len(out)}")
for form, n in c.most_common():
    print(f"  {form}: {n}")
