# -*- coding: utf-8 -*-
"""Зняти ключі, де ім'я гравця стоїть у гнізді, яке база сама токенізує.

ДОКАЗ. Якщо існує ПАРА ключів, що різняться лише тим, що в одному на місці
слова стоїть «{NAME}», а в другому — буквальне слово, то це гніздо змінне,
а слово в ньому — підставлене ім'я гравця. Списку ніків не потрібно: він
знає лише НАШИХ тестерів, а тут сторонні люди [[guild-names-never-translate]].

Чому попередні заслони це проґавили:
  * гейт за списком ніків — не знає чужих, а транслітероване «Ферріку»
    не бачить і латинський пошук;
  * правило «однаковий хвіст, різні перші слова» — дивиться лише на ПЕРШЕ
    слово, а тут ім'я стоїть посеред речення або в кінці
    («A treasure chest has spawned for Kaisertabell!»).

Знімати безпечно: двійник із «{NAME}» за побудовою вже є в базі й працює
для будь-якого гравця, тож переклад не втрачається.

ЗАСЛОНИ ВІД ХИБНИХ ВЛУЧАНЬ:
  * заповнювач, що є іменем істоти (датамайн або NpcNames.lua), не чіпаємо —
    інакше знесло б «Yumadormu», «Maella», «Maiev»;
  * кістяк мусить мати щонайменше MIN_CTX літерального тексту, інакше
    односкладові ключі («Stay.», «Nope.») зливаються в один кістяк «__.»
    і збігаються з усім підряд.

Запуск: python _drop_playername_twins.py [--apply]
Далі:   python _sync_broadcast_master.py && python generate_db.py
"""
import io
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
TR = DATA_DIR / "translations.json"
MIN_CTX = 30
SECTIONS = ("gossip", "system", "emotes", "uiTooltips", "playerChoice")

WORD = re.compile(r"\{NAME\}|\{name\}|\b([A-ZÀ-Þ][\w'’À-ɏ]{2,})\b")
LINE = re.compile(r'^\s*\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)",?\s*$')


def un(s):
    s = s.replace("\\\\", "\x00")
    s = (s.replace('\\"', '"').replace("\\n", "\n")
          .replace("\\r", "\r").replace("\\t", "\t"))
    return s.replace("\x00", "\\")


cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
NPC = set()
for v in (cr.values() if isinstance(cr, dict) else cr):
    n = v.get("name") if isinstance(v, dict) else None
    e = n.get("en") if isinstance(n, dict) else None
    if e:
        NPC |= set(re.findall(r"[A-Za-z']{3,}", e))
_lua = DATA_DIR.parent / "addon" / "UALL_NpcNames" / "NpcNames.lua"
if _lua.exists():
    _t = _lua.read_text(encoding="utf-8", errors="replace")
    for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]', _t):
        NPC |= set(re.findall(r"[A-Za-z']{3,}", m.group(1)))


def find_twins(keys):
    """-> {ключ: слово-заповнювач}, які треба зняти."""
    skel = defaultdict(dict)
    for k in keys:
        if not isinstance(k, str):
            continue
        for m in WORD.finditer(k):
            s = k[:m.start()] + "\x01" + k[m.end():]
            if len(s) - 1 >= MIN_CTX:
                skel[s][m.group(0)] = k
    out = {}
    for s, fills in skel.items():
        if not any(f.startswith("{") for f in fills):
            continue
        for f, key in fills.items():
            if f.startswith("{") or f in NPC:
                continue
            out[key] = f
    return out


tr = json.loads(TR.read_text(encoding="utf-8-sig"))

# --- broadcast: майстер = Broadcast.lua, знімаємо ЦІЛИМИ РЯДКАМИ ---
src = DB.read_text(encoding="utf-8")
lines = src.split("\n")
bkeys, idx_of = [], {}
for i, ln in enumerate(lines):
    m = LINE.match(ln)
    if m:
        k = un(m.group(1))
        bkeys.append(k)
        idx_of[k] = i
bdrop = find_twins(bkeys)
print(f"broadcast: на зняття {len(bdrop)}")
for k, w in list(sorted(bdrop.items(), key=lambda x: x[1]))[:10]:
    ua = un(LINE.match(lines[idx_of[k]]).group(2))
    print(f"  «{w}»  {k[:56]}")
    print(f"       -> {ua[:60]}")
if len(bdrop) > 10:
    print(f"  … ще {len(bdrop) - 10}")

# --- решта секцій: у translations.json ---
sdrop = {}
for sec in SECTIONS:
    d = tr.get(sec)
    if not isinstance(d, dict):
        continue
    hit = find_twins(d.keys())
    if hit:
        sdrop[sec] = hit
        print(f"\n{sec}: на зняття {len(hit)}")
        for k, w in list(sorted(hit.items(), key=lambda x: x[1]))[:6]:
            v = d[k]
            ua = v if isinstance(v, str) else (v.get("ua") if isinstance(v, dict) else "")
            print(f"  «{w}»  {k[:56]}")
            print(f"       -> {(ua or '')[:60]}")
        if len(hit) > 6:
            print(f"  … ще {len(hit) - 6}")

tot = len(bdrop) + sum(len(v) for v in sdrop.values())
# Повний перелік імен — щоб вирок був за очима, а не за обрізаним прикладом:
# саме тут видно, чи не зачепило NPC, якого немає в жодному джерелі.
allnames = defaultdict(int)
for w in bdrop.values():
    allnames[w] += 1
for hit in sdrop.values():
    for w in hit.values():
        allnames[w] += 1
print("\nімена (скільки ключів): "
      + ", ".join(f"{n}×{c}" for n, c in sorted(allnames.items())))
print(f"\nразом на зняття: {tot}")
if not APPLY:
    print("ЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)

drop_idx = {idx_of[k] for k in bdrop}
out = "\n".join(ln for i, ln in enumerate(lines) if i not in drop_idx)
if out.count("{") != out.count("}"):
    sys.exit("ДИСБАЛАНС дужок — не записую")
io.open(DB, "w", encoding="utf-8", newline="\n").write(out)
for sec, hit in sdrop.items():
    for k in hit:
        tr[sec].pop(k, None)
io.open(TR, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print(f"знято: broadcast {len(bdrop)}, інші секції {sum(len(v) for v in sdrop.values())}")
