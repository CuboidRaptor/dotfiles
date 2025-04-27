#!/usr/bin/env dash

dconfwatch() {
    while read -r data; do
        case "$data" in
            /*)
                # when dconf watch prints output, dump dconf to a file
                # we filter for slashes as output entries always start with a path in dconf
                # and acting only on lines that begin with a slash prevents dumping dconf
                # like 3 times unnecessarily
                dconf dump / > /home/jason/dotfiles/dconfdump
                ;;
        esac
    done
}

dconf watch / | dconfwatch
zenity --notification --text "Warning: dconfd exited.\nError code of dconfwatch function: $?"
