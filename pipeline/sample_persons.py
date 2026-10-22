"""Вибірка ~100 поточних 2-слівних імен-персонажів із NpcNames.lua для аудиту якості."""
import re, json
from common import DATA_DIR

LUA = (DATA_DIR.parent / "addon" / "UALL" / "Database" / "NpcNames.lua").read_text(encoding="utf-8")
pairs = re.findall(r'\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"', LUA)

DESC = set("""adolescent aggressive agitated ageless albino alert ancient wild young elder feral
rabid crazed savage vicious fierce giant enraged corrupted devouring roaming wandering buzzing
furious mud fungal dark deep the of and lesser greater royal high lord lady""".split())

persons = []
for en, ua in pairs:
    w = en.split()
    if (len(w) == 2 and w[0][:1].isupper() and w[1][:1].isupper()
            and w[0].lower() not in DESC and not w[0].lower().endswith("ing")):
        persons.append((en.replace('\\"', '"'), ua.replace('\\"', '"')))

step = max(1, len(persons) // 100)
sample = {en: ua for en, ua in persons[::step]}
(DATA_DIR / "_audit_sample.json").write_text(json.dumps(sample, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"персонажів усього: {len(persons)} | у вибірці: {len(sample)}")
