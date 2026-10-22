# -*- coding: utf-8 -*-
"""Виявляє застарілі (заглушкові) описи квестів: порівнює живий Blizzard API з нашим
екстрактом для Midnight-діапазону. Stale = текст у API відрізняється від нашого."""
import os, json, sys, time, requests
from concurrent.futures import ThreadPoolExecutor, as_completed
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"g:/Claude Code/WoWUkraine"
THRESHOLD = int(sys.argv[1]) if len(sys.argv) > 1 else 88000
REGION = "us"

cid = os.environ["BLIZZARD_CLIENT_ID"]; cs = os.environ["BLIZZARD_CLIENT_SECRET"]
token = requests.post("https://oauth.battle.net/token",
                      data={"grant_type": "client_credentials"}, auth=(cid, cs)).json()["access_token"]
HDR = {"Authorization": f"Bearer {token}"}
PARAMS = {"namespace": f"static-{REGION}", "locale": "en_US"}

src = json.load(open(ROOT + "/data/source/quests.json", encoding="utf-8-sig"))
ids = sorted(int(q) for q in src if q.isdigit() and int(q) >= THRESHOLD)
print(f"перевіряю {len(ids)} квестів (ID >= {THRESHOLD})...", flush=True)

def norm(s): return " ".join((s or "").split())
def stored_desc(qid):
    v = src.get(str(qid), {}).get("description", {})
    return v.get("en", "") if isinstance(v, dict) else (v or "")

sess = requests.Session(); sess.headers.update(HDR)
stale = {}; gone = []; errors = 0; checked = 0
def fetch(qid):
    for attempt in range(3):
        try:
            r = sess.get(f"https://{REGION}.api.blizzard.com/data/wow/quest/{qid}",
                         params=PARAMS, timeout=20)
            if r.status_code == 200:
                return qid, r.json().get("description", "")
            if r.status_code == 404:
                return qid, None
            if r.status_code == 429:
                time.sleep(1.0); continue
            return qid, "__ERR__"
        except Exception:
            time.sleep(0.5)
    return qid, "__ERR__"

with ThreadPoolExecutor(max_workers=14) as ex:
    futs = {ex.submit(fetch, q): q for q in ids}
    for f in as_completed(futs):
        qid, live = f.result(); checked += 1
        if checked % 300 == 0: print(f"  ...{checked}/{len(ids)}", flush=True)
        if live is None: gone.append(qid); continue
        if live == "__ERR__": errors += 1; continue
        ours = stored_desc(qid)
        if norm(live) != norm(ours):
            stale[str(qid)] = {"live": live, "ours": ours,
                               "len_live": len(live), "len_ours": len(ours)}

# зберегти
out = {q: v["live"] for q, v in stale.items()}
json.dump(out, open(ROOT + "/data/source/_stale_live_desc.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"\n=== РЕЗУЛЬТАТ ===")
print(f"перевірено: {checked} | застарілих (live≠наш): {len(stale)} | видалених(404): {len(gone)} | помилок: {errors}")
# скільки з них реально заглушки (наш набагато коротший)
ph = sum(1 for v in stale.values() if v["len_ours"] < v["len_live"] * 0.6)
print(f"з них явні заглушки (наш <60% довжини live): {ph}")
print("\nприклади:")
for q, v in list(stale.items())[:8]:
    t = src.get(q, {}).get("title", {}); t = t.get("en", "") if isinstance(t, dict) else t
    print(f"  {q} «{t}»: наш {v['len_ours']} -> live {v['len_live']}")
