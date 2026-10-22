"""Аналіз файлу збору від тестера: скільки зібрано і скільки НОВОГО на переклад.

Використання: python analyze_tester_capture.py "<шлях до WoWUkraine (N).lua>"
"""

import json
import re
import sys

from luaparser import ast, astnodes

from common import DATA_DIR

CYR = re.compile(r"[Ѐ-ӿ]")


def kv(n):
    if isinstance(n, astnodes.String):
        return n.s.decode("utf-8", "replace") if isinstance(n.s, bytes) else n.s
    if isinstance(n, astnodes.Number):
        return int(n.n)
    return None


def W(x):
    return len(x.split())


def main():
    path = sys.argv[1]
    raw = open(path, encoding="utf-8", errors="replace").read()
    tree = ast.parse(raw)
    blk = {"gossip": [], "broadcast": [], "quests": [], "spellCapture": []}
    errors = re.findall(r'"(\d\d:\d\d:\d\d[^"]*(?:ПОМИЛКА|attempt)[^"]*)"', raw)
    for node in ast.walk(tree):
        if isinstance(node, astnodes.Assign):
            for t, v in zip(node.targets, node.values):
                if getattr(t, "id", None) in ("UALLCaptureDB", "WoWUkraineCaptureDB") and isinstance(v, astnodes.Table):
                    for f in v.fields:
                        k = kv(f.key)
                        if k in blk and isinstance(f.value, astnodes.Table):
                            for g in f.value.fields:
                                kk = kv(g.key)
                                if kk is not None:
                                    blk[k].append((kk, g.value))

    tr = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    src = json.loads((DATA_DIR / "source" / "spells.json").read_text(encoding="utf-8-sig"))
    bl = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")

    # gossip нове (не перекладено, не кирилиця/сміття)
    gdone = set(tr.get("gossip", {}))
    gnew = [k for k, _ in blk["gossip"] if k not in gdone and not CYR.search(k)]
    # broadcast нове
    bnew = [k for k, _ in blk["broadcast"]
            if ('["' + k.replace('"', '\\"') + '"]') not in bl and not CYR.search(k)]
    # закляття
    spdone = set(tr.get("spells", {}))
    dtdone = set(tr.get("descTemplates", {}))
    spids = [k for k, _ in blk["spellCapture"]]
    spnew = [i for i in spids if str(i) not in spdone]
    descnew = sum(1 for i in spids
                  if (src.get(str(i), {}).get("description", {}) or {}).get("en")
                  and (src[str(i)]["description"]["en"] not in dtdone))
    # квести: нові серверні поля
    qtr = tr.get("quests", {})
    qfields = qwords = 0
    for qid, tbl in blk["quests"]:
        have = qtr.get(str(qid), {})
        if isinstance(tbl, astnodes.Table):
            for fld in tbl.fields:
                fn = kv(fld.key)
                fv = fld.value.s.decode("utf-8", "replace") if isinstance(getattr(fld.value, "s", None), bytes) \
                    else getattr(fld.value, "s", None)
                if fn in ("progress", "completion", "objectives") and fv and not have.get(fn):
                    qfields += 1
                    qwords += W(fv)

    print(f"=== {path.split(chr(92))[-1]} ===")
    print(f"помилок у лозі: {len(errors)}")
    print(f"gossip: {len(blk['gossip'])} зібрано | {len(gnew)} НОВИХ | ~{sum(W(t) for t in gnew)} слів")
    print(f"субтитри: {len(blk['broadcast'])} зібрано | {len(bnew)} НОВИХ | ~{sum(W(t) for t in bnew)} слів")
    print(f"закляття: {len(spids)} зібрано | назв нових {len(spnew)} | описів нових {descnew}")
    print(f"квести: {len(blk['quests'])} зібрано | нових серверних полів {qfields} | ~{qwords} слів")


if __name__ == "__main__":
    main()
