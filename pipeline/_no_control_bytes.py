# -*- coding: utf-8 -*-
"""ГЕЙТ: жодних control-байтів (окрім \\t \\n \\r) у translations.json та згенерованих
Database/*.lua. Такий байт (напр. \\x01) рендериться в грі як «тофу»-квадрат — саме так
«Кіраса» показувалася як «□іраса». Ловимо наперед, бо очима в 130k рядків не побачиш.
Запуск перед мерджем/релізом: python pipeline/_no_control_bytes.py
"""
from pathlib import Path
import sys, re, glob, os
sys.stdout.reconfigure(encoding="utf-8")
ROOT = str(Path(__file__).resolve().parent.parent)
# U+FFFD (replacement character) сюди ж: він з'являється, коли текст десь
# пройшов через хибне декодування, і в грі виглядає точно таким самим
# «тофу»-квадратом, як control-байт. Очима його не відрізниш від літери —
# у цій хвилі так утворилося «реміснич□ої».
CTRL = re.compile(r"[\x00-\x08\x0b\x0c\x0e-\x1f�]")

targets = [ROOT + "/data/translations.json"]
targets += glob.glob(ROOT + "/addon/UALL/Database/*.lua")
targets += glob.glob(ROOT + "/addon/UALL_Items/Items_*.lua")
# бази журналу й імен теж ідуть в архів (07.10.2026: раніше не перевірялись)
targets += glob.glob(ROOT + "/addon/UALL_Journal/*.lua")
targets += glob.glob(ROOT + "/addon/UALL_NpcNames/*.lua")

bad = []
for f in targets:
    try:
        t = open(f, encoding="utf-8", errors="replace").read()
    except Exception:
        continue
    n = len(CTRL.findall(t))
    if n:
        # знайти перший приклад із контекстом
        m = CTRL.search(t)
        ctx = t[max(0, m.start() - 25): m.start() + 25].replace(t[m.start()], "[CTRL]")
        bad.append((os.path.basename(f), n, ctx))

if bad:
    print(f"❌ ГЕЙТ CONTROL-БАЙТІВ: {len(bad)} файлів із tofu-символами")
    for name, n, ctx in bad:
        print(f"   {name}: {n}  напр. …{ctx}…")
    sys.exit(1)
print("✅ ГЕЙТ CONTROL-БАЙТІВ: чисто (жодного tofu-символу).")
