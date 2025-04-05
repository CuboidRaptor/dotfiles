# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# set some aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# set $PATH
if [ -f ~/.bash_path ]; then
  . ~/.bash_path
fi

# enable starship
eval "$(starship init bash)"

export FLAKE="path://$HOME/dotfiles/nixos"

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

# fzf integration
eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS="-i --bind ctrl-h:abort,ctrl-l:accept" # set some fzf bindings
export FZF_ALT_C_OPTS='--preview "eza -a --icons=always --group-directories-first {}"'

# zoxide integration
eval "$(zoxide init bash)"
