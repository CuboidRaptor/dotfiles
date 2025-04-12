# Download Znap, if it's not there yet.
[[ -r ~/.znaprepos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.znaprepos/znap
source ~/.znaprepos/znap/znap.zsh  # Start Znap

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

# compinstall stuff
zstyle :compinstall filename "/home/jason/.zshrc"
autoload -Uz compinit
compinit

# vim bindings
bindkey -v

# history options
HISTSIZE=30000
HISTFILESIZE=60000
HISTFILE=~/.histfile
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# enable color support of ls and also add handy aliases
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

# enable starship
eval "$(starship init zsh)"

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

# fzf integration
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS="--no-height -i --bind ctrl-h:abort,ctrl-l:accept" # set some fzf bindings
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"
export FZF_ALT_C_OPTS='--preview "eza -a --color=always --icons=always --group-directories-first -- {}"'
export FZF_ALT_C_COMMAND="fd --type d -u --follow --strip-cwd-prefix --exclude .git"

# zoxide integration
eval "$(zoxide init zsh)"

# set some aliases
if [[ -f ~/.bash_aliases ]]; then
    source ~/.zsh_aliases
fi

# set $PATH
if [[ -f ~/.bash_path ]]; then
    source ~/.zsh_path
fi
