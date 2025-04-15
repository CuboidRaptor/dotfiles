#!/usr/bin/env bash
# load hardware config, switch nix, create distrobox, and link dotfiles.

set -eo pipefail
sudo cp /etc/nixos/hardware-configuration.nix "$HOME/dotfiles/nixos/hardware-configuration.nix"
sudo nixos-rebuild switch --flake "path://$HOME/dotfiles/nixos#dregsdesk15"
distrobox create --name dregsbox --init --image registry.opensuse.org/opensuse/distrobox:latest --additional-packages "python3 python3-pipx python3-tk"
distrobox enter dregsbox -- pipx install bpython
distrobox enter dregsbox -- "$HOME/dotfiles/dbox-setup.sh"
python3 "$HOME/dotfiles/link.py"

