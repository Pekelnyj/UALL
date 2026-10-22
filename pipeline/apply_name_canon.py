"""Детермінстичний канон-QA для перекладених НАЗВ предметів (і флейворів).

Машинно нав'язує канонічні власні назви замість описових кальок, що їх
зрідка вигадують агенти. Не залежить від агента — як ручні фікси, тільки
автоматом і повторювано. Запускати ПІСЛЯ merge, ПЕРЕД generate_db.

Використання: python apply_name_canon.py
"""

import json
import re

from common import DATA_DIR

# Форми калька -> канон (довші першими, щоб не зачепити коротші).
REPLACEMENTS = [
    # Silvermoon -> Сільвермун (усталено в базі)
    ("Срібномісяччі", "Сільвермуні"),
    ("Срібномісяччя", "Сільвермун"),
    ("Срібномісячний", "Сільвермунський"),
    ("Срібномісті", "Сільвермуні"),
    ("Срібномістя", "Сільвермуна"),
    # Особи (транслітерація за каноном)
    ("Пеклокрику", "Геллскріму"), ("Пеклокрика", "Геллскріма"), ("Пеклокрик", "Геллскрім"),
    ("Бронзобородів", "Бронзбірдів"), ("Бронзоборода", "Бронзбірда"), ("Бронзобород", "Бронзбірд"),
    ("Вітрогонів", "Віндраннерів"), ("Вітрогін", "Віндраннер"),
]
# Wrathion: «Ратіон» без В на початку слова -> «Вратіон».
RATION = re.compile(r"(?<![А-Яа-яІіЇїЄєҐґA-Za-z'])Ратіон")


def fix(text):
    if not text:
        return text
    for a, b in REPLACEMENTS:
        text = text.replace(a, b)
    text = RATION.sub("Вратіон", text)
    return text


def main():
    p = DATA_DIR / "translations.json"
    tr = json.loads(p.read_text(encoding="utf-8-sig"))
    total = 0
    for key in ("itemNames", "itemFlavors", "currencies", "gossip", "broadcast"):
        d = tr.get(key)
        if not isinstance(d, dict):
            continue
        for k, v in list(d.items()):
            if isinstance(v, str):
                nv = fix(v)
                if nv != v:
                    d[k] = nv
                    total += 1
            elif isinstance(v, dict):  # currencies {name, desc}
                for f in ("name", "desc"):
                    if isinstance(v.get(f), str):
                        nv = fix(v[f])
                        if nv != v[f]:
                            v[f] = nv
                            total += 1
    p.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"Канон-QA: виправлено {total} записів.")


if __name__ == "__main__":
    main()
