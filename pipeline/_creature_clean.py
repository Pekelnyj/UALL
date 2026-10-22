# -*- coding: utf-8 -*-
"""Жорсткий відсів DEV/внутрішнього сміття зі списку імен істот (Creature gap).
Лишає РЕАЛЬНІ гравцеві імена. Пише data/tester_new/db2gaps/creature/_clean.json
"""
import json, re, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
P = ROOT + "/data/tester_new/db2gaps/creature/_names.json"
names = list(json.load(open(P, encoding="utf-8")).keys())

JUNK = re.compile(
    r"^\d+\.\d|^\d+\s+\w+\s+(Point|Grapple|Marker)|^\d{2,}\s|"  # версії 10.0/11.1 + маркери «01 Grapple…»
    r"\bSound\b|\bNPC\b|\bMarker\b|\bTrigger\b|\bSpawner\b|\bInvisible\b|\bCamera\b|"
    r"\bBunny\b|\bTarget\b|\bCredit\b|\bDummy\b|\bGeneric\b|\bVisual\b|\bEffect\b|"
    r"\bProt\b|\bProto\b|\bPrototype\b|\bDELETE\b|\bUNUSED\b|\bDEPRECATED\b|\bTEST\b|"
    r"\bNYI\b|\bWIP\b|\bPH\b|\bDND\b|\bDNT\b|\bTEMP\b|\bDebug\b|\bPLACEHOLDER\b|"
    r"\bKillCredit\b|\bCosmetic\b|\bController\b|\bStalker\b\s*$|"  # «… Sound Stalker»
    r"\bEmitter\b|\bVehicle\b\s+\d|"
    r"[-:]\s*(V\d|Ch\s*\d|Q\d|Max Level|Vision)|"  # dev-структура: «- V05», «Ch 01», «Q04»
    r"\(.*\b(Hufton|Invisible|copy|DO NOT|test)\b.*\)|"  # автор-теги/нотатки
    r"^[A-Za-z]+\d+$|"                           # код типу «Foo01»
    r"\bArt\b|\bAnim\b|\bRig\b|\bLOD\b",
    re.I)

def junk(s):
    s = re.sub(r"^<[^>]+>\s*", "", s.strip())  # зняти статус-тег <Away> тощо
    if re.match(r"^\d+(st|nd|rd|th)\s+[A-Za-z]", s):  # порядкові «7th Legion» — лишити
        return False
    if JUNK.search(s):
        return True
    if len(re.sub(r"[^A-Za-z]", "", s)) < 3:
        return True
    # суцільні лапки/код без справжніх слів
    letters = re.findall(r"[A-Za-z']{2,}", s)
    if not letters:
        return True
    return False

clean = [n for n in names if not junk(n)]
junked = [n for n in names if junk(n)]
json.dump({n: "" for n in clean}, open(ROOT + "/data/tester_new/db2gaps/creature/_clean.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"усього: {len(names)} | ЧИСТИХ (на переклад): {len(clean)} | відсіяно сміття: {len(junked)}")
print("\nприклади ЧИСТИХ:")
for n in clean[:14]:
    print("  ", repr(n))
print("\nприклади ВІДСІЯНОГО:")
for n in junked[:10]:
    print("  ", repr(n))
