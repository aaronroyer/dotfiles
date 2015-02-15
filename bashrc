if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

COMMON_DIR=~/.shell.d/common
BASH_DIR=~/.shell.d/bash


##### Common shell stuff

source $COMMON_DIR/path.sh
source $COMMON_DIR/misc_variables.sh
# Load shy plugin manager; if not present, then shim it
if which shy &> /dev/null; then
  eval "$(shy init)"
else
  shy() { [ "$1" = 'load' ] && source "$2"; }
fi
source $COMMON_DIR/plugins.sh


##### bash specific stuff

source $BASH_DIR/completion
source $BASH_DIR/prompt

unset COMMON_DIR BASH_DIR


##### General shell config

set bell-style visible

# Do not intercept Ctrl-S and Ctrl-Q for legacy functionality
stty -ixon

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
