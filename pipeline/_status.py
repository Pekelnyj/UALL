# -*- coding: utf-8 -*-
"""ЄДИНА лінійка стану проєкту. Не писати нових одноразових підрахунків.

НАВІЩО. 28.08 те саме питання «скільки лишилось» дало три різні відповіді,
бо кожен ad-hoc скрипт мав свої припущення: один брав шість останніх зборів,
другий — усі; один рахував записи за ID, другий — унікальні назви; один шукав
за українським підрядком, другий — за англійським якорем. Числа розходилися
не тому, що база змінювалась, а тому, що змінювалась лінійка.

ВИЗНАЧЕННЯ, зафіксовані тут раз і назавжди:

  * РІЗНИЦЯ МНОЖИН, не віднімання чисел. Секції ключуються по-різному —
    itemNames/gameObjects/broadcast за англійським РЯДКОМ, npcNames/spells/
    quests за ID. Порівняння лічильників дає борг із повітря
    [[count-unique-texts-not-ids]].
  * УСІ збори, а не останні N файлів.
  * Залишок ділиться на ТРИ, і плутати їх не можна:
      - «переклад»    — тексту немає ніде, треба перекладати;
      - «злиття»      — переклад Є під іншим ID/ключем, треба лише рознести;
      - «відсіяно»    — імена гравців, службове, %-шаблони: НЕ борг.
  * Назви звіряються за АНГЛІЙСЬКИМ якорем, ніколи за українським підрядком
    [[verify-names-by-id-anchor]].

Запуск: python _status.py
"""
import glob
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import known_nicks

R = DATA_DIR.parent
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
NICKS = known_nicks(min_len=3, drop_ambiguous=False)
JUNK = re.compile(
    r"^\d|_|TESTING|\bTEST\b|\bDNT\b|DEPRECATED|\[PH\]|Placeholder|\bQA\b|"
    r"Debug|UNUSED|Unused|\bOLD\b|zzOld|MoveMe|\bTEMP\b|Internal|"
    r"\bProps?\b|\bPhase\b|\bHub\b|\bSpawn\b|\bTrigger\b|\bCollision\b|"
    r"\bDoodad\b|\bBunny\b|\bInvisible\b|\bNoName\b|^-|--", re.I)


def src_names(fname, field="name"):
    """Унікальні англійські тексти з файлу-джерела."""
    p = DATA_DIR / "source" / fname
    if not p.exists():
        return set()
    d = json.loads(p.read_text(encoding="utf-8-sig"))
    out = set()
    for v in (d.values() if isinstance(d, dict) else d):
        if isinstance(v, str):
            out.add(v.strip())
        elif isinstance(v, dict):
            f = v.get(field)
            en = f.get("en") if isinstance(f, dict) else f
            if isinstance(en, str) and en.strip():
                out.add(en.strip())
    return {x for x in out if x}


print("=" * 66)
print("ДАТАМАЙН (ключ = англійський рядок): різниця МНОЖИН")
print("=" * 66)
print(f"{'категорія':<26}{'джерело':>9}{'база':>9}{'борг':>8}{'службове':>10}")
for label, fname, sec, field in (
        ("Предмети: назви", "items.json", "itemNames", "name"),
        ("Предмети: флейвор", "items.json", "itemFlavors", "flavor"),
        ("Світові об'єкти", "gameobjects.json", "gameObjects", "name"),
):
    names = src_names(fname, field)
    have = set(tr.get(sec) or {})
    left = names - have
    junk = {n for n in left if JUNK.search(n)}
    print(f"{label:<26}{len(names):>9}{len(have):>9}"
          f"{len(left) - len(junk):>8}{len(junk):>10}")

# закляття в лінках
LINK = re.compile(r"\|Hspell:(\d+)\|h\[([^\]]+)\]\|h")
CYR, LAT = re.compile(r"[А-Яа-яІіЇїЄєҐґ]"), re.compile(r"[A-Za-z]{3,}")
sp = tr.get("spells") or {}
miss_link, sub_link = set(), 0
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for v in d.values():
        s = v if isinstance(v, str) else None
        if not s or "|Hspell:" not in s:
            continue
        for sid, nm in LINK.findall(s):
            if LAT.search(nm) and not CYR.search(nm):
                if sid in sp:
                    sub_link += 1
                else:
                    miss_link.add(sid)
print(f"{'Закляття в лінках':<26}{'':>9}{'':>9}{len(miss_link):>8}"
      f"{'':>10}   (+{sub_link} готових до підстановки)")

# --- збори -----------------------------------------------------------------
print("\n" + "=" * 66)
print("ЗБОРИ (усі файли): борг / злиття / відсіяно")
print("=" * 66)


def block(src, name):
    m = re.search(r'\["' + re.escape(name) + r'"\]\s*=\s*\{', src)
    if not m:
        return ""
    i, depth, instr, esc = m.end(), 1, False, False
    while i < len(src) and depth:
        c = src[i]
        if instr:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                instr = False
        else:
            if c == '"':
                instr = True
            elif c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
        i += 1
    return src[m.end():i - 1]


paths = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/UALL.lua")
paths += sorted(glob.glob(str(R / "testerlua" / "*.lua")))
texts = []
for p in paths:
    try:
        texts.append(open(p, encoding="utf-8", errors="replace").read())
    except OSError:
        pass
print(f"файлів зборів: {len(texts)}\n")

# ID-бакет: npc
en_of = {}
cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
for cid, v in cr.items():
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if en:
        en_of[str(cid)] = en
captured = {}
for t in texts:
    for cid, nm in re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', block(t, "npc")):
        nm = nm.replace('\\"', '"')
        captured[cid] = nm
        en_of.setdefault(cid, nm)
npc = tr.get("npcNames") or {}
by_name = {en_of[c]: c for c in npc if c in en_of}
miss = {c: n for c, n in captured.items() if c not in npc}
merge = sum(1 for c, n in miss.items() if n in by_name)
nick = sum(1 for c, n in miss.items() if n in NICKS)
real = len(miss) - merge - nick
print(f"{'бакет -> секція':<26}{'зібрано':>9}{'борг':>7}{'злиття':>8}{'відсіяно':>10}")
print(f"{'npc -> npcNames':<26}{len(captured):>9}{real:>7}{merge:>8}{nick:>10}")

# рядкові бакети. ВІДПОВІДНІСТЬ БАКЕТ->СЕКЦІЯ НЕ ВГАДУЄМО, А ВИВОДИМО:
# назви не збігаються (profui -> profDesc, minimap -> minimapLabels), і
# перша версія цього ж файлу міряла «profui» проти НЕІСНУЮЧОЇ секції, через
# що показала 7 036 боргу там, де його стільки немає [[sv-bucket-vs-section-key]].
# Беремо секцію, яка накриває найбільше зібраних ключів.
SECTIONS = {s: set(d) for s, d in tr.items() if isinstance(d, dict)}
ALL_KEYS = set().union(*SECTIONS.values()) if SECTIONS else set()
for buck in ("broadcast", "gossip", "uitooltip", "objLines", "minimap",
             "profui", "subnames", "journeys"):
    keys = set()
    for t in texts:
        b = block(t, buck)
        if b:
            for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]', b):
                k = m.group(1).replace('\\"', '"').replace("\\n", "\n")
                if k:
                    keys.add(k)
    if not keys:
        continue
    # Міряємо проти ОБ'ЄДНАННЯ всіх секцій, а не однієї «найкращої»: ключі
    # одного бакета лежать у кількох секціях, і вибір однієї роздував борг.
    # Питання просте — чи цей рядок перекладено бодай десь.
    left = keys - ALL_KEYS
    cover = sorted(((len(keys & ks), s) for s, ks in SECTIONS.items() if keys & ks),
                   reverse=True)[:2]
    best = "+".join(s for _n, s in cover) or "—"
    filt = {k for k in left
            if "%" in k or any(n in k for n in NICKS if len(n) > 4)}
    tag = f"{buck}->{best}"
    print(f"{tag:<26}{len(keys):>9}{len(left) - len(filt):>7}"
          f"{'—':>8}{len(filt):>10}")

print("\nборг = перекладати | злиття = переклад є, рознести | відсіяно = не борг")
