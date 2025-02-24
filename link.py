#!/usr/bin/env python3

import sys
import shutil
import os

from pathlib import Path

HOMETARGET: Path = Path("~" + os.getlogin()).expanduser()
DOTFILEPATH: Path = HOMETARGET.joinpath("dotfiles/dotfiles")
HOMETARGET = HOMETARGET.joinpath("dotfiles/test")
PATHS: list[str] = [
    ".bashrc",
    ".bash_aliases",
    ".bash_path",
    ".gitconfig",
    ".ahk/",
    ".wezterm.lua",
    ".config/starship.toml",
    ".config/micro/",
    ".config/nvim/",
    ".config/obs-studio/",
    ".config/SpeedCrunch/",
    ".config/sublime-text/Packages/User/",
    ".config/VSCodium/User/",
    ".local/share/SpeedCrunch/color-schemes/",
    ".idlerc/config-main.cfg",
    "notes/guido.txt"
]

def slink(name: str) -> None:
    global HOMETARGET, DOTFILEPATH
    fpath: Path = HOMETARGET.joinpath(name)
    fpath.parent.mkdir(parents=True, exist_ok=True)
    isdir: bool = name.endswith("/")
    symlink_to(fpath, DOTFILEPATH.joinpath(name), isdir)

def symlink_to(src: Path, tgt: Path, target_is_directory:bool=False) -> None:
    try:
        src.symlink_to(tgt, target_is_directory=target_is_directory)

    except FileExistsError:
        print(f"WARNING: {src} exists, overwriting...")

        if src.is_dir(follow_symlinks=False):
            shutil.rmtree(src)

        else:
            src.unlink()

        src.symlink_to(tgt, target_is_directory=target_is_directory)

    print(f"Symlinked {src}")

if __name__ == "__main__":
    if os.geteuid() != 0:
        print("ERROR: You need to run this as root. Try using `sudo`.")
        sys.exit()

    confirm: str = input("This script is very prone to breaking stuff. Are you sure you would like to run this? [y/N] ").lower()[0]
    if confirm != "y":
        print("Aborting...")
        sys.exit()

    for path in PATHS:
        slink(path)

    ffpath: Path = HOMETARGET.joinpath(".mozilla/firefox")
    if ffpath.is_dir():
        found_dev: bool = False
        for folder in ffpath.iterdir():
            dname: str = str(folder.name)
            if dname.endswith(".default-release") or dname.endswith(".dev-edition-default"):
                if dname.endswith(".dev-edition-default"):
                    found_dev = True

                symlink_to(folder.joinpath("user.js"), DOTFILEPATH.parent.joinpath("extras/user.js"))

        if not found_dev:
            print("WARNING: Firefox Dev Edition profile not found")

    else:
        print(f"WARNING: {ffpath} doesn't exist or isn't a directory")

    shutil.copyfile(str(DOTFILEPATH.parent.joinpath("extras/keyd.conf")), "/etc/keyd/default.conf")
    print("Copied keyd config to /etc/keyd/default.conf")
