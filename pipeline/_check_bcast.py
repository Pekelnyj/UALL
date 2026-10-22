# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

bl = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua").read_text(encoding="utf-8")
print("всього записів у Broadcast.lua:", bl.count('] = "'))
for probe in ["delicate art", "Terminas", "imbue the"]:
    print(f"  '{probe}' у Broadcast.lua?", probe in bl)


def esc(s):
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r"))


live = json.loads((DATA_DIR / "tester_all" / "broadcast_live.json").read_text(encoding="utf-8-sig"))
already = sum(1 for t in live if '["' + esc(t) + '"]' in bl)
real_new = [t for t in live if '["' + esc(t) + '"]' not in bl]
print(f"з {len(live)} live: ВЖЕ в Broadcast.lua={already} | реально нових={len(real_new)}")
# скільки з реально нових — генеричні %s-емоції/системні
import re
sys_like = [t for t in real_new if t.startswith("%s") or "%s " in t[:6] or re.match(r"^[A-Z ]+!$", t)]
dialogue = [t for t in real_new if t not in sys_like]
print(f"   з них %s-системні/емоції={len(sys_like)} | схожі на діалог={len(dialogue)}")
json.dump(dialogue, open(DATA_DIR / "tester_all" / "broadcast_realnew.json", "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
for t in dialogue[:12]:
    print("      ", repr(t[:75]))
