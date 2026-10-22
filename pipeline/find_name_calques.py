import json, re, os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
T = json.load(open(os.path.join(ROOT, "data", "translations.json"), encoding="utf-8"))

# морфеми англ. імен -> описова укр. калька (ознака НЕ-транслітерації власної назви)
CALQUE = {
    "Dawn":  ["Світанк", "Світанков", "Зор"],
    "blaze": ["полум", "Полум"],
    "blood": ["кров", "Кров"],
    "star":  ["Зор", "зор"],
    "song":  ["Спів", "спів"],
    "fury":  ["Лют", "лют"],
    "fire":  ["Вогн", "вогн"],
    "wind":  ["Вітр", "вітр"],
    "sun":   ["Сонц", "сонц"],
    "shade": ["Тін", "тін"],
    "moon":  ["Місяч", "Місяц"],
    "whisper":["Шепіт", "шепіт"],
    "weaver":["Ткач", "ткач"],
    "runner":["Бігун", "бігун"],
}
# власне ім'я: слово з великої, що містить морфему (Dawnblood, Dawnstar, Sunfury...)
EN_KEYED = ["questObjectives", "gossip", "itemNames", "itemFlavors",
            "achievements", "spells"]

name_word = re.compile(r"\b([A-Z][a-z]+(?:" + "|".join(re.escape(m) for m in
            ["blood","blaze","star","song","fury","fire","wind","sun","shade",
             "moon","whisper","weaver","runner"]) + r"))\b")
dawn_word = re.compile(r"\b(Dawn[a-z]+)\b")

found = {}
for sec in EN_KEYED:
    for k, v in T.get(sec, {}).items():
        if not (isinstance(k, str) and isinstance(v, str)):
            continue
        names = set(name_word.findall(k)) | set(dawn_word.findall(k))
        for nm in names:
            # морфеми цього імені
            low = nm.lower()
            calqued = False
            for morph, uas in CALQUE.items():
                if morph.lower() in low:
                    for u in uas:
                        if u in v:
                            calqued = True
                            break
                if calqued:
                    break
            if calqued:
                found.setdefault(nm, set()).add(f"[{sec}] {k}  ->  {v}")

print("імен з описовою калькою:", len(found))
lines = []
for nm in sorted(found):
    lines.append(f"=== {nm} ===")
    for ex in sorted(found[nm])[:3]:
        lines.append("   " + ex)
open(os.path.join(ROOT, "data", "_name_calques.txt"), "w", encoding="utf-8").write("\n".join(lines))
print("written -> data/_name_calques.txt")
for nm in sorted(found):
    print(" ", nm)
