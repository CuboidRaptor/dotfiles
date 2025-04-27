#!/usr/bin/env bash

set -o pipefail

# run zsh in a blank login shell and set $PATH to that $PATH
# this basically sets $PATH to how it would be in a new login shell
# (it's a patch for tmuxp's weird behaviour)
# and also set $SHELL to login default cuz that's get screwed up too
defaultpath="$(env -i HOME="$HOME" zsh --login -c 'echo "$PATH"')" \
    && export PATH="$defaultpath" \
    && defaultshell="$(getent passwd "$USER" | awk -F: '{print $NF}')" \
    && export SHELL="$defaultshell" \
    && exec -a "zsh" zsh "$@" # set $0
