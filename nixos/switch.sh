#!/usr/bin/env bash

echo Switching...
git add .
sudo nixos-rebuild switch --flake .#default "$@"
