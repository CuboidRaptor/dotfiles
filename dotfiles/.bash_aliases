# dnf aliases, I'm lazy, also like dnf5
alias dnf="dnf5"
alias sdi="sudo dnf5 install"
alias sdr="sudo dnf5 remove"
alias dse="dnf5 search"
alias dli="dnf5 list --installed"

# you need to export HISTTIMEFORMAT="%y/%m/%d %T " for this to work
alias lasty="history | grep -E '([0-9]{2}:?){3} yippee$' --color=never | tail -n 3"

# chillllll htop
alias htop="htop -d 30"

# copy stdin to clipboard
alias ccopy="xclip -sel clip"

# better alternatives
# (remember that if `x` is aliased to `y`, `\x` will still use the original x (i.e. \ls))
alias nano="micro"
export EDITOR=micro
alias ls="exa -a"
alias cat="bat"

# this stuff bugs out a lot so i don't use it but it's there for funnies
alias b='sudo "$BASH" -c "$(history -p !!)"'

# must have docker built to 'hollywood_docker' from mcrmonkey's fork of hollywood's Dockerfile
alias hack="docker run -it 'hollywood_docker'"

# by u/ASCIInerd73
..() {
    if [ -z "$1" ]; then
        cd ..
    else
        cd `awk "BEGIN {while (c++<$1) printf \"../\"}"`
    fi
}
