#!/usr/bin/env bash

cd "$(git rev-parse --show-toplevel)" || exit
git subtree pull --prefix dotfiles/.config/tmux/tmux-nvr https://github.com/carlocab/tmux-nvr main --squash
