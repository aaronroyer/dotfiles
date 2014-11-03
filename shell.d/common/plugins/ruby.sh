alias be='bundle exec'

alias z=zeus
alias zs='zeus server'
alias zc='zeus console'
alias zt='zeus spec'

function ruby_exec() {
  local command=$1
  [ -z "$command" ] && { echo "$0 must be given a command name and any arguments" >&2; return 1; }
  if [ -x "bin/$command" ]; then
    if [ -d .git/safe ]; then
      shift
      $command "$@"
      return
    else
      echo "$0: .git/safe directory does not exist - not executing binstub"
    fi
  fi

  if [ "$command" != bundle -a -f Gemfile ] && command -v bundle >/dev/null 2>&1; then
    shift
    bundle exec $command "$@"
  else
    "$@"
  fi
}

for command in rake rails rspec; do
  alias $command="ruby_exec $command"
done
