# -*- coding: utf-8 -*-
# Разово: додає досягнення 63343 «Goal!» (нове в патчі 12.0.7) у translations.json.
import json, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")
p = Path(__file__).resolve().parent.parent / "data" / "translations.json"
tr = json.loads(p.read_text(encoding="utf-8-sig"))
ach = tr.setdefault("achievements", {})
ach["63343"] = {
    "title": "Гол!",
    # назви предметів лишаємо англ. Title Case (правило проєкту); Silvermoon→Сільвермун
    "desc": "Забий гол м'ячем Kickable Practice Ball у Сільвермуні, "
            "маючи вдягнену Tabard of Participation.",
}
p.write_text(json.dumps(tr, ensure_ascii=False, indent=1), encoding="utf-8")
print("Додано ачівку 63343:", ach["63343"]["title"])
