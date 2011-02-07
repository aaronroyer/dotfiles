
# Options
setopt prompt_subst

# General shell config
fpath=(~/.shell.d/zsh/functions $fpath)
autoload -U ~/.shell.d/zsh/functions/*(:t)

# Load common shell stuff
for f in variables aliases functions; do
	if [ -f ~/.shell.d/$f ]; then
		source ~/.shell.d/$f
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
