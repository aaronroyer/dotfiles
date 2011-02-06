if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

for f in variables aliases functions completion prompt; do
	if [ -f ~/.bash/$f ]; then
		. ~/.bash/$f
	fi
done

##### General shell config

set bell-style visible

# Load up RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
