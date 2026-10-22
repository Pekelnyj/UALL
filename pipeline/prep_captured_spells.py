# -*- coding: utf-8 -*-
"""Сфокусований батч зі ЗБІРНИХ спелів (skillLine='Captured'), неперекладених:
назва + опис разом, з контекстом de/fr. -> data/captured_spells.json
"""
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

_VAR = re.compile(r"\$@?\w+|\$\{[^}]*\}|\$<\w+>|\$/\d+;?|\$\*\d*|\|[A-Za-z].-?.*?\|[a-z]")
_INTERNAL = re.compile(r"\bItem -|\bDummy\b|Scaling Token|\bDND\b|\bPH\b|\bTEST\b|"
                       r"UNUSED|QAONLY|\(DNT\)|NYI", re.I)


def en(x):
    return x.get("en") if isinstance(x, dict) else x


def has_words(s):
    """Чи лишаються справжні слова після видалення $-змінних/кодів (3+ літери)."""
    if not s:
        return False
    bare = _VAR.sub(" ", s)
    return bool(re.search(r"[A-Za-z]{3,}", bare))


def is_internal_name(s):
    return not s or _INTERNAL.search(s) or not re.search(r"[A-Za-z]{3,}", s)


sp = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
done_names = set(tr.get("spells", {}))
done_desc = set(tr.get("descTemplates", {}))

out = []
for sid, v in sp.items():
    if not isinstance(v, dict) or v.get("skillLine") != "Captured":
        continue
    nm = v.get("name") or {}
    nen = en(nm)
    d = v.get("description") or {}
    den = en(d)
    need_name = nen and sid not in done_names and not is_internal_name(nen)
    need_desc = den and den not in done_desc and has_words(den)
    if not (need_name or need_desc):
        continue
    e = {"id": sid}
    if need_name:
        e["name_en"] = nen
        if isinstance(nm, dict):
            e["name_de"] = nm.get("de", ""); e["name_fr"] = nm.get("fr", "")
    if need_desc:
        e["desc_en"] = den
        if isinstance(d, dict):
            e["desc_de"] = d.get("de", ""); e["desc_fr"] = d.get("fr", "")
    out.append(e)

out.sort(key=lambda x: x.get("name_en") or x["id"])
(DATA_DIR / "captured_spells.json").write_text(
    json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Зібраних спелів до перекладу: {len(out)} "
      f"(назв: {sum('name_en' in e for e in out)}, описів: {sum('desc_en' in e for e in out)})")
