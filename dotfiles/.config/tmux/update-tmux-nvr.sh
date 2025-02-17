#!/usr/bin/env bash

# requires git-subtree
cd "$(git rev-parse --show-toplevel)" || exit
git subtree pull --prefix dotfiles/.config/tmux/tmux-nvr https://github.com/carlocab/tmux-nvr main --squash
