
# Use rbenv if available, otherwise RVM (if available)
if which rbenv > /dev/null; then
	# rbenv loading needs to go in here instead of .zshrc
	# see https://github.com/37signals/pow/issues/202#issuecomment-2640707
	eval "$(rbenv init -)"
elif [[ -d $PATH:$HOME/.rvm/bin ]]; then
	RVM_HOME=$HOME/.rvm/bin
	PATH=$PATH:$RVM_HOME
	# TODO: Next line needed?
	#[[ -r $RVM_HOME/scripts/completion ]] && . $RVM_HOME/scripts/completion
fi
