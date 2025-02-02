# dnf aliases, I'm lazy
alias sdi="sudo dnf install"
alias sdr="sudo dnf remove"
alias dse="dnf search"
alias dli="dnf list --installed"

# last time system was upgraded
export HISTTIMEFORMAT="%y/%m/%d %T "
alias lasty="history | grep -E '([0-9]{2}:?){3} yippee$' --color=never | tail -n 3"

# chillllll htop
alias htop="htop -d 30"

# neofetch!
alias neofetch="fastfetch -c neofetch"

# better alternatives
# (remember that if `x` is aliased to `y`, `\x` will still use the original x (i.e. \ls))
alias nano="micro"
export EDITOR="nvim"
alias ls="eza -a"
alias cat="bat"
alias vim="nvim"

# must have docker built to 'hollywood_docker' from mcrmonkey's fork of hollywood's Dockerfile
alias hack="docker run -it 'hollywood_docker'"

# strip metadata from image
alias imgstrip="mogrify -strip"

# Auto cd into last lf
alias lf='cd "$(command lf -print-last-dir "$@")"'

# Create file or directory with parents
function create {
    case $1 in 
        */) # directory path
            echo Creating directory...
            mkdir -p "$1"
            ;;

        *) # filepath
            echo Creating file...
            mkdir -p "$(dirname "$1")" && touch "$1"
            ;;
    esac
}
