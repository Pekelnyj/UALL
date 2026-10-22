# -*- coding: utf-8 -*-
"""Зняти ключі з СУФІКСОМ РЕАЛМУ — це завжди гравець або гільдія.

«Ім'я-Реалм» гра пише лише для персонажів інших гравців. Доказ не потребує
ні списку ніків, ні датамайну: формат сам по собі однозначний
[[guild-names-never-translate]].

Це важливо саме тому, що відсутність у creatures.json НІЧОГО не доводить:
наш датамайн має ~23 тис. записів і дірявий — «Clive DelGizmo» у ньому немає,
хоча це справжній ґном із Мехагона. Тож масово знімати «за відсутністю» не
можна, а за суфіксом реалму — можна.

Побічно лікує другу ваду: у двох таких рядках переклад ще й ЧУЖИЙ
(«Leader: Gvenne-Sanguino» -> «Танлонські Степи, Застава Лонґїн») — класична
підміна ключ↔значення [[kv-shift-substitution]].

Запуск: python _drop_realm_keys.py [--apply]
"""
import io
import json
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR
from playernames import known_realms

APPLY = "--apply" in sys.argv
P = DATA_DIR / "translations.json"
tr = json.loads(P.read_text(encoding="utf-8-sig"))
REALMS = known_realms() | {"Aggra(Português)"}
# Перед дефісом мусить стояти ім'я (2+ літери), дефіс одинарний — інакше
# «Your father--Turalyon--» читалося б як «ім'я-реалм».
RX = re.compile(r"(?<!-)\b\w{2,}-(?:%s)\b"
                % "|".join(re.escape(r) for r in sorted(REALMS)))

drop = []
for sec, d in tr.items():
    if not isinstance(d, dict):
        continue
    for k in list(d):
        if isinstance(k, str) and RX.search(k):
            drop.append((sec, k))

print(f"реалмів у наборі: {len(REALMS)}")
print(f"ключів із суфіксом реалму: {len(drop)}")
for sec, k in drop:
    v = tr[sec][k]
    ua = v if isinstance(v, str) else (v.get("ua") if isinstance(v, dict) else "")
    print(f"  [{sec}] {k[:60]}")
    print(f"        -> {(ua or '')[:60]}")

if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
for sec, k in drop:
    tr[sec].pop(k, None)
io.open(P, "w", encoding="utf-8", newline="\n").write(
    json.dumps(tr, ensure_ascii=False, indent=1))
print(f"\nзнято {len(drop)}")
