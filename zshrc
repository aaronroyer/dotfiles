
# General shell config
fpath=(~/.shell.d/zsh/functions $fpath)
autoload -U ~/.shell.d/zsh/functions/*(:t)

setopt auto_pushd
#setopt pushd_silent # Needed to silence pushd?
setopt pushd_to_home # Use home when no arguments specified
setopt pushd_ignoredups

# Load common shell stuff
for f in variables aliases functions; do
	if [ -f ~/.shell.d/common/$f ]; then
		source ~/.shell.d/common/$f
	fi
done

# Load zsh specific stuff
for f in prompt completion; do
	if [ -f ~/.shell.d/zsh/$f ]; then
		source ~/.shell.d/zsh/$f
	fi
done

# Load up RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
