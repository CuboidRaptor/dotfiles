#!/usr/bin/env bash

set -eo pipefail

# Install paru
sudo pacman -S --needed base-devel
(
    cd ~
    git clone https://aur.archlinux.org/paru.git
    (
        cd paru
        makepkg -si
    )
    rm -rf ./paru
)

# Make host systemd accessible in container (from arch wiki)
sudo ln -s /run/host/run/systemd/system /run/systemd || true
sudo mkdir -p /run/dbus
sudo ln -s /run/host/run/dbus/system_bus_socket /run/dbus || true

# Install libs/deps and apps
paru -S mesa vlc bibata-cursor-theme vesktop

# Export apps
distrobox-export --app vesktop
