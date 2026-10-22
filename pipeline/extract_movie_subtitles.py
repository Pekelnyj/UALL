# -*- coding: utf-8 -*-
"""Видобуток субтитрів кінематиків зі .sbt-файлів (Movie.SubtitleFileDataID).
wago.tools проксить файли по FileDataID: https://wago.tools/api/casc/<fdid>
.sbt-формат: блоки «TIMECODE - TIMECODE\\n<текст>\\n\\n». Тягнемо текст (без таймкодів),
рахуємо діру vs наша база, стейджимо у data/tester_new/db2gaps/cinematic/.

Запуск: python pipeline/extract_movie_subtitles.py [build]
"""
import sys, csv, io, json, re, os
sys.stdout.reconfigure(encoding="utf-8")
import requests
from concurrent.futures import ThreadPoolExecutor, as_completed

ROOT = r"g:/Claude Code/WoWUkraine"
BUILD = sys.argv[1] if len(sys.argv) > 1 else "12.1.0.68301"
tr = json.load(open(ROOT + "/data/translations.json", encoding="utf-8-sig"))
ALL = set()
for v in tr.values():
    if isinstance(v, dict):
        ALL |= set(v.keys())

TC = re.compile(r"^\d{1,2}:\d{2}:\d{2}[:.]\d{1,3}\s*-\s*\d{1,2}:\d{2}:\d{2}[:.]\d{1,3}\s*$")
# SRT-варіант (новіші ролики): "N" + "HH:MM:SS,mmm --> HH:MM:SS,mmm"
SRT_IDX = re.compile(r"^\d{1,4}$")
SRT_TC = re.compile(r"^\d{1,2}:\d{2}:\d{2}[,.]\d{1,3}\s*-->\s*\d{1,2}:\d{2}:\d{2}[,.]\d{1,3}\s*$")
# таймкод, приклеєний до тексту в тому ж рядку: "TC - TC, текст"
TC_PREFIX = re.compile(r"^\d{1,2}:\d{2}:\d{2}[:.]\d{1,3}\s*-\s*\d{1,2}:\d{2}:\d{2}[:.]\d{1,3}\s*[,;]?\s*")

def parse_sbt(text):
    """Повертає список текстових рядків (склеює багаторядкові блоки в один субтитр)."""
    out, cur = [], []
    for ln in text.replace("\r\n", "\n").split("\n"):
        s = ln.strip("﻿").strip()
        if not s:
            if cur: out.append(" ".join(cur)); cur = []
            continue
        if TC.match(s) or SRT_TC.match(s) or SRT_IDX.match(s):  # таймкод/індекс = межа блоку
            if cur: out.append(" ".join(cur)); cur = []
            continue
        s = TC_PREFIX.sub("", s)  # відліпити таймкод, приклеєний до тексту
        if s: cur.append(s)
    if cur: out.append(" ".join(cur))
    return out

# 1) Movie -> FileDataID
r = requests.get(f"https://wago.tools/db2/Movie/csv?locale=enUS&build={BUILD}", timeout=60)
rows = list(csv.DictReader(io.StringIO(r.text)))
fdids = [(row["ID"], row.get("SubtitleFileDataID", "0")) for row in rows]
fdids = [(mid, f) for mid, f in fdids if f and f != "0"]
print(f"фільмів із .sbt: {len(fdids)}")

# 2) тягнемо .sbt
def fetch(item):
    mid, fdid = item
    try:
        rr = requests.get(f"https://wago.tools/api/casc/{fdid}", timeout=15)
        if rr.status_code != 200 or rr.text.startswith("<!DOCTYPE"):
            return (mid, fdid, None)
        return (mid, fdid, parse_sbt(rr.text))
    except Exception:
        return (mid, fdid, None)

per_movie = {}
todo = list(fdids)
for attempt in range(1, 5):
    fails = []
    with ThreadPoolExecutor(max_workers=16) as ex:
        for mid, fdid, lines in ex.map(fetch, todo):
            if lines is None: fails.append((mid, fdid)); continue
            per_movie[mid] = lines
    print(f"  спроба {attempt}: ok={len(per_movie)} fail={len(fails)}", flush=True)
    if not fails: break
    todo = fails

uniq = {}
for mid, lines in per_movie.items():
    for ln in lines:
        if len(re.sub(r"[^A-Za-z]", "", ln)) >= 4:
            uniq.setdefault(ln, mid)
gap = [ln for ln in uniq if ln not in ALL]

print(f"завантажено: {len(per_movie)} | помилок: {len(fails)}")
print(f"унікальних субтитр-рядків: {len(uniq)}")
print(f"вже в базі: {len(uniq)-len(gap)} | ДІРА: {len(gap)}")
print("\nприклади діри:")
for ln in gap[:8]:
    print("  ", repr(ln[:90]))

out = ROOT + "/data/tester_new/db2gaps/cinematic"
os.makedirs(out, exist_ok=True)
json.dump({ln: "" for ln in gap}, open(out + "/_subtitles.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
# збережемо й per-movie мапу (для хука: movieID -> рядки в порядку)
json.dump(per_movie, open(out + "/_per_movie.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"\nзбережено: {out}/_subtitles.json (діра {len(gap)}), _per_movie.json ({len(per_movie)} фільмів)")
