# dnf aliases, I'm lazy, also like dnf5
alias dnf="dnf5"
alias sdnf="sudo dnf5"
alias sdi="sudo dnf5 install"

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
