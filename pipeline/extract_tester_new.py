"""Витяг НОВОГО (неперекладеного) з файлу тестера у батч для перекладу.
Використання: python extract_tester_new.py "<шлях до WoWUkraine (N).lua>"
Пише data/_tester_new.json: {npcNames:{id:en}, gossip:[en], broadcast:[en]}
"""
import json, re, sys
from luaparser import ast, astnodes
from common import DATA_DIR

CYR = re.compile("[Ѐ-ӿ]")


def kv(n):
    if isinstance(n, astnodes.String):
        return n.s.decode("utf-8", "replace") if isinstance(n.s, bytes) else n.s
    if isinstance(n, astnodes.Number):
        return int(n.n)
    return None


def main():
    path = sys.argv[1]
    raw = open(path, encoding="utf-8", errors="replace").read()
    tree = ast.parse(raw)
    blk = {"gossip": [], "broadcast": [], "npc": [], "objLines": []}
    for node in ast.walk(tree):
        if isinstance(node, astnodes.Assign):
            for t, v in zip(node.targets, node.values):
                if getattr(t, "id", None) in ("UALLCaptureDB", "WoWUkraineCaptureDB") and isinstance(v, astnodes.Table):
                    for f in v.fields:
                        k = kv(f.key)
                        if k in blk and isinstance(f.value, astnodes.Table):
                            for g in f.value.fields:
                                blk[k].append((kv(g.key), kv(g.value)))

    T = json.loads((DATA_DIR / "translations.json").read_text(encoding="utf-8-sig"))
    bl = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")

    have_npc = set(T.get("npcNames", {}))
    npc_new = {str(i): n for i, n in blk["npc"]
               if str(i) not in have_npc and isinstance(n, str) and not CYR.search(n)}

    # ВИТІК ПРИВАТНОСТІ: делв-надгробки з іменами ЧУЖИХ гравців
    # («R.I.P. Here lies <Нік-Реалм>, valiantly slain by <моб>») — НІКОЛИ не в аддон:
    # текст пер-гравцевий (не зматчиться), а ще й показує ніки інших людей. Відсіюємо
    # на зборі, щоб не витрачати переклад і не тягнути це в базу.
    LEAK = re.compile(r"Here lies .+ valiantly slain|^\s*R\.I\.P\.", re.I)

    have_g = set(T.get("gossip", {}))
    gossip_new = sorted({k for k, _ in blk["gossip"]
                         if isinstance(k, str) and k not in have_g and not CYR.search(k)
                         and not LEAK.search(k)})

    bc_new = sorted({t for t, _ in blk["broadcast"]
                     if isinstance(t, str) and ('["' + t.replace('"', '\\"') + '"]') not in bl
                     and not CYR.search(t) and not LEAK.search(t)})

    # objLines: рядки трекера цілей (["текст"]=true). Нові — нема в QuestObjectives.lua.
    qo = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "QuestObjectives.lua").read_text(encoding="utf-8")
    obj_new = sorted({t for t, _ in blk["objLines"]
                      if isinstance(t, str) and ('["' + t.replace('"', '\\"') + '"]') not in qo
                      and not CYR.search(t) and re.search("[A-Za-z]", t)})

    out = {"npcNames": npc_new, "gossip": gossip_new, "broadcast": bc_new, "objLines": obj_new}
    (DATA_DIR / "_tester_new.json").write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"npc нових: {len(npc_new)} | gossip нових: {len(gossip_new)} | broadcast нових: {len(bc_new)}")
    for i, (k, v) in enumerate(npc_new.items()):
        if i >= 15:
            break
        print(f"  {k}: {v}")


if __name__ == "__main__":
    main()
