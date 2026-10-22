# -*- coding: utf-8 -*-
"""ГЕЙТ: у видимих ЗНАЧЕННЯХ не має бути «типографських» апострофів U+2019('),
U+02BC(ʼ), U+2018('), U+2032(′) — кінематик/субтитровий шрифт їх не має → квадрат-тофу
в катсценах (див. драктирська флешбек-сцена Ембертал). Канон: прямий U+0027 (').
Перевіряє translations.json (значення, не EN-ключі) і майстер Broadcast.lua.
Фікс: python scratchpad/norm_apostrophes.py + порядкова заміна в Broadcast.lua."""
import json, re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
B = Path(__file__).resolve().parent.parent
BAD = {0x2019: "'", 0x02BC: "ʼ", 0x2018: "'", 0x2032: "′"}
bad_chars = "".join(chr(c) for c in BAD)

tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
hits = []
def walk(o, path):
    if isinstance(o, dict):
        for k, v in o.items(): walk(v, f"{path}/{k}")
    elif isinstance(o, list):
        for i, v in enumerate(o): walk(v, f"{path}[{i}]")
    elif isinstance(o, str):
        if any(ch in o for ch in bad_chars):
            hits.append((path, o[:60]))
walk(tr, "")

# майстер Broadcast.lua — ЛИШЕ значення (EN-ключі можуть мати кучеряві ' зі скрейпу,
# але вони не показуються, тож не тофу).
lua = (B / "addon/UALL/Database/Broadcast.lua").read_text(encoding="utf-8")
pairs = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', lua)
lua_bad = sum(sum(v.count(chr(c)) for c in BAD) for _, v in pairs)

print("=== ГЕЙТ ТОФУ-АПОСТРОФІВ ===")
if not hits and not lua_bad:
    print("✅ чисто — лише прямий U+0027 (').")
    sys.exit(0)
print(f"❌ translations значень з тофу-апострофом: {len(hits)} | Broadcast.lua символів: {lua_bad}")
for p, s in hits[:20]:
    print(f"  [{p}] {s!r}")
sys.exit(1)
