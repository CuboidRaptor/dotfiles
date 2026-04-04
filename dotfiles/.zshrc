# Download Znap, if it's not there yet.
[[ -r ~/.local/share/znaprepos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.local/share/znaprepos/znap
source ~/.local/share/znaprepos/znap/znap.zsh  # Start Znap

# znap plugins
zstyle ":prompt:pure:prompt:success" color green
# set terminal colors
zstyle ":prompt:pure:git:branch" color white
zstyle ":prompt:pure:git:action" color white
zstyle ":prompt:pure:git:dirty" color magenta
zstyle ":prompt:pure:host" color white
zstyle ":prompt:pure:prompt:continuation" color white
zstyle ":prompt:pure:user" color white
zstyle ":prompt:pure:virtualenv" color white
znap prompt sindresorhus/pure

znap source zsh-users/zsh-syntax-highlighting

# emacs bindings, because vim bindings are cursed and break things (I swear I'm a real vim user)
# this needs to be set before fzf/zsh-autocomplete init because zsh auto-loads viins bindings and breaks my shit or smth
bindkey -e

znap source marlonrichert/zsh-autocomplete
zstyle ':autocomplete:*' insert-unambiguous yes # this inserts partial common prefix completions
zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'
zstyle ':autocomplete:*' list-lines 4
setopt GLOBDOTS

# disable zsh-autocomplete history searching
bindkey '\e[A' up-line-or-history
bindkey '\eOA' up-line-or-history
bindkey '\e[B' down-line-or-history
bindkey '\eOB' down-line-or-history

# fzf stuff and shell integration
znap eval "fzf" "fzf --zsh"
# set some fzf bindings and other options
export FZF_DEFAULT_OPTS="--no-height -i --style full --multi"
export FZF_ALT_C_COMMAND="{ fd -u -t d --min-depth 1 --max-depth 1 && find -mindepth 1 -maxdepth 1 -type l -xtype d -printf '%P/\n'; }"

# like alt+c cd, but it's recursive and ignores .git
custom-fzf-cd-recursively-widget () {
    FZF_ALT_C_COMMAND="{ fd -u --exclude .git --exclude node_modules -t d && find -mindepth 1 -maxdepth 1 -type l -xtype d -printf '%P/\n'; }" \
        zle fzf-cd-widget
}
zle -N custom-fzf-cd-recursively-widget
bindkey "^[f" custom-fzf-cd-recursively-widget # bind it to alt+f

# make keybinds consistent with bash, because I feel like it
bindkey "^U" backward-kill-line

# fix home, end, and ctrl+arrow keys
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
if [[ "$TERM" == "xterm"* ]] ; then
    bindkey "^[[H" beginning-of-line
    bindkey "^[[F" end-of-line
elif [[ "$TERM" == "tmux"* ]] ; then
    bindkey "^[[1~" beginning-of-line
    bindkey "^[[4~" end-of-line
fi

# history options
SAVEHIST=1000000
HISTSIZE=1000000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE EXTENDED_HISTORY INC_APPEND_HISTORY_TIME

if command -v nvim &>/dev/null
then
    # set nvim as manpager if it exists (e.g. distrobox)
    export MANPAGER="nvim +Man!"
    export MANWIDTH=100
fi

# set some aliases
if [[ -f ~/.zsh_aliases ]]
then
    source ~/.zsh_aliases
fi
