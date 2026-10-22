# -*- coding: utf-8 -*-
"""Змерджити фінальну хвилю дрібних категорій у translations.json."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
TR = B / "data/translations.json"
tr = json.loads(TR.read_text(encoding="utf-8-sig"))
OUT = B / "data/_fin_out"


def merge_id(outfile, section):
    p = OUT / outfile
    if not p.exists():
        return 0
    d = json.loads(p.read_text(encoding="utf-8-sig"))
    sec = tr.setdefault(section, {})
    n = 0
    for k, v in d.items():
        if isinstance(v, str) and v.strip():
            sec[str(k)] = v
            n += 1
    return n


def merge_en(outfile, section, skip_ref=False):
    p = OUT / outfile
    if not p.exists():
        return 0
    d = json.loads(p.read_text(encoding="utf-8-sig"))
    sec = tr.setdefault(section, {})
    n = 0
    for en, ua in d.items():
        if not isinstance(ua, str) or not ua.strip():
            continue
        if skip_ref and (ua == en or en.lstrip().startswith("$@") or "$@spelldesc" in en):
            continue
        sec[en] = ua
        n += 1
    return n


r = {}
r["mounts"] = merge_id("mounts.json", "mounts")
r["pets"] = merge_id("pets.json", "pets")
r["factions"] = merge_id("factions.json", "factions")
r["currencies"] = merge_id("currencies.json", "currencies")
r["instanceDesc"] = merge_id("instancedesc.json", "instanceDesc")
r["itemNames"] = merge_en("item_names.json", "itemNames")
r["itemFlavors"] = merge_en("item_flavors.json", "itemFlavors")
r["descTemplates"] = merge_en("spell_desc_1.json", "descTemplates", skip_ref=True) + \
    merge_en("spell_desc_2.json", "descTemplates", skip_ref=True)

TR.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
for k, v in r.items():
    print(f"{k:<15}+{v}")
print("РАЗОМ змерджено:", sum(r.values()))
