# Download Znap, if it's not there yet.
[[ -r ~/.local/share/znaprepos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.local/share/znaprepos/znap
source ~/.local/share/znaprepos/znap/znap.zsh  # Start Znap

# znap plugins
znap prompt sindresorhus/pure
gray="#6c7086"
zstyle ":prompt:pure:prompt:success" color green
# set catppuccin colors because pure prompt doesn't use terminal colors for these
zstyle ":prompt:pure:git:branch" color "$gray"
zstyle ":prompt:pure:git:action" color "$gray"
zstyle ":prompt:pure:git:dirty" color "#f5c2e7" # pink
zstyle ":prompt:pure:host" color "$gray"
zstyle ":prompt:pure:prompt:continuation" color "$gray"
zstyle ":prompt:pure:user" color "$gray"
zstyle ":prompt:pure:virtualenv" color "$gray"

setopt MENU_COMPLETE # this is needed for zsh-autosuggestions for some reason
compinit # run this explicitly so setting $_comp_options works
_comp_options+=(globdots)
znap source zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=("completion" "history")

znap source zsh-users/zsh-syntax-highlighting

# eval stuff for shell integration
znap eval "zoxide" "zoxide init zsh"
znap eval "fzf" "fzf --zsh"
# set some fzf bindings and other options
export FZF_DEFAULT_OPTS="--no-height -i --style full --bind ctrl-h:abort,ctrl-l:accept"
# catppuccin for fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"
export FZF_ALT_C_COMMAND="fd -u -t d --min-depth 1 --max-depth 1"
export FZF_CTRL_T_COMMAND="fd -u --exclude .git"
export FZF_COMPLETION_TRIGGER="**" # explicitly set this so that _zsh_fzf_autosuggest works

# make tab always accept and then continue suggesting
# unless there's a double star in which case trigger fzf's autocomplete
function _zsh_fzf_autosuggest {
    bufwords=(${(z)LBUFFER})
    if [[ ${#bufwords} -gt 1 ]] && [[ "${bufwords[-1]}" == *"$FZF_COMPLETION_TRIGGER" ]] ; then

        zle fzf-completion
    else
        zle autosuggest-accept
        zle autosuggest-fetch
    fi
}
zle -N _zsh_fzf_autosuggest
bindkey '^I' _zsh_fzf_autosuggest

# vim bindings
bindkey -v

# line editing bindings to delete whole line or chunks of line
bindkey "^U" kill-whole-line
bindkey "^Y" backward-kill-line
bindkey "^K" kill-line

# history options
HISTSIZE=40000
HISTFILESIZE=80000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE EXTENDED_HISTORY
setopt NO_INC_APPEND_HISTORY INC_APPEND_HISTORY_TIME NO_SHARE_HISTORY

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

# set some aliases
if [[ -f ~/.zsh_aliases ]]; then
    source ~/.zsh_aliases
fi

# set $PATH
if [[ -f ~/.path_source ]]; then
    source ~/.path_source
fi
