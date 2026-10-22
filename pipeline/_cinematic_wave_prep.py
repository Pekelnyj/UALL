# -*- coding: utf-8 -*-
"""Готує наступну хвилю кінематиків із ДЕДУПОМ: однакові кінематики (як 475=494=495)
перекладаються РАЗ. Пропускає сміття (404/таймкод-артефакти) і вже перекладене.
Запуск: python pipeline/_cinematic_wave_prep.py [N]   (N=скільки фільмів, типово 10)
Пише data/tester_new/db2gaps/cinematic/_wave10.json
"""
import json, glob, sys, re
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
N = int(sys.argv[1]) if len(sys.argv) > 1 else 10
CIN = ROOT + "/data/tester_new/db2gaps/cinematic"

pm = json.load(open(CIN + "/_per_movie.json", encoding="utf-8"))
gap = set(json.load(open(CIN + "/_subtitles.json", encoding="utf-8")).keys())
done = {}
for f in glob.glob(CIN + "/translated/batch_*.json"):
    done.update(json.load(open(f, encoding="utf-8")))

def junk(s):
    s = s.strip()
    return (s.startswith('{"error"') or (s[:3].count(":") and s.startswith("00:") and " - " in s[:25])
            or len(re.sub(r"[^A-Za-z]", "", s)) < 2)

cine = {}
for mid in sorted(pm, key=lambda x: int(x)):
    rem = [ln for ln in pm[mid] if ln in gap and ln not in done and not junk(ln)]
    if rem:
        cine[mid] = rem

# ДЕДУП: однаковий набір рядків = той самий кінематик -> лишаємо 1
seen, unique, dup = {}, {}, 0
for mid, lines in cine.items():
    sig = tuple(sorted(lines))
    if sig in seen:
        dup += 1
        continue
    seen[sig] = mid
    unique[mid] = lines

picked = dict(list(unique.items())[:N])
json.dump(picked, open(CIN + "/_wave10.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print(f"унікальних кінематиків із дірою: {len(unique)} (дублів пропущено: {dup})")
print(f"обрано в хвилю: {len(picked)} | рядків: {sum(len(v) for v in picked.values())}")
for mid, v in picked.items():
    print(f"  movie {mid}: {len(v)}")
print(f"лишиться після хвилі: {len(unique) - len(picked)} унік. кінематиків")
