# -*- coding: utf-8 -*-
import sys, json, re
sys.stdout.reconfigure(encoding="utf-8")
from common import DATA_DIR

_COMBINING = re.compile("[̀-ͯ]")  # наголоси — тофу в кінематик-шрифті

DB = DATA_DIR.parent / "addon" / "UALL" / "Database" / "Broadcast.lua"
bo = json.load(open(DATA_DIR / "tester_new" / "broadcast_out.json", encoding="utf-8-sig"))
lua = DB.read_text(encoding="utf-8")


def esc(s):
    s = _COMBINING.sub("", s)
    return (s.replace("\\", "\\\\").replace('"', '\\"')
             .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t"))


# дедуп: пропустити ті, чий ключ уже є
lines = []
added = 0
for en, ua in bo.items():
    key = '["' + esc(en) + '"]'
    if key in lua:
        continue
    lines.append(f'    {key} = "{esc(ua)}",\n')
    added += 1

# вставити перед останньою '}'
idx = lua.rstrip().rfind("}")
new = lua[:idx] + "".join(lines) + lua[idx:]
DB.write_text(new, encoding="utf-8")
print(f"broadcast вставлено: {added} | дублів пропущено: {len(bo) - added}")
# баланс дужок
print("баланс {}:", "OK" if new.count("{") == new.count("}") else "ДИСБАЛАНС")
