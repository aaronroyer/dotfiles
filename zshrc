
# General shell config
# zsh options docs: http://zsh.sourceforge.net/Doc/Release/Options.html

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


COMMON_DIR=~/.shell.d/common
ZSH_DIR=~/.shell.d/zsh


# Various PATHs
source $COMMON_DIR/path.sh
fpath=(~/.shell.d/zsh/functions /usr/local/share/zsh/site-functions $fpath)
which brew &> /dev/null && fpath=("$(brew --prefix)/share/zsh-completions" $fpath)
autoload -U ~/.shell.d/zsh/functions/*(:t)


# Common shell stuff

source $COMMON_DIR/misc_variables.sh

# Load shy plugin manager; if not present, then shim it
if which shy &> /dev/null; then
  eval "$(shy init)"
else
  shy() { [ "$1" = 'load' ] && source "$2"; }
fi
source $COMMON_DIR/plugins.sh

# zsh specific stuff
# source $ZSH_DIR/prompt.zsh
source $ZSH_DIR/new_prompt.zsh
source $ZSH_DIR/completion.zsh

unset COMMON_DIR ZSH_DIR
