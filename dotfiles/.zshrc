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

setopt MENU_COMPLETE # this is needed for zsh-autosuggestions for some reason
compinit # run this explicitly so setting $_comp_options works
_comp_options+=(globdots)
znap source zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=("completion" "history")

# emacs bindings, because vim bindings are cursed and break things (I swear I'm a real vim user)
# this needs to be set before fzf init because zsh auto-loads viins bindings and breaks my shit or smth
bindkey -e

# fzf stuff and shell integration
znap eval "fzf" "fzf --zsh"
# set some fzf bindings and other options
export FZF_DEFAULT_OPTS="--no-height -i --style full --multi"
export FZF_ALT_C_COMMAND="{ fd -u -t d --min-depth 1 --max-depth 1 && find -mindepth 1 -maxdepth 1 -type l -xtype d -printf '%P/\n'; }"

# like alt+c cd, but it's recursive and ignores .git
custom-fzf-cd-recursively-widget () {
    FZF_ALT_C_COMMAND="{ fd -u --exclude .git -t d && find -mindepth 1 -maxdepth 1 -type l -xtype d -printf '%P/\n'; }" \
        zle fzf-cd-widget
}
zle -N custom-fzf-cd-recursively-widget
bindkey "^[f" custom-fzf-cd-recursively-widget # bind it to alt+f

# the underscore is needed for some reason (smh zsh)
_custom-autosuggest-widget () {
    zle autosuggest-accept
    zle autosuggest-fetch
}
zle -N _custom-autosuggest-widget
bindkey '^I' _custom-autosuggest-widget

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
