# rebuild and switch using nh
alias nsw="sudo -EH nh os switch -R"
alias nsetboot="sudo /run/current-system/bin/switch-to-configuration boot"
alias nli="nix-store --query --requisites /run/current-system"
alias ncg="sudo nix-collect-garbage --delete-older-than 14d"

# last time system was upgraded
export HISTTIMEFORMAT="%y/%m/%d %T "
alias lasty="history | grep -E '([0-9]{2}:?){3} yippee$' --color=never | tail -n 3"

# I use this a lot
alias lg="lazygit"

# neofetch!
alias neofetch="fastfetch -c neofetch"

# better alternatives
# (remember that if `x` is aliased to `y`, `\x` will still use the original x (i.e. \ls))
alias l="eza -a --color=always --icons=always --group-directories-first"
#alias cat="bat" # probably shouldn't do this
#alias vim="nvim" # unneeded because of nixos

# add color to stuff
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# show sizes in MB
alias free="free -m"

# strip metadata from image
alias imgstrip="mogrify -strip"

# Auto cd into last lf
function lf {
    cd "$(command lf -print-last-dir "$@")" || exit
}
export -f lf

# Create file or directory with parents
function create {
    case $1 in 
        */) # directory path
            mkdir -p "$1"
            echo Created directory
            ;;

        *) # filepath
            mkdir -p "$(dirname "$1")" && touch "$1"
            echo Created file
            ;;
    esac
}
export -f create

# server for nvrw (this is in a function because it has to or else tmux gets angry)
# (and nvrw is a file because git edit and stuff)
function nvrws {
    nvim --listen "${HOME}/.cache/nvim/nvim-tmux-session-$(tmux display-message -p '#S').pipe"
}
