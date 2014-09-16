alias gsr='gem search --remote'

alias be='bundle exec'
alias bi='bundle install'

alias z=zeus
alias zs='zeus server'
alias zc='zeus console'
alias zt='zeus spec'

function r() {
  if [ -x bin/rake ]; then
    bin/rake $@
  elif [ -a Gemfile ]; then
    bundle exec rake $@
  fi
}
