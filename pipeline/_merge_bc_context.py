# -*- coding: utf-8 -*-
"""Звести виходи хвилі з ПАКЕТАМИ ДОКАЗІВ (out_ctx_NN.json) у broadcast_out.json.

Пара до _prep_bc_context.py. Чому окремо від _merge_broadcast_wave.py: той
звіряє out_NN.json із bc_NN.json один-до-одного, а порції ctx_* нарізано
наскрізь по черзі (--take/--parts), тож межі файлів не збігаються — пряме
злиття там би хибно звітувало про пропуски.

Перевірки (рядок, що не пройшов, НЕ йде в вихід, причина — у звіті):
  • ключа немає в черзі bc_*.json (значить, агент його вигадав або зіпсував);
  • переклад без кирилиці / порожній;
  • набір розмітки й підстановок (|c |r |T |A |H, |4…;, {NAME}, %s, \\n) не той;
  • той самий ключ у двох файлах із РІЗНИМ перекладом.

Запуск: python _merge_bc_context.py [--apply]
Далі:   python _inject_broadcast.py  &&  python _sync_broadcast_master.py
"""
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

APPLY = "--apply" in sys.argv
B = DATA_DIR / "batches" / "broadcast"
OUT = DATA_DIR / "tester_new" / "broadcast_out.json"
CYR = re.compile("[А-Яа-яІіЇїЄєҐґ]")
TOK = re.compile(r"\|c[0-9A-Fa-f]{8}|\|r|\|T[^|]*\|t|\|A[^|]*\|a|\|H[^|]*\|h|\|h"
                 r"|\{NAME\}|%[sd]|\n|\r")

queue = set()
for f in sorted(B.glob("bc_*.json")):
    for it in json.loads(f.read_text(encoding="utf-8")):
        queue.add(it["en"] if isinstance(it, dict) else it)

merged, rej = {}, []
for f in sorted(B.glob("out_ctx_*.json")):
    try:
        d = json.loads(f.read_text(encoding="utf-8-sig"))
    except ValueError as e:
        print(f"!! {f.name}: невалідний JSON — {e}")
        continue
    for en, ua in d.items():
        if en not in queue:
            rej.append((f.name, "ключа нема в черзі", en))
            continue
        if not isinstance(ua, str) or not ua.strip() or not CYR.search(ua):
            rej.append((f.name, "без кирилиці", en))
            continue
        if sorted(TOK.findall(en)) != sorted(TOK.findall(ua)):
            rej.append((f.name, "розмітка/підстановки", en))
            continue
        if en in merged and merged[en] != ua:
            rej.append((f.name, "колізія з іншим файлом", en))
            continue
        merged[en] = ua

print(f"прийнято: {len(merged)} | відхилено: {len(rej)}")
for fn, why, en in rej[:20]:
    print(f"   {fn}: {why} -> «{en[:70]}»")
if not APPLY:
    print("\nЧЕРНЕТКА — нічого не записано, додай --apply")
    sys.exit(0)
OUT.parent.mkdir(parents=True, exist_ok=True)
OUT.write_text(json.dumps(merged, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\n{OUT} записано ({len(merged)})")
print("Далі: python _inject_broadcast.py && python _sync_broadcast_master.py")
