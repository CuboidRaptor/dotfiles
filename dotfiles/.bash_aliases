# dnf aliases, I'm lazy
alias sdi="sudo dnf install"
alias sdr="sudo dnf remove"
alias dse="dnf search"
alias dli="dnf list --installed"

# you need to export HISTTIMEFORMAT="%y/%m/%d %T " for this to work
alias lasty="history | grep -E '([0-9]{2}:?){3} yippee$' --color=never | tail -n 3"

# chillllll htop
alias htop="htop -d 30"

# copy stdin to clipboard
alias ccopy="xclip -sel clip"

# better alternatives
# (remember that if `x` is aliased to `y`, `\x` will still use the original x (i.e. \ls))
alias nano="micro"
export EDITOR="nvim"
alias ls="exa -a"
alias cat="bat"
alias vim="nvim"

# this stuff bugs out a lot so i don't use it but it's there for funnies
alias b='sudo "$BASH" -c "$(history -p !!)"'

# must have docker built to 'hollywood_docker' from mcrmonkey's fork of hollywood's Dockerfile
alias hack="docker run -it 'hollywood_docker'"

# strip metadata from image
alias imgstrip="mogrify -strip"
