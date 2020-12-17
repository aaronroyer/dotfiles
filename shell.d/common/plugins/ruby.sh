# alias be='bundle exec'

# alias z=zeus
# alias zs='zeus server'
# alias zc='zeus console'
# alias zt='zeus spec'

# RUBY_EXEC_VERBOSE=true

# function ruby_exec() {
#   local verbose command=$1
#   [ -z "$command" ] && { echo "$0 must be given a command name and any arguments" >&2; return 1; }
#   [ -n "$RUBY_EXEC_VERBOSE" -a "$RUBY_EXEC_VERBOSE" != false ] && verbose=true
#   if [ -x "bin/$command" ]; then
#     if [ -d .git/safe ]; then
#       [ -n "$verbose" ] && echo "$0: Using binstub: bin/${command}..."
#       shift
#       $command "$@"
#       return
#     else
#       echo "$0: .git/safe directory does not exist - not executing binstub"
#     fi
#   fi

#   if [ "$command" != bundle -a -f Gemfile ] && command -v bundle >/dev/null 2>&1; then
#     [ -n "$verbose" ] && echo "$0: Using bundle exec..."
#     shift
#     bundle exec $command "$@"
#   else
#     [ -n "$verbose" ] && echo "$0: executing normal '$command'..."
#     "$@"
#   fi
# }

# # TODO: some kind of auto-configure for common ruby executables?
# for command in rake rails rspec spring; do
#   alias $command="ruby_exec $command"
# done
