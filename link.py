#!/usr/bin/env python3

import sys

from pathlib import Path

HOMETARGET: Path = Path.home()
DOTFILEPATH: Path = Path.joinpath(HOMETARGET, "dotfiles/dotfiles")
HOMETARGET = Path.joinpath(HOMETARGET, "dotfiles/test")
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
    fpath: Path = Path.joinpath(HOMETARGET, name)
    fpath.parent.mkdir(parents=True, exist_ok=True)
    isdir: bool = name.endswith("/")

    try:
        fpath.symlink_to(Path.joinpath(DOTFILEPATH, name), target_is_directory=isdir)

    except FileExistsError:
        print(f"WARNING: {str(fpath)} exists, overwriting...")
        
        if fpath.is_dir(follow_symlinks=False):
            fpath.rmdir()

        else:
            fpath.unlink()

        fpath.symlink_to(Path.joinpath(DOTFILEPATH, name), target_is_directory=isdir)

    print(f"Symlinked {str(fpath)}")

if __name__ == "__main__":
    confirm: str = input("This script is very prone to breaking stuff. Are you sure you would like to run this? [y/N] ").lower()[0]
    if confirm != "y":
        print("Aborting...")
        sys.exit()

    for path in PATHS:
        slink(path)
