# -*- coding: utf-8 -*-
"""Токени імені в broadcast: «{name}» -> «{NAME}» і шаблони «%s» для чужих гравців.

1) «{name}» МАЛИМИ — МЕРТВИЙ КЛЮЧ. BroadcastHooks.NormName замінює ім'я читача
   лише на «{NAME}», тож ключ із «{name}» не зматчиться ніколи: переклад є, а в
   грі англійська. 13.09 таких було 178:
     • 164 мають уже наявного «{NAME}»-двійника — малий просто знімаємо;
     • 14 оживають після зведення ключа й значення до «{NAME}».
   Малий токен лишився від нормалізатора балачок (там «{name}» законний).

2) РЕПЛІКИ ПРО ІНШИХ ГРАВЦІВ. «X WAS TAGGED!», «X is a final hider» стосуються
   не читача, а будь-кого — «{NAME}» тут підставив би ім'я ЧИТАЧА, а точний
   ключ з ніком спрацював би в одного гравця. Потрібен «%s»: хук реплік
   зіставляє шаблон і вставляє захоплене ім'я незміненим. Без цього сьогодні в
   черзі було 175 рядків «<нік> WAS TAGGED!» з різними ніками.
   Переклад беремо з наявного «{NAME}»-рядка, лише замінивши токен.

Broadcast.lua — майстер; рядки переписуємо ЦІЛИМИ (розбір -> зміна ->
повторне екранування), без regex по вмісту [[never-regex-edit-broadcast-lua]].

Запуск: python _fix_broadcast_name_tokens.py [--apply]
Далі:   python _sync_broadcast_master.py && python _check_lua_syntax.py
"""
import io
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
LINE = re.compile(r'^(\s*)\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)",?\s*$')
# Репліки, що називають БУДЬ-ЯКОГО гравця, а не читача.
OTHERS = ("{NAME} WAS TAGGED!",
          "{NAME} Is a final hider. So sneaky!",
          "{NAME} is a final hider. So sneaky!")


def un(s):
    s = s.replace("\\\\", "\x00")
    s = (s.replace('\\"', '"').replace("\\n", "\n")
          .replace("\\r", "\r").replace("\\t", "\t"))
    return s.replace("\x00", "\\")


def esc(s):
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t"))


lines = DB.read_text(encoding="utf-8").split("\n")
pairs = {}
for ln in lines:
    m = LINE.match(ln)
    if m:
        pairs[un(m.group(2))] = un(m.group(3))

out, dropped, revived = [], 0, []
for ln in lines:
    m = LINE.match(ln)
    if not m:
        out.append(ln)
        continue
    ind, k, v = m.group(1), un(m.group(2)), un(m.group(3))
    if "{name}" in k:
        up = k.replace("{name}", "{NAME}")
        if up in pairs:
            dropped += 1                # двійник уже є — малий зайвий
            continue
        nv = v.replace("{name}", "{NAME}")
        revived.append((up, nv))
        out.append(f'{ind}["{esc(up)}"] = "{esc(nv)}",')
        pairs[up] = nv                  # щоб другий такий самий не задвоївся
        continue
    out.append(ln)

add = []
for src in OTHERS:
    ua = pairs.get(src)
    tpl = src.replace("{NAME}", "%s")
    if ua and "{NAME}" in ua and tpl not in pairs:
        add.append((tpl, ua.replace("{NAME}", "%s")))

print(f"ключів із {{name}}: зняти як дублікати {dropped}, оживити {len(revived)}")
for k, v in revived[:6]:
    print(f"   {k[:56]}\n      -> {v[:56]}")
print(f"\n%s-шаблонів додати: {len(add)}")
for k, v in add:
    print(f"   {k}\n      -> {v}")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)

text = "\n".join(out)
idx = text.rstrip().rfind("}")
text = text[:idx] + "".join(f'    ["{esc(k)}"] = "{esc(v)}",\n' for k, v in add) + text[idx:]
if text.count("{") - text.count("}") != 0:
    # «{NAME}» у рядках теж дужки — баланс рахуємо без них
    bal = text.replace("{NAME}", "").replace("{name}", "")
    if bal.count("{") != bal.count("}"):
        sys.exit("ДИСБАЛАНС дужок — не записую")
io.open(DB, "w", encoding="utf-8", newline="\n").write(text)
print(f"\nBroadcast.lua: знято {dropped}, оживлено {len(revived)}, шаблонів +{len(add)}")
