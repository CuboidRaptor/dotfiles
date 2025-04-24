#!/usr/bin/env bash

# recursively nixfmt all nix files in current directory except for hardware-configuration
# it just break idk why
fd -u ".*\.nix" | grep -v "hardware-configuration.nix" | xargs nixfmt
