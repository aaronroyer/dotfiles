if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Load common shell stuff
for f in variables aliases functions; do
	if [ -f ~/.shell.d/common/$f ]; then
		. ~/.shell.d/common/$f
	fi
done

# Load bash specific stuff
for f in completion prompt; do
	if [ -f ~/.shell.d/bash/$f ]; then
		. ~/.shell.d/bash/$f
	fi
done

##### General shell config

set bell-style visible
