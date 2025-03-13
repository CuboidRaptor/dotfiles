# rebuild and switch using nh
alias nswitch="sudo -EH nh os switch -R"
alias nsetboot="sudo /run/current-system/bin/switch-to-configuration boot"
alias nli="nix-store --query --requisites /run/current-system"

# upgrade nixos, I guess
#alias yippee="sudo -EH nh os boot --update -R && sudo systemctl reboot"
# this is a bash script in shims now

# last time system was upgraded
export HISTTIMEFORMAT="%y/%m/%d %T "
alias lasty="history | grep -E '([0-9]{2}:?){3} yippee$' --color=never | tail -n 3"

# I use this a lot
alias lg="lazygit"

alias lsg="ls -l | grep"

# chillllll htop
alias htop="htop -d 30"

# neofetch!
alias neofetch="fastfetch -c neofetch"

# better alternatives
# (remember that if `x` is aliased to `y`, `\x` will still use the original x (i.e. \ls))
alias nano="micro"
alias ls="eza -a"
alias cat="bat"
alias vim="nvim"

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
