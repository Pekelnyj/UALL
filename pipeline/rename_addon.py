"""Перейменування аддона. Назва живе ТІЛЬКИ в імені папки/файлів аддона —
весь Lua-код і пайплайн підлаштовуються автоматично.

Використання:
    python rename_addon.py НоваНазва

Що робить:
    addon/<Стара>/            -> addon/<Нова>/
    addon/<Нова>/<Стара>.toc  -> <Нова>.toc (+ оновлює ## Title і ## SavedVariables)

Після перейменування:
    - оновіть симлінк/копію в Interface\\AddOns (стара папка там лишиться зі старою назвою);
    - старий файл WTF\\...\\SavedVariables\\<Стара>.lua можна перейменувати
      на <Нова>.lua, щоб не втратити вже зібрані тексти.
"""

import re
import sys

from common import find_addon_dir


def main():
    if len(sys.argv) != 2:
        sys.exit("Використання: python rename_addon.py НоваНазва")
    new_name = sys.argv[1]
    if not re.fullmatch(r"[A-Za-z][A-Za-z0-9_]*", new_name):
        sys.exit("Назва має складатися з латинських літер/цифр і починатися з літери "
                 "(вимога до імен папок аддонів та глобальних змінних Lua).")

    addon_dir = find_addon_dir()
    old_name = addon_dir.name
    if old_name == new_name:
        sys.exit(f"Аддон уже називається {new_name}.")

    # 1. Перейменувати .toc і оновити його вміст.
    old_toc = addon_dir / f"{old_name}.toc"
    text = old_toc.read_text(encoding="utf-8-sig")
    text = re.sub(r"^(## Title:).*$", rf"\1 {new_name}", text, flags=re.M)
    text = re.sub(r"^(## SavedVariables:).*$",
                  rf"\1 {new_name}CaptureDB, {new_name}SettingsDB", text, flags=re.M)
    old_toc.write_text(text, encoding="utf-8")
    old_toc.rename(addon_dir / f"{new_name}.toc")

    # 2. Перейменувати папку аддона.
    new_dir = addon_dir.parent / new_name
    addon_dir.rename(new_dir)

    print(f"Перейменовано: {old_name} -> {new_name}")
    print(f"  {new_dir}")
    print("Не забудьте:")
    print(f"  1) оновити симлінк/копію в Interface\\AddOns (тепер папка {new_name});")
    print(f"  2) перейменувати WTF\\...\\SavedVariables\\{old_name}.lua -> {new_name}.lua,")
    print("     якщо хочете зберегти вже зібрані тексти (і всередині файлу змінити")
    print(f"     {old_name}CaptureDB на {new_name}CaptureDB).")


if __name__ == "__main__":
    main()
