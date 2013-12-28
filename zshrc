
# General shell config
# zsh options docs: http://zsh.sourceforge.net/Doc/Release/Options.html

fpath=(~/.shell.d/zsh/functions /usr/local/share/zsh/site-functions $fpath)
which brew &> /dev/null && fpath=("$(brew --prefix)/share/zsh-completions" $fpath)
autoload -U ~/.shell.d/zsh/functions/*(:t)

setopt notify # notify right away when bg jobs exit, rather than when printing next prompt

setopt auto_pushd
#setopt pushd_silent # Need to silence pushd?
setopt pushd_to_home # Use home when no arguments specified
setopt pushd_ignoredups

setopt inc_append_history # write to the history file right away instead of when shell exits
setopt hist_ignore_dups   # ignore consecutive dups

REPORTTIME=10 # Report CPU usage for commands running longer than 10 seconds

##### Key bindings
# Next 2 require option to be set as meta key in Terminal (which also
# allows backward kill word with option+delete)
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line

# Allow Control-X E to open the editor (doesn't work by default in zsh)
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line


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

# Config ideas: https://github.com/sorin-ionescu/oh-my-zsh/blob/master/modules/environment/init.zsh
