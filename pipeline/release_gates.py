# -*- coding: utf-8 -*-
"""Гейти перед збіркою: архів не збирається, якщо бодай один блокувальний гейт червоний.

Досі гейти запускали вручну, а build_tester.py і build_public.py не перевіряли нічого
(build_release.py лише попереджав про ніки). Так у базу доїхали «Тіньовиры» і пів сотні
перекладених слеш-команд (07.10.2026). Тепер збірка спершу проганяє набір нижче.

  * BLOCKING — падіння зупиняє збірку (усі лише читають, без мережі, чесний код виходу;
    перелік звірено 07.10.2026: що кожен перевіряє, чи пише, чи має код виходу);
  * WARNING  — лише показуємо: важкі, залежать від локальних SavedVariables/testerlua
    (на іншій машині мовчки слабшають) або евристичні.

    python pipeline/release_gates.py            # окремо
    from release_gates import run_or_exit       # у скриптах збірки
"""
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
HERE = Path(__file__).resolve().parent

BLOCKING = [
    ("_ru_guard.py", []),
    ("_slash_commands_gate.py", []),
    ("_check_lua_syntax.py", []),
    ("_no_control_bytes.py", []),
    ("_no_bad_apostrophes.py", []),
    ("_check_gender_tokens.py", ["--all"]),  # без --all перевіряє лише активні батчі
    ("_check_templates.py", []),
    ("_gossip_token_gate.py", []),
    ("_check_kv_shift.py", []),
    ("_canon_names_gate.py", []),
    ("_hellscream_gate.py", []),
    ("_abundance_gate.py", []),
    ("_ohod_gate.py", []),
    ("_zabralo_gate.py", []),
    ("_slot_words_gate.py", []),
    ("_addon_safety_gate.py", []),
    ("_module_keys_gate.py", []),            # у кожного модуля свій вимикач (07.10.2026)
]
WARNING = [
    # 347 знахідок 07.10.2026 — переважно законні англійські назви в тексті («World of
    # Warcraft», назви предметів у лапках); як блокувальний зупиняв би кожну збірку
    ("_check_broken_words.py", []),
    ("_check_playernames.py", []),
    ("_check_guild_leak.py", []),
    ("_check_name_across_layers.py", []),
    ("_check_zone_pair_shift.py", []),
]


def run_one(script, args):
    t = time.perf_counter()
    p = subprocess.run([sys.executable, str(HERE / script), *args], cwd=HERE,
                       capture_output=True, text=True, encoding="utf-8", errors="replace")
    return p.returncode, (p.stdout or "") + (p.stderr or ""), time.perf_counter() - t


def run(include_warnings=True):
    """Повертає список червоних блокувальних гейтів (порожній — можна збирати)."""
    failed = []
    for group, gates in (("БЛОКУЄ", BLOCKING), ("ПОПЕРЕДЖЕННЯ", WARNING if include_warnings else [])):
        for script, args in gates:
            if not (HERE / script).exists():
                print(f"  ? {script}: файлу немає")
                if group == "БЛОКУЄ":
                    failed.append(script)
                continue
            code, out, dt = run_one(script, args)
            mark = "✓" if code == 0 else ("✗" if group == "БЛОКУЄ" else "!")
            print(f"  {mark} {script} ({dt:.0f} с)")
            if code != 0:
                tail = [l for l in out.strip().splitlines() if l.strip()][-8:]
                for line in tail:
                    print("      " + line[:200])
                if group == "БЛОКУЄ":
                    failed.append(script)
    return failed


def run_or_exit():
    print("Гейти перед збіркою:")
    failed = run()
    if failed:
        sys.exit(f"Збірку зупинено — червоні гейти: {', '.join(failed)}")
    print("Гейти зелені.")


if __name__ == "__main__":
    run_or_exit()
