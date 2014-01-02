# Utilities related to directories and moving around

# Look into the following
# Find the option for using colors in ls, depending on the version: Linux or BSD
# ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias ls='ls -Gh'
alias l='ls -l'
alias ll='ls -al'
alias l.='ls -d .*'

# cd to the directory in the Finder's front window
alias cdf='cd "$(posd)"'

# TODO: make these work on Linux, too
alias du='du -h'
alias du0='du -d 0'
alias du1='du -d 1'

alias df='df -h'

alias 1='cd -'
# aliases for switching to directories on stack (example: 4='cd +4')
for n in 2 3 4 5 6 7 8 9; do eval alias "$n='cd +$n'"; done
#aliases for d function, to echo directories from the stack
for n in 0 1 2 3 4 5 6 7 8 9; do eval alias "d$n='d $n'"; done


h() {
  cd ~/$1
}

# mkdir and cd to it
mcd() {
  [[ -z "$1" ]] && { echo "Usage: $0 DIRNAME" >&2; return 1; }
  mkdir -p "$1" && cd "$1"
}

d() {
  local ds="$(dirs -v)"
  if [[ $# -eq 0 ]]; then
    echo $ds
  else
    # Get directory with the given number in the stack
    echo $ds | grep "^${1}[[:space:]]" | awk '{print $2}'
  fi
}
