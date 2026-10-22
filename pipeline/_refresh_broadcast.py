# -*- coding: utf-8 -*-
"""Перекачати BroadcastText під ТОЧНИЙ живий білд (en+de+fr), звірити дельту."""
import sys
sys.stdout.reconfigure(encoding="utf-8")
from extract_wago import download_csv
import csv, io
from common import DATA_DIR

BUILD = "12.0.7.68256"
W = DATA_DIR / "wago"


def texts(csv_text):
    d = {}
    for r in csv.DictReader(io.StringIO(csv_text)):
        t = (r.get("Text_lang", "") or "").strip()
        if t:
            d[r["ID"]] = t
    return d


# en під живий білд
en_new = download_csv("BroadcastText", "enUS", BUILD)
(W / f"BroadcastText.enUS.{BUILD}.csv").write_text(en_new, encoding="utf-8")
de_new = download_csv("BroadcastText", "deDE", BUILD)
(W / f"BroadcastText.deDE.{BUILD}.csv").write_text(de_new, encoding="utf-8")
fr_new = download_csv("BroadcastText", "frFR", BUILD)
(W / f"BroadcastText.frFR.{BUILD}.csv").write_text(fr_new, encoding="utf-8")

en = texts(en_new)
de = texts(de_new)
fr = texts(fr_new)
old = texts((W / "BroadcastText.enUS.latest.csv").read_text(encoding="utf-8"))

bl = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")
new_ids = [i for i in en if i not in old]
untranslated = [i for i in en if en[i] not in bl]
print(f"білд {BUILD}: en={len(en)} de={len(de)} fr={len(fr)}")
print(f"old(.latest Jun10) en={len(old)} | НОВИХ ID проти old={len(new_ids)}")
print(f"НЕ в Broadcast.lua (на переклад)={len(untranslated)}")
print("forge-сцена є?", any("delicate art" in t or "Void brazier" in t for t in en.values()))
for i in untranslated[:8]:
    print("   ", i, repr(en[i][:60]))
