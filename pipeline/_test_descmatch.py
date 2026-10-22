# -*- coding: utf-8 -*-
import sys, re, json
sys.stdout.reconfigure(encoding="utf-8")


def WordsKey(s):
    s = re.sub(r'\|c[0-9a-fA-F]{8}', '', s)
    s = re.sub(r'\|cn[A-Za-z_]+:', '', s)
    s = s.replace('|r', '')
    s = re.sub(r'\|H.*?\|h(.*?)\|h', r'\1', s)
    s = re.sub(r'\|T.*?\|t', '', s)
    s = re.sub(r'\|A.*?\|a', '', s)
    s = s.replace('$bullet;', ' ')
    s = re.sub(r'\$@?\w*', ' ', s)
    s = re.sub(r'\d', ' ', s)
    s = re.sub(r'[^0-9A-Za-z_\s]', ' ', s)
    s = s.lower()
    s = re.sub(r'\s+', ' ', s).strip()
    return s


# Парсимо SpellDescriptions.lua: spellDescIndex + descTemplates[idx].en
lua = open("addon/WoWUkraine/Database/SpellDescriptions.lua", encoding="utf-8").read()
mi = lua.find("ns.spellDescIndex = {")
idxmap = {}
for sid, idx in re.findall(r'\[(\d+)\]\s*=\s*(\d+),', lua[mi:]):
    idxmap[int(sid)] = int(idx)
# descTemplates EN за порядком (idx 1-based)
dt_block = lua[lua.find("ns.descTemplates = {"):mi]
ens = re.findall(r'\{\s*en\s*=\s*"((?:[^"\\]|\\.)*)"', dt_block)


def desc_en(spellID):
    idx = idxmap.get(spellID)
    if not idx or idx > len(ens):
        return None
    return ens[idx - 1].encode().decode("unicode_escape", errors="replace") if "\\" in ens[idx - 1] else ens[idx - 1]


# Тести: spellID -> показаний текст (з ejmiss)
tests = {
    154139: "Lesser constructs surrounding the arena focus light rays at Araknath, healing it for 1% every 0.5 sec and granting it Solar Infusion every 0.5 sec.\r\n\r\nPlayers blocking light rays suffer 20,338 Fire damage every 1 sec.",
    1252877: "Light rays that connect with Araknath infuse it with solar energy, inflicting 7,627 Fire damage to all players and increasing Supernova's damage done by 5%. This effect stacks. \r\n\r\nSolar Infusion is consumed after empowering Supernova.",
}
for sid, disp in tests.items():
    en = desc_en(sid)
    print(f"spellID {sid}: descTemplate EN {'Є' if en else 'НЕМА'}")
    if en:
        ke = WordsKey(en)[:48]
        kd = WordsKey(disp)[:48]
        print(f"  EN-шаблон ключ: {ke!r}")
        print(f"  показаний ключ: {kd!r}")
        print(f"  ЗБІГ префіксів: {ke == kd}")
    print()
