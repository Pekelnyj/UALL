# -*- coding: utf-8 -*-
"""АКТИВНИЙ КАНОН-ГЕЙТ власних назв (EN-прив'язаний): для назв, де різнобій — це
РІЗНІ СЛОВА (не и/і), а не те, що ловить _name_consistency.py. Падає (exit 1), якщо
де-небудь UA містить ЗАБОРОНЕНУ форму там, де EN-оригінал містить власну назву.

Запуск перед релізом:  python pipeline/_canon_names_gate.py
Додавати канон у CANON: "EN-якір": ("канон UA для довідки", [regex заборонених форм]).
EN-якір шукається: у quests — в source/quests.json (title+desc en); у keyed-секціях — у ключі."""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path(__file__).resolve().parent.parent
tr = json.loads((B / "data/translations.json").read_text(encoding="utf-8-sig"))
src = json.loads((B / "data/source/quests.json").read_text(encoding="utf-8-sig"))

# EN-якір -> (канон-форма, [ЗАБОРОНЕНІ форми]). База: data/canon.json (ЛИШЕ gate=true —
# унікальні власні назви; узагальнені описові слова застосовуються до даних, але НЕ
# гейтуються у вільному тексті, бо дають хибні спрацювання: «Командирка Векая» = жінка) + Lorewalker.
_canon = json.loads((B / "data/canon.json").read_text(encoding="utf-8-sig"))
# allow_en: якщо EN-контекст містить будь-який із цих підрядків — запис НЕ гейтувати
# (кейс «Zul'jan … grandchild of Zul'jin»: обидва імені в одному рядку легітимні).
CANON = {en: (rec["canon"], rec.get("forbidden", []), rec.get("allow_en", []))
         for en, rec in _canon.items() if rec.get("gate") and rec.get("forbidden")}
# Lorewalker — окремий канон (не в canon.json, бо не в авторит. name-джерелах)
CANON["Lorewalker"] = ("Мандрівник Історіями",
                       [r"Хранител\w* Знань", r"Літопис(ець|цю|ця|цями|ців)",
                        r"Знавц\w* Знань", r"Шукач\w* Знань"], [])


def ua_fields(v):
    if isinstance(v, str):
        return [v]
    if isinstance(v, dict):
        return [v[f] for f in ("title", "description") if v.get(f)]
    return []


violations = []
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    is_quests = sec == "quests"
    for k, v in d.items():
        if not isinstance(k, str):
            continue
        # EN-контекст
        if is_quests:
            s = src.get(k, {})
            en = " ".join(str((s.get(f) or {}).get("en", "")) for f in ("title", "description"))
        else:
            en = k
        for name, (canon, forbidden, allow_en) in CANON.items():
            if name not in en:
                continue
            if any(a in en for a in allow_en):
                continue
            for txt in ua_fields(v):
                for pat in forbidden:
                    if re.search(pat, txt):
                        violations.append((name, canon, sec, k, pat))

print("=== КАНОН-ГЕЙТ ІМЕН (EN-прив'язаний) ===")
if not violations:
    print(f"OK — порушень нема ({len(CANON)} канон-правил перевірено).")
    sys.exit(0)
print(f"ПОРУШЕНЬ: {len(violations)}\n")
for name, canon, sec, k, pat in violations[:60]:
    print(f"  [{sec}] {name}→«{canon}»: заборонена форма /{pat}/ у {k!r}")
sys.exit(1)
