#!/usr/bin/env bash
# load hardware config, switch nix, create distrobox, and link dotfiles.

sudo cp /etc/nixos/hardware-configuration.nix "$HOME/dotfiles/nixos/hardware-configuration.nix"
sudo nixos-rebuild switch --flake "path://$HOME/dotfiles/nixos#dregsdesk15"
distrobox create --name dregsbox --init --image registry.opensuse.org/opensuse/distrobox:latest --additional-packages "python3 python3-pipx"
python3 "$HOME/dotfiles/link.py"
echo "Note: distrobox apps still need to be manually installed and dbox-setup'd."

