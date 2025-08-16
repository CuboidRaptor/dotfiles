# Download Znap, if it's not there yet.
[[ -r ~/.local/share/znaprepos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.local/share/znaprepos/znap
source ~/.local/share/znaprepos/znap/znap.zsh  # Start Znap

# znap plugins
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
znap prompt sindresorhus/pure

znap source zsh-users/zsh-syntax-highlighting

setopt MENU_COMPLETE # this is needed for zsh-autosuggestions for some reason
compinit # run this explicitly so setting $_comp_options works
_comp_options+=(globdots)
znap source zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=("completion" "history")

# fzf stuff and shell integration
znap eval "fzf" "fzf --zsh"
# set some fzf bindings and other options
export FZF_DEFAULT_OPTS="--no-height -i --style full --multi --bind ctrl-h:abort,ctrl-l:accept"
# catppuccin for fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"
# some extra stuff at the end so it works with symlinks
export FZF_ALT_C_COMMAND="{ fd -u -t d --min-depth 1 --max-depth 1 && find -mindepth 1 -maxdepth 1 -type l -xtype d -printf '%P/\n'; }"
export FZF_CTRL_T_COMMAND="fd -u --exclude .git"
export FZF_COMPLETION_TRIGGER="**" # explicitly set this so that _zsh_fzf_autosuggest works

# like alt+c cd, but it's recursive and ignores .git
fzf-cd-recursively-widget () {
    FZF_ALT_C_COMMAND="{ fd -u --exclude .git -t d && find -mindepth 1 -maxdepth 1 -type l -xtype d -printf '%P/\n'; }" \
        zle fzf-cd-widget
}
zle -N fzf-cd-recursively-widget
bindkey "^[f" fzf-cd-recursively-widget # bind it to alt+f

# make tab always accept and then continue suggesting
# unless there's a double star in which case trigger fzf's autocomplete
function _zsh_fzf_autosuggest {
    bufwords=(${(z)LBUFFER})
    if [[ "${bufwords[-1]}" == *"$FZF_COMPLETION_TRIGGER" ]]
    then
        if [[ "${#bufwords}" -gt 1 ]]
        then
            zle fzf-completion
        elif [[ "${#bufwords}" -eq 1 ]]
        then
            # store whether or not original LBUFFER had a `./` before it
            dotslash=""
            if [[ "$LBUFFER" == "./"* ]]
            then
                dotslash="./"
            fi

            # add `touch` before autocomplete to make fzf-completion run file-completion, then remove it
            local filestring="touch "
            LBUFFER="${filestring}$LBUFFER"
            zle fzf-completion
            LBUFFER=${LBUFFER[$((${#filestring} + 1)),-1]}

            #if LBUFFER originally had a ./ before it, add it back so we can quickly execute stuff
            LBUFFER="${dotslash}$LBUFFER"
        fi
    else
        zle autosuggest-accept
        zle autosuggest-fetch
    fi
}
zle -N _zsh_fzf_autosuggest
bindkey '^I' _zsh_fzf_autosuggest

# emacs bindings, because vim bindings are cursed and break things (I swear I'm a real vim user)
bindkey -e

# line editing bindings to delete whole line or chunks of line
bindkey "^U" kill-whole-line
bindkey "^Y" backward-kill-line
bindkey "^K" kill-line

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
    # Not all environments have neovim (e.g. distrobox)
    export MANPAGER="nvim +Man!"
    export MANWIDTH=100
fi

# set some aliases
if [[ -f ~/.zsh_aliases ]]; then
    source ~/.zsh_aliases
fi

# set $PATH and other environment variables
if [[ -f ~/.environment ]]; then
    source ~/.environment
fi
