#!/usr/bin/env bash

# change $HOME to $FAKEHOME to test
FAKEHOME="$HOME"
HOMETARGET="$FAKEHOME"

slink () {
    mkdir -p $(dirname "$HOMETARGET/$1")
    ln -s $(readlink -f "./dotfiles/$1") "$HOMETARGET/$1"
}

slink ".bashrc"
slink ".bash_aliases"
slink ".bash_path"
slink ".bash_starship"
slink ".ahk"
slink ".idlerc"
slink ".wezterm.lua"
slink ".config/dolphinrc"
slink ".config/starship.toml"
slink ".config/gtk-3.0/gtk.css"
slink ".config/micro"
slink ".config/nvim"
slink ".config/obs-studio"
slink ".config/SpeedCrunch"
slink ".config/sublime-text/Packages/User"
slink ".config/VSCodium/User"

echo "Done SLinking!"
echo "(Vencord settings have not been linked as vesktop doesn't like symlinks idk y)"