# -*- coding: utf-8 -*-
"""Прив'язати вже наявні переклади НАЗВ до номерів заклять (spells[ID]).

У описах здібностей журналу лінк |Hspell:ID|h[Name]|h лишається англійським,
якщо spells[ID] порожній. Аудит 17.09: з 1 691 таких назв 1 434 уже перекладені
в базі — здебільшого як ЗАГОЛОВКИ розділів журналу (journalSections), інколи під
іншим номером закляття з тією самою англ. назвою. Бракувало лише прив'язки.

Пріоритет джерела (перший знайдений):
  1) journalSections[назва] — заголовок здібності; назва в лінку має збігатися
     із заголовком на тій самій сторінці журналу;
  2) spells[інший ID] з тією самою англ. назвою в source/spells.json;
  3) bossAbilities[назва] (лише короткі, до 80 символів — назва, а не опис);
  4) itemNames[назва];
  5) --extra <json> {англ. назва: переклад} — нові переклади хвилі.

ЗАПОБІЖНИК перевикористаних ID: якщо в source/spells.json для ID є англ. назва
і вона не збігається з назвою в лінку (без урахування регістру) — не чіпаємо:
журнал ставить той самий ID під чужу назву.

Запуск: python _fill_spell_names_from_base.py [--extra файл.json] [--apply]
Далі:   python _prep_spell_links_wave.py
"""
import io
import json
import re
import sys
from collections import Counter, defaultdict

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
EXTRA = sys.argv[sys.argv.index("--extra") + 1] if "--extra" in sys.argv else None
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
src = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
sp = tr.setdefault("spells", {})
extra = json.loads(open(EXTRA, encoding="utf-8-sig").read()) if EXTRA else {}

LINK = re.compile(r"\|Hspell:(\d+)\|h\[([^\]]+)\]\|h")
CYR = re.compile(r"[А-Яа-яІіЇїЄєҐґ]")
LAT = re.compile(r"[A-Za-z]{3,}")


def en_of(i):
    v = src.get(i)
    if isinstance(v, dict):
        n = v.get("name")
        return n.get("en") if isinstance(n, dict) else (n if isinstance(n, str) else None)
    return None


by_name = defaultdict(list)
for i, u in sp.items():
    e = en_of(i)
    if e and isinstance(u, str) and CYR.search(u):
        by_name[e].append(u)


def lookup(name):
    v = (tr.get("journalSections") or {}).get(name)
    if isinstance(v, str) and CYR.search(v):
        return v, "заголовок журналу"
    if by_name.get(name):
        return Counter(by_name[name]).most_common(1)[0][0], "spells за назвою"
    v = (tr.get("bossAbilities") or {}).get(name)
    if isinstance(v, str) and CYR.search(v) and len(v) <= 80:
        return v, "bossAbilities"
    v = (tr.get("itemNames") or {}).get(name)
    if isinstance(v, str) and CYR.search(v):
        return v, "itemNames"
    v = extra.get(name)
    if isinstance(v, str) and CYR.search(v):
        return v, "нова хвиля"
    return None, None


links = defaultdict(Counter)               # ID -> Counter(англ. назв у лінках)
for d in tr.values():
    if not isinstance(d, dict):
        continue
    for v in d.values():
        if isinstance(v, str) and CYR.search(v) and "|Hspell:" in v:
            for sid, name in LINK.findall(v):
                if LAT.search(name) and not CYR.search(name) and sid not in sp:
                    links[sid][name] += 1

filled, why = {}, Counter()
anchors = {}                                # ID -> англ. назва, під яку взято переклад
reuse, missing = [], set()
for sid, names in links.items():
    e = en_of(sid)
    # назва для ID: та, що збігається з джерелом; без джерела — найчастіша в лінках
    cands = [n for n in names if e and n.lower() == e.lower()] or ([] if e else [names.most_common(1)[0][0]])
    if not cands:
        reuse.append((sid, e, list(names)))
        continue
    ua, kind = lookup(cands[0])
    if ua:
        filled[sid] = ua
        anchors[sid] = cands[0]
        why[kind] += 1
    else:
        missing.add(cands[0])

print(f"ID без перекладу в лінках: {len(links)} | заповнено: {len(filled)} | за джерелом: {dict(why)}")
print(f"ID, де журнал ставить іншу назву (не чіпаємо): {len(reuse)}")
print(f"назв без перекладу ніде: {len(missing)}")
for sid, ua in list(filled.items())[:10]:
    print(f"   {sid} [{en_of(sid) or next(iter(links[sid]))}] -> {ua}")
out = DATA_DIR / "batches" / "spelllinks" / "_missing_names.json"
out.parent.mkdir(parents=True, exist_ok=True)
out.write_text(json.dumps(sorted(missing), ensure_ascii=False, indent=1), encoding="utf-8")
print(f"список нових назв -> {out}")
if not APPLY:
    print("\nЧЕРНЕТКА — додай --apply")
    sys.exit(0)
sp.update(filled)
io.open(P, "w", encoding="utf-8", newline="\n").write(json.dumps(tr, ensure_ascii=False, indent=1))
# Якір для _merge_spell_links_wave.py: для більшості цих ID у source/spells.json
# англ. назви немає, тож запобіжник «той самий ID під іншою назвою» мав би з чим
# звіряти лише тут. 36 ID журнал ставить під різні назви («Concussive Blast» і
# «Explosive Surprise» під одним номером) — без якоря чужа назва пішла б у лінк.
A = DATA_DIR / "batches" / "spelllinks" / "_spell_anchor.json"
old = json.loads(A.read_text(encoding="utf-8")) if A.exists() else {}
old.update(anchors)
A.write_text(json.dumps(old, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"translations.json записано; якорів назв: {len(old)} -> {A.name}")
