#!/usr/bin/env bash

read -r -p "This script will probably overwrite a bunch of stuff randomly, possibly causing damage. Continue? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        # get sudo perms
        if [ "$EUID" != 0 ]; then
            sudo "$0" "$@"
            exit $?
        fi

        # change $HOMETARGET to test
        HOMETARGET="$HOME"

        read -p "Mozilla Firefox profile path? (including ending slash): " mpath
        ln -sf $(readlink -f "./extras/user.js") "${mpath}user.js"
        echo "Done linking Firefox user.js!"

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
        slink ".gitconfig"
        slink ".ahk"
        slink ".wezterm.lua"

        slink ".config/dolphinrc"
        slink ".config/konsolerc"
        slink ".config/starship.toml"
        slink ".config/helix"
        slink ".config/gtk-3.0/gtk.css"
        slink ".config/micro"
        slink ".config/nvim"
        slink ".config/obs-studio"
        slink ".config/SpeedCrunch"
        slink ".config/sublime-text/Packages/User"
        slink ".config/VSCodium/User"

        slink ".local/share/color-schemes"
        slink ".local/share/konsole"
        slink ".local/share/SpeedCrunch/color-schemes"

        slink ".idlerc/config-main.cfg"

        echo "Done symlinking!"

        # copy shims to root folder so they can be used
        sudo cp -r ./shims /shims
        echo "Done copying Shims!"

        sudo cp ./extras/touch.desktop /usr/share/kio/servicemenus/touch.desktop
        echo "Done copying touch.desktop!"

        echo "(Vencord settings have not been linked as vesktop doesn't like symlinks idk y)"
        ;;
    *)
        echo "Aborting..."
        ;;
esac
