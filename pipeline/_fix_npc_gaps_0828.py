# -*- coding: utf-8 -*-
"""Три правки в іменах NPC (28.08): розповсюдження, підміна, Blacktalon.

1) РОЗПОВСЮДЖЕННЯ. npcNames ключується за ID, а хвиля перекладає НАЗВУ. Якщо
   одну назву носять кілька ID, злиття прописувало лише ті, що були в порції,
   і решта лишалася «неперекладеною», хоч переклад давно є. Так у черзі висіли
   72 записи з 75: «Handhold» під 186920 перекладено, а під 180377, 187710 і
   186143 — ні.

   ЗАПОБІЖНИКИ. Не переносимо з ID, чий переклад сам схожий на підміну,
   інакше розмножимо помилку [[kv-shift-substitution]]:
     * той самий UA стоїть під РІЗНИМИ англійськими назвами — ознака підміни;
     * UA у рази довший за EN (той самий поріг, що в _check_kv_shift).

2) ПІДМІНА 189895. Датамайн каже «Primalist Infiltrator», база — «Мешканець
   Валдраккену». Правильна форма за наявним каноном: Primalist -> первісник
   (411 входжень), Infiltrator -> Інфільтратор (домінанта).

3) BLACKTALON. Рахунок ЗА АНГЛІЙСЬКИМ ЯКОРЕМ (не за укр. підрядком, бо той
   ловить сторонні «Black Claw of Sethe» та «Ebonclaw Worg»): 38 «Пазур»
   проти 9 «Кіготь». Той самий NPC суперечить сам собі між шарами — у балачці
   «Вбивця Чорного Пазура», на плашці «Убивця Чорного Кігтя». Зводимо до
   домінанти.

Запуск: python _fix_npc_gaps_0828.py [--apply]
Далі:   python generate_db.py
"""
import glob
import io
import json
import re
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
npc = tr.setdefault("npcNames", {})

RATIO, SLACK = 2.6, 8

# --- ID -> англійська назва: датамайн + зібране в грі ---
en_of = {}
cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
for cid, v in cr.items():
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if en:
        en_of[str(cid)] = en


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


captured_ids = set()
paths = glob.glob(r"F:/Battlenet/World of Warcraft/_retail_/WTF/Account/*/SavedVariables/UALL.lua")
paths += sorted(glob.glob(str(DATA_DIR.parent / "testerlua" / "*.lua")))
for p in paths:
    try:
        t = open(p, encoding="utf-8", errors="replace").read()
    except OSError:
        continue
    for cid, nm in re.findall(r'\["(\d+)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', block(t, "npc")):
        en_of.setdefault(cid, nm.replace('\\"', '"'))
        captured_ids.add(cid)

# ПОРЯДОК ВАЖИТЬ. Спершу лікуємо, потім розмножуємо: у першій чернетці
# розповсюдження підхопило саму підміну (191841 дістав би «Мешканець
# Валдраккену» від 189895) і донищений Blacktalon («Стратег Чорнокігтя»).

# --- 2. підміна 189895 (ПЕРЕД розповсюдженням) -----------------------------
FIX_ID = {"189895": ("Primalist Infiltrator", "Інфільтратор первісників")}
print("2) підміна:")
for cid, (en, ua) in FIX_ID.items():
    print(f"     {cid} «{en}»: {npc.get(cid)!r} -> {ua!r}")
    if APPLY:
        npc[cid] = ua

# --- 3. Blacktalon (ПЕРЕД розповсюдженням) ---------------------------------
KIG = re.compile(r"Чорнокігт\w*|Чорнокіготь|Чорного Кігтя|Чорний Кіготь")
bt = []
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k, v in d.items():
        s = v if isinstance(v, str) else None
        if not s:
            continue
        en = k if isinstance(k, str) and not k.isdigit() else en_of.get(str(k), "")
        if "Blacktalon" not in en or not KIG.search(s):
            continue
        bt.append((sec, k, en, s, KIG.sub("Чорного Пазура", s)))
print(f"\n3) Blacktalon -> домінанта «Чорного Пазура»: {len(bt)}")
for sec, k, en, old, new in bt:
    print(f"     [{sec}] {en}\n        -  {old}\n        +  {new}")
if APPLY:
    for sec, k, _en, _old, new in bt:
        tr[sec][k] = new

# --- 1. розповсюдження -----------------------------------------------------
ua_to_en = defaultdict(set)
for cid, ua in npc.items():
    if isinstance(ua, str) and cid in en_of:
        ua_to_en[ua].add(en_of[cid])

by_name = {}
for cid, ua in npc.items():
    en = en_of.get(str(cid))
    if not en or not isinstance(ua, str):
        continue
    if len(ua_to_en[ua]) > 1:            # той самий UA під різними EN
        continue
    if len(ua) > len(en) * RATIO + SLACK:  # переклад у рази довший
        continue
    by_name.setdefault(en, (cid, ua))

# Розповсюджуємо лише на ID, ЗІБРАНІ В ГРІ. Те саме правило, застосоване до
# всього датамайну, дало б 1 162 записи — корисно, але це вже інший обсяг,
# і його треба погоджувати окремо [[warn-before-scope-data-ops]].
# Серед зібраних ID буває плашка ГРАВЦЯ — збір бере імена з плашок, а вони
# є і в людей. Саме так у датамайн колись потрапили «<нік>» і
# «<нік>» [[guild-names-never-translate]].
from playernames import known_nicks
NICKS = known_nicks(min_len=3, drop_ambiguous=False)

spread, skipped_nick = [], []
for cid in sorted(captured_ids):
    en = en_of.get(cid)
    if not en or cid in npc or en not in by_name:
        continue
    if en in NICKS:
        skipped_nick.append((cid, en))
        continue
    src_id, ua = by_name[en]
    spread.append((cid, en, ua, src_id))
if skipped_nick:
    print(f"відсіяно як імена гравців: {len(skipped_nick)} -> {skipped_nick[:6]}")

print(f"\n1) розповсюдження на зібрані ID: {len(spread)}")
for cid, en, ua, src in spread:
    print(f"     {cid} «{en}» <- {src}: «{ua}»")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)

for cid, _en, ua, _src in spread:
    npc[cid] = ua
for cid, (_en, ua) in FIX_ID.items():
    npc[cid] = ua
for sec, k, _en, _old, new in bt:
    tr[sec][k] = new
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print(f"\nзаписано: розповсюджено {len(spread)}, підміна {len(FIX_ID)}, "
      f"Blacktalon {len(bt)}")
