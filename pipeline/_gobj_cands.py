# -*- coding: utf-8 -*-
import json
import re
import sys
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8")
go = json.load(open("g:/Claude Code/WoWUkraine/data/source/gameobjects.json", encoding="utf-8-sig"))
tr = json.load(open("g:/Claude Code/WoWUkraine/data/translations.json", encoding="utf-8-sig"))
done = set(tr.get("gameObjects", {}))

OBJ = re.compile(r"(?i)\b(chest|crate|barrel|box|sack|bag|cart|wagon|banner|flag|brazier|candle|torch|"
                 r"lantern|book|scroll|tome|table|chair|bench|door|lever|switch|wheel|anvil|forge|cauldron|"
                 r"pot|keg|cage|trap|net|web|bones?|skeleton|corpse|rock|stone|crystal|orb|rune|pillar|"
                 r"statue|altar|totem|sign|post|fence|wall|rubble|debris|wreckage|supplies|tools?|mushroom|"
                 r"flower|herb|plant|tree|bush|vine|root|fungus|seed|fruit|berry|node|vein|deposit|cluster|"
                 r"geyser|pool|puddle|spring|campfire|bonfire|pyre|food|meat|fish|bottle|flask|cup|plate|"
                 r"bowl|weapon|sword|axe|shield|hammer|pick|shovel|rope|chain|key|map|note|letter|painting|"
                 r"tapestry|rug|throne|coffin|tomb|grave|urn|bell|drum|horn|barrel|brazier|crate)\b")

freq = Counter()
ctx = {}
for v in go.values():
    nm = v.get("name", {})
    en, de = nm.get("en", ""), nm.get("de", "")
    if en and de and de != en and OBJ.search(en) and "_" not in en and en not in done \
            and not re.search(r"\d\.\d|Doodad|Decal|\(TESTING\)|\bON\b|\bOFF\b", en):
        freq[en] += 1
        ctx.setdefault(en, de)

print(f"кандидатів-об-єктів: {len(freq)}")
for en, c in freq.most_common(70):
    print(f"{c:>3}| {en}  ||  {ctx[en]}")
