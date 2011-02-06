
# Options
setopt prompt_subst

# General shell config
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# Shares a lot with bash
for f in variables aliases functions; do
	if [ -f ~/.bash/$f ]; then
		. ~/.bash/$f
	fi
done

for f in prompt completion; do
	if [ -f ~/.zsh/$f ]; then
		. ~/.zsh/$f
	fi
done

# Load up RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
