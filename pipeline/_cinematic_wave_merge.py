# -*- coding: utf-8 -*-
"""Обробка результату хвилі кінематиків: парс -> зведення розбіжностей -> канон-фікс
-> наступний batch_NNN.json. Дедуп на вході (wave_prep) вже прибрав дублі-кінематики,
тож конфліктів тут мало; ті, що лишились, друкуються для ревʼю.
Запуск: python pipeline/_cinematic_wave_merge.py "<шлях output-файлу хвилі>"
"""
import json, sys, re, glob, os
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
CIN = ROOT + "/data/tester_new/db2gaps/cinematic/translated"
out_path = sys.argv[1]

data = json.load(open(out_path, encoding="utf-8"))
films = []
for it in data.get("result", []):
    t = it.get("translated")
    if isinstance(t, str):
        try: t = json.loads(t)
        except Exception: continue
    if not isinstance(t, dict):
        continue
    # відкинути «відхилені»/порожні структури (status/summary/result-обгортка/порожнє)
    if (not t or any(k in t for k in ("status", "summary", "corrected_json", "result"))
            or not all(isinstance(v, str) for v in t.values())):
        print(f"  ⚠️ фільм {it.get('id')}: НЕ чистий {{EN:UA}} (агент відхилився/порожньо) — ПРОПУЩЕНО")
        continue
    films.append((it.get("id", "?"), t))

# перший фільм (за ID) виграє; відкидаємо ключі-артефакти з суфіксом _dup
merged = {}
for fid, t in sorted(films, key=lambda x: int(x[0]) if str(x[0]).isdigit() else 0):
    for en, ua in t.items():
        if en.endswith("_dup"):
            continue
        merged.setdefault(en, ua)

# глобальні канон-фікси написань (страховка консистентності між хвилями)
SPELL = [("бенші", "банші"), ("баньші", "банші"), ("Джейн", "Джайн"), ("Расзагет", "Расзаґет"),
         ("Фʼюрак", "Фірак"), ("Фіррак", "Фірак"), ("Алері", "Аллері"),
         ("Дімензіус", "Дименсіус"), ("Дімензіу", "Дименсіу")]
for en in list(merged):
    for a, b in SPELL:
        merged[en] = merged[en].replace(a, b)

# лишкові розбіжності (та сама англ-фраза, різний переклад між фільмами)
byen = {}
for fid, t in films:
    for en, ua in t.items():
        byen.setdefault(en, {}).setdefault(ua, []).append(fid)
conf = {en: d for en, d in byen.items() if len(d) > 1}
if conf:
    print(f"⚠️ лишкових розбіжностей: {len(conf)} (взято перший фільм; перевір):")
    for en, d in list(conf.items())[:12]:
        print(f"   «{en[:45]}»: " + " | ".join(f"{u[:35]!r}" for u in d))

# канон-гейт
BAD = re.compile(r"Пекельн\w* Крик|Пеклокрик|Смертокрил|Вітрогін|навальн", re.I)
viol = [(k, v) for k, v in merged.items() if BAD.search(v)]
print(f"порушень канону: {len(viol)}", [v[:40] for _, v in viol[:5]])

# наступний batch номер
nums = [int(re.search(r"batch_(\d+)", f).group(1)) for f in glob.glob(CIN + "/batch_*.json")]
n = (max(nums) + 1) if nums else 1
dst = f"{CIN}/batch_{n:03d}.json"
json.dump(merged, open(dst, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"збережено {os.path.basename(dst)}: {len(merged)} рядків")
