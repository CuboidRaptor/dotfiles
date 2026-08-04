if status is-interactive
    # dnf aliases, I'm lazy
    abbr --add dli "dnf list --installed"
    abbr --add dlim "dnf repoquery --userinstalled"

    # last time system was upgraded
    abbr --add lastupd "cat ~/.local/share/updscr_history | tail -n 5"

    abbr --add sap "sudo ansible-playbook --connection=local --inventory=127.0.0.1, ~/dotfiles/ansible/playbook.yaml -v"

    # Reset changes to dconf in dotfiles repo and then write those to database
    # oneliner ult lol
    abbr --add dreset "pushd ~/dotfiles/dconf && git checkout -- ./ && dconf load /org/cinnamon/ < cinnamon.dconf.ini && dconf load /org/nemo/ < nemo.dconf.ini && dconf load /org/gtk/ < gtk.dconf.ini && dconf load /org/gnome/desktop/ < gnome-desktop.dconf.ini ; popd"

    # neofetch!
    abbr --add neofetch "fastfetch -c neofetch"

    # better alternatives
    # (remember that if `x` is aliased to `y`, `\x` will still use the original x (i.e. \ls))
    abbr --add ls "eza -a --icons=auto --group-directories-first"
    abbr --add lsr "eza -a --icons=auto --sort newest"

    # Retrack files that may have been ignored in `.gitignore`
    abbr --add retrack "git rm -r --cached . && git add ."

    # show sizes in MB
    abbr --add free "free -m"

    # strip metadata from image
    abbr --add imgstrip "mogrify -strip"

    # make fd show hiddens and ignore .git and node_modules
    abbr --add fd "fd -u --exclude .git --exclude node_modules"
end