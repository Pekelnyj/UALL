# -*- coding: utf-8 -*-
"""Полагодити токени, які завалює _check_gender_tokens.py.

Перетворення: «забув$p(:ла)» -> «$p(забув:забула)», «грав$p(ся:лася)» ->
«$p(грався:гралася)». Жіноча форма = слово без кінцевого «в» + жіноча гілка.

Неправильні дієслова (де «в» чергується з голосною: ріс/росла) НЕ чіпаємо —
для них правило не працює, скрипт їх лише перелічує.

Broadcast чіпаємо ЛИШЕ через _update_broadcast_values.py [never-regex-edit-
broadcast-lua]: тут для нього готується окремий json.

Запуск: python _fix_gender_tokens.py [--apply]
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
RX = re.compile(r"([А-Яа-яЇїІіЄєҐґ']*[бвгґджзклмнпрстфхцчшщ])"
                r"\$p\((|ся):(л[^():]*)\)", re.I)

# Неправильні: чоловіча форма без «-в», жіноча з чергуванням у корені.
# Виводиться не з правила, а зі словника — тому тримаємо явний перелік.
IRREGULAR = {
    "зміг": "змогл", "міг": "могл", "ріс": "росл", "виріс": "виросл",
    "ліг": "лягл", "допоміг": "допомогл", "втік": "втекл", "знайшов": "знайшл",
}

fixed_n = skipped = 0
manual = []


def repair(text):
    global fixed_n, skipped

    def sub(m):
        global fixed_n, skipped
        word, masc_tail, fem_tail = m.group(1), m.group(2), m.group(3)
        low = word.lower()
        if low in IRREGULAR:
            stem = IRREGULAR[low]
            if word[:1].isupper():
                stem = stem[:1].upper() + stem[1:]
            fixed_n += 1
            # жіноча гілка вже несе «л», а в основі чергування воно теж є
            return f"$p({word}{masc_tail}:{stem}{fem_tail[1:]})"
        if not low.endswith("в"):
            manual.append(m.group(0))
            skipped += 1
            return m.group(0)
        fixed_n += 1
        return f"$p({word}{masc_tail}:{word[:-1]}{fem_tail})"

    return RX.sub(sub, text)


TR = DATA_DIR / "translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
bc_updates = {}
changed = 0


def walk(o, sec=None, key=None):
    global changed
    if isinstance(o, dict):
        return {k: walk(v, sec or k, k if sec else None) for k, v in o.items()}
    if isinstance(o, list):
        return [walk(v, sec) for v in o]
    if isinstance(o, str) and "$p(" in o:
        new = repair(o)
        if new != o:
            changed += 1
            if sec == "broadcast" and key:
                bc_updates[key] = new
            return new
    return o


tr2 = walk(tr)
print(f"полагоджено токенів: {fixed_n} | рядків: {changed} | "
      f"потребують руки: {skipped}")
for s in dict.fromkeys(manual):
    print(f"  ⚠ вручну: {s}")

if not APPLY:
    print("\n(звіт; щоб застосувати — --apply)")
    sys.exit()

io.open(TR, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr2, ensure_ascii=False, indent=1))
print("translations.json оновлено")
if bc_updates:
    p = DATA_DIR / "tester_new" / "gender_fix_broadcast.json"
    p.parent.mkdir(parents=True, exist_ok=True)
    io.open(p, "w", encoding="utf-8", newline="\n").write(
        json.dumps(bc_updates, ensure_ascii=False, indent=1))
    print(f"-> {p.name}: {len(bc_updates)} пар для "
          f"_update_broadcast_values.py (Broadcast.lua редагуємо лише ним)")
