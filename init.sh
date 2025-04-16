#!/usr/bin/env bash
# load hardware config, switch nix, create distrobox, and link dotfiles.

set -eo pipefail
usern="$(logname)"
cp /etc/nixos/hardware-configuration.nix "/home/$usern/dotfiles/nixos/hardware-configuration.nix"
sudo nixos-rebuild switch --flake "path:///home/$usern/dotfiles/nixos#dregsdesk15"
distrobox create --name dregsbox --init --image registry.opensuse.org/opensuse/distrobox:latest \
    --additional-packages "python3 python3-pipx python3-tk"
distrobox enter dregsbox -- pipx install bpython
distrobox enter dregsbox -- "/home/$usern/dotfiles/dbox-setup.sh"
python3 "$HOME/dotfiles/link.py"

