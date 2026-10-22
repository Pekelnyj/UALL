# -*- coding: utf-8 -*-
"""Вичистити з кешу «репліка -> мовець» записи, де мовець — ГРАВЕЦЬ.

Збирач пише в broadcast пару текст↔мовець, і в ту саму таблицю потрапляють
системні рядки («<Нік> has returned an Amani Ritual Skull…») — тоді «мовцем»
стає живий гравець. У базу це не тече (broadcast зберігає лише текст→переклад),
але кеш годує ПАКЕТИ ДОКАЗІВ: агент отримує «ось 5 реплік цього мовця» і
звіряє тон із рядками неіснуючого NPC [[capture-wave-playername-leaks]].

Викидаємо запис, лише якщо мовець — відомий нік або ім'я власника якогось
збору. Евристику «одне слово, якого немає в джерелах імен» я спершу додав і
одразу викинув: під неї підпали Aluneth (артефакт, що говорить), Alysra,
Aerwynn, Adderis — датамайн просто дірявий [[captured-creatures-source]].
Кеш — не база: хибно лишений запис коштує агентові одного зайвого прикладу,
а хибно видалений прибирає доказ тону для справжнього NPC.

Запуск: python _clean_bc_speakers.py [--apply]
"""
import glob
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import known_nicks

APPLY = "--apply" in sys.argv
CACHE = DATA_DIR / "batches" / "_bc_speakers.json"
if not CACHE.exists():
    sys.exit("кешу немає — нічого чистити")
spk = json.loads(CACHE.read_text(encoding="utf-8"))

names = set()
cr = json.loads((DATA_DIR / "source" / "creatures.json").read_text(encoding="utf-8-sig"))
for v in (cr.values() if isinstance(cr, dict) else cr):
    nm = v.get("name") if isinstance(v, dict) else None
    en = nm.get("en") if isinstance(nm, dict) else None
    if en:
        names.add(en)
capf = DATA_DIR / "source" / "captured_creatures.json"
if capf.exists():
    cd = json.loads(capf.read_text(encoding="utf-8-sig"))
    for v in (cd.values() if isinstance(cd, dict) else cd):
        s = v if isinstance(v, str) else (
            (v.get("en") or v.get("name")) if isinstance(v, dict) else None)
        if isinstance(s, str):
            names.add(s)
lua = DATA_DIR.parent / "addon" / "UALL_NpcNames" / "NpcNames.lua"
if lua.exists():
    t = lua.read_text(encoding="utf-8", errors="replace")
    names |= {m.group(1) for m in re.finditer(r'\["((?:[^"\\]|\\.)*)"\]', t)}

owners = set()
for p in glob.glob(str(DATA_DIR.parent / "testerlua" / "*.lua")):
    try:
        t = Path(p).read_text(encoding="utf-8", errors="replace")
    except OSError:
        continue
    m = re.search(r'\["playerName"\]\s*=\s*"([^"]+)"', t)
    if m:
        owners.add(m.group(1))

nicks = known_nicks(min_len=3, drop_ambiguous=False)
drop, why = {}, {}
for text, sp in spk.items():
    if not isinstance(sp, str) or not sp:
        continue
    if sp in names:                      # відомий NPC — лишаємо
        continue
    if sp in owners:
        why[sp] = "власник збору"
    elif sp in nicks:
        why[sp] = "відомий нік"
    else:
        continue
    drop[text] = sp

print(f"у кеші: {len(spk)} | під викид: {len(drop)} реплік, "
      f"{len(set(drop.values()))} «мовців»")
for sp in sorted(set(drop.values()))[:25]:
    print(f"   {sp} — {why[sp]}")
if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
for k in drop:
    del spk[k]
CACHE.write_text(json.dumps(spk, ensure_ascii=False), encoding="utf-8")
print(f"\nкеш записано: лишилося {len(spk)}")
