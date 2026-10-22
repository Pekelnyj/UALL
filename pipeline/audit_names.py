"""EN-якірний аудит транслітерації імен у квестах.

Ідея: у нас є англійське джерело кожного квесту (data/source/quests.json) і
канонічна карта прізвищ EN->UA (gen_name_forms.py). Якщо в EN-тексті квесту
є лорне прізвище (Hellscream, Windrunner...), а в українському перекладі
НЕМАЄ його транслітерації (Геллскрім, Віндраннер...) — це прапорець:
або пролізла описова калька («Пеклокрик»), або взагалі не транслітеровано.

УВАГА: частина прапорців — легітимні (клан/місце описово: «клан Дикомолотів»
для Wildhammer). Тому це СПИСОК КАНДИДАТІВ на ревʼю, а не готові помилки.
Зате він повний і обмежений (замість 29k — кілька сотень).

Вивід: зведення в консоль + data/name_audit.json (повний список для агентів).
"""

import io
import json
import re
import sys
from collections import defaultdict

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

ROOT = __file__.rsplit("pipeline", 1)[0]
TR = json.loads(open(ROOT + "data/translations.json", "rb").read().decode("utf-8-sig"))
SRC = json.loads(open(ROOT + "data/source/quests.json", "rb").read().decode("utf-8-sig"))

# EN-прізвище -> множина прийнятних UA-форм (із канонічної карти)
gen = open(ROOT + "pipeline/gen_name_forms.py", "rb").read().decode("utf-8")
m = re.search(r"NAME_STEMS\s*=\s*\{(.*?)\n\}", gen, re.S)
pairs = re.findall(r'"([^"]+)"\s*:\s*"([^"]+)"', m.group(1))
en2ua = defaultdict(set)
for ua, en in pairs:
    en2ua[en].add(ua)

# EN-ім'я лише як ЦІЛЕ слово (інакше "Southern"->Uther, "Magnificent"->Magni).
en_re = {en: re.compile(r"(?<![A-Za-z])" + re.escape(en) + r"(?![A-Za-z])", re.I)
         for en in en2ua}

quests = TR.get("quests", {})
UA_FIELDS = ["title", "description", "objectives", "progress", "completion"]

flags = []  # {qid, en_name, ua_forms, title_ua, title_en}
per_name = defaultdict(int)

for qid, ua_entry in quests.items():
    s = SRC.get(qid)
    if not s:
        continue
    en_text = " ".join(
        (s.get(f, {}) or {}).get("en", "") for f in ("title", "description")
    )
    if not en_text:
        continue
    ua_text = " ".join(v for v in (ua_entry.get(f) for f in UA_FIELDS) if isinstance(v, str))
    ul = ua_text.lower()
    for en_name, ua_forms in en2ua.items():
        if en_re[en_name].search(en_text):
            # чи є хоч одна прийнятна UA-форма (транслітерація)?
            if not any(f.lower() in ul for f in ua_forms):
                # також не вважати помилкою, якщо лишили англійський оригінал
                if en_name.lower() in ul:
                    continue
                flags.append({
                    "qid": qid,
                    "en_name": en_name,
                    "ua_forms": sorted(ua_forms),
                    "title_en": (s.get("title", {}) or {}).get("en", ""),
                    "title_ua": ua_entry.get("title", ""),
                })
                per_name[en_name] += 1

flags.sort(key=lambda x: (x["en_name"], int(x["qid"])))
json.dump(flags, open(ROOT + "data/name_audit.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)

print(f"Квестів з EN-джерелом: {sum(1 for q in quests if q in SRC)}")
print(f"ПРАПОРЦІВ (EN-прізвище є, UA-транслітерації нема): {len(flags)}")
print("--- за іменем (кандидати на ревʼю: особа=виправити, клан/місце=ок) ---")
for en_name in sorted(per_name, key=lambda n: -per_name[n]):
    print(f"  {en_name:14} {per_name[en_name]:4}")
print(f"\nПовний список -> data/name_audit.json")
