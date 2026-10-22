# -*- coding: utf-8 -*-
"""Знайти рядки журналу з розбіжністю службових кодів між EN-ключем і UA, вивантажити на фікс."""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
B = Path("g:/Claude Code/WoWUkraine")
OUT = B / "data/_journal_out"

bad = []
for i in range(1, 19):
    outf = OUT / f"batch_{i:02d}.json"
    if not outf.exists():
        continue
    got = json.loads(outf.read_text(encoding="utf-8-sig"))
    for en, ua in got.items():
        if not isinstance(ua, str):
            continue
        reasons = []
        if en.count("$bullet;") != ua.count("$bullet;"):
            reasons.append(f"bullet {en.count('$bullet;')}->{ua.count('$bullet;')}")
        if en.count("\r\n") != ua.count("\r\n"):
            reasons.append(f"crlf {en.count(chr(13)+chr(10))}->{ua.count(chr(13)+chr(10))}")
        if en.count("[") != ua.count("[") or en.count("]") != ua.count("]"):
            reasons.append(f"brk [{en.count('[')}/{en.count(']')}]->[{ua.count('[')}/{ua.count(']')}]")
        if reasons:
            bad.append({"batch": i, "en": en, "ua": ua, "why": "; ".join(reasons)})

(B / "data/_journal_codefix.json").write_text(json.dumps(bad, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"Проблемних рядків: {len(bad)} -> data/_journal_codefix.json")
print("=== приклади (перші 6) ===")
for r in bad[:6]:
    print(f"\n[batch {r['batch']}] {r['why']}")
    print("EN:", repr(r["en"][:160]))
    print("UA:", repr(r["ua"][:160]))
