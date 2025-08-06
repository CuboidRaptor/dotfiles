#!/usr/bin/env python3

# Note: this script should not be run with sudo

import sys
import shutil
import os

from pathlib import Path

HOMETARGET: Path = Path("~" + os.getlogin()).expanduser()
DOTFILEPATH: Path = HOMETARGET.joinpath("dotfiles/dotfiles") # path to root of dotfiles
#HOMETARGET = HOMETARGET.joinpath("dotfiles/test")
PATHS = [
    ".bashrc",
    ".bash_profile",
    ".zshrc",
    ".zsh_aliases",
    ".path_source",
    ".gitconfig",
    ".ahk/",
    "notes/guido.txt",
    ".tmuxp/misc.yaml",
    ".tmuxp/template.yaml",

    ".config/nvim/",
    ".config/tmux/",
    ".config/SpeedCrunch/",
    ".config/sublime-text/Packages/User/",
    ".config/autostart/",
    ".config/flameshot/",
    ".config/vlc/vlcrc",
    ".config/wezterm/",
    ".config/wireplumber/wireplumber.conf.d/51-disable-suspension.conf",
    ".config/mimeapps.list",

    ".local/share/fonts/MonaspaceNeonFrozen/",
    ".local/share/mime/",
    ".local/share/nemo/actions/",
    ".local/share/flatpak/overrides/"
]

def slink(name: str) -> None:
    global HOMETARGET, DOTFILEPATH
    fpath: Path = HOMETARGET.joinpath(name)
    fpath.parent.mkdir(parents=True, exist_ok=True)
    isdir = name.endswith("/")
    symlink_to(fpath, DOTFILEPATH.joinpath(name), isdir)

def symlink_to(src: Path, tgt: Path, target_is_directory: bool = False) -> None:
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
    print(f"DEBUG: Home target detected/set as {HOMETARGET}")
    if HOMETARGET.joinpath(".bashrc").is_symlink():
        print("WARNING: `.bashrc` is a symlink, system is likely already linked")

        if "--force" in sys.argv:
            print("DEBUG: `--force` passed, linking anyways...")

        else:
            print("ERROR: Not linking, pass `--force` to force a link.")
            sys.exit()

    for path in PATHS:
        slink(path)

    ffpath: Path = HOMETARGET.joinpath(".mozilla/firefox")
    if ffpath.is_dir():
        found_dev: bool = False
        for folder in ffpath.iterdir():
            dname = str(folder.name)
            if dname.endswith(".default-release") or dname.endswith(".dev-edition-default"):
                if dname.endswith(".dev-edition-default"):
                    found_dev = True

                symlink_to(folder.joinpath("user.js"), DOTFILEPATH.parent.joinpath("extras/user.js"))

        if not found_dev:
            print("WARNING: Firefox Dev Edition profile not found")

    else:
        print(f"WARNING: `{ffpath}` doesn't exist or isn't a directory")
