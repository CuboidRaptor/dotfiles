#!/usr/bin/env bash

read -r -p "This script will probably overwrite a bunch of stuff randomly, possibly causing damage. Continue? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        # get sudo perms
        if [ "$EUID" != 0 ]; then
            sudo "$0" "$@"
            exit $?
        fi

        # change $HOME to $FAKEHOME to test
        FAKEHOME="$HOME"
        HOMETARGET="$HOME"

        read -p "Mozilla Firefox profile path? (including ending slash): " mpath
        ln -sf $(readlink -f "./userjs/user.js") "${mpath}user.js"
        echo "Done Linking Firefox user.js!"

        slink () {
            mkdir -p $(dirname "$HOMETARGET/$1")

            if [ -d "$HOMETARGET/$1" ]
            then
                echo "$HOMETARGET/$1 exists on the file system and will be overwritten with a symlink."
                rm -r "$HOMETARGET/$1"
            fi

            ln -sf $(readlink -f "./dotfiles/$1") "$HOMETARGET/$1"
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

        # copy shims to root folder so they can be used
        sudo cp -r shims /shims
        echo "Done Copying Shims!"

        echo "(Vencord settings have not been linked as vesktop doesn't like symlinks idk y)"
        ;;
    *)
        echo "Aborting..."
        ;;
esac
