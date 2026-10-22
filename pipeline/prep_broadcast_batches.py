"""Батчі субтитрів/реплік (BroadcastText) з КОНТЕКСТОМ сцени.

Сусідні ID — одна сцена (промова/діалог). Кладемо сцену цілком у батч і
до кожного рядка додаємо текст усієї сцени, щоб агент перекладав у контексті.

Text_lang  — основний текст; Text1_lang — варіант під стать ГРАВЦЯ (якщо
відрізняється). Обидва йдуть на переклад.

Вхід:  data/wago/BroadcastText.enUS.latest.csv (+ de/fr для звірки)
Вихід: data/batches/broadcast/bc_NNN.json
"""

import csv
import json

from common import DATA_DIR

W = DATA_DIR / "wago"
OUT_DIR = DATA_DIR / "batches" / "broadcast"
SCENE_GAP = 3          # різниця ID у межах однієї сцени
LINES_PER_BATCH = 45


def load(loc):
    d = {}
    path = W / f"BroadcastText.{loc}.latest.csv"
    if not path.exists():
        return d
    for r in csv.DictReader(open(path, encoding="utf-8")):
        d[r["ID"]] = (r.get("Text_lang", "") or "", r.get("Text1_lang", "") or "")
    return d


def main():
    en = load("enUS")
    de = load("deDE")
    fr = load("frFR")

    rows = [(int(i), t0, t1) for i, (t0, t1) in en.items() if t0.strip()]
    rows.sort()

    # групуємо в сцени
    scenes, cur = [], [rows[0]]
    for r in rows[1:]:
        if r[0] - cur[-1][0] <= SCENE_GAP:
            cur.append(r)
        else:
            scenes.append(cur)
            cur = [r]
    scenes.append(cur)

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for old in OUT_DIR.glob("*.json"):
        old.unlink()

    batch, n, count = [], 0, 0
    for scene in scenes:
        ctx = " / ".join(t0 for _id, t0, _t1 in scene)[:600]
        for sid, t0, t1 in scene:
            item = {"id": str(sid), "en": t0, "scene": ctx}
            if t1 and t1 != t0:
                item["en_female_player"] = t1  # варіант, коли гравець-жінка
            de0 = (de.get(str(sid)) or ("", ""))[0]
            fr0 = (fr.get(str(sid)) or ("", ""))[0]
            if de0:
                item["de"] = de0
            if fr0:
                item["fr"] = fr0
            batch.append(item)
            count += 1
        if len(batch) >= LINES_PER_BATCH:
            n += 1
            (OUT_DIR / f"bc_{n:03d}.json").write_text(
                json.dumps(batch, ensure_ascii=False, indent=1), encoding="utf-8")
            batch = []
    if batch:
        n += 1
        (OUT_DIR / f"bc_{n:03d}.json").write_text(
            json.dumps(batch, ensure_ascii=False, indent=1), encoding="utf-8")

    print(f"Реплік: {count} | сцен: {len(scenes)} | батчів по ~{LINES_PER_BATCH}: {n}")


if __name__ == "__main__":
    main()
