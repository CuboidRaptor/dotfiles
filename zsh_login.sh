#!/usr/bin/env bash

# run zsh in a blank login shell and set $PATH to that $PATH
# this basically sets $PATH to how it would be in a new login shell
# patch for tmuxp's weird behaviour
newpath="$(env -i HOME="$HOME" zsh --login -c 'echo "$PATH"')"
export PATH="$newpath" && zsh "$@"
