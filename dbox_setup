#!/usr/bin/env bash
# cursed bash script that automatically exports every pipx bin
# *only* run in distroboxes!

# list of pipx things you want to export
pyapps=($(ls "$HOME/.local/share/pipx/venvs/"))
dboxpath="$HOME/dotfiles/dboxexports"

# clean out $dboxpath
rm -rf "$dboxpath"
mkdir "$dboxpath"
for dir in "${pyapps[@]}"
do
    cd "$HOME/.local/share/pipx/venvs/$dir/bin/"
    # loop over every file in current pipx folder, filter out python/activation scripts
    files=($(ls | grep -v '^activate' | grep -v '^Activate' | grep -v '^python[23]\?'))
    for bin in "${files[@]}"
    do
        distrobox-export --bin "$(pwd)/$bin" --export-path "$dboxpath" && mv "$HOME/.local/bin/$bin" "~/.local/bin/${bin}_distrobox_bak"
    done
done
# export python to boxpython3 and boxpython
distrobox-export --bin "/usr/bin/python3" --export-path "$dboxpath"
mv "$dboxpath/python3" "$dboxpath/boxpython3"
ln -s "$dboxpath/boxpython3" "$dboxpath/boxpython"
