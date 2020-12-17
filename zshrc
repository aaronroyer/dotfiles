
# Uncomment this and last line for performance information
# zmodload zsh/zprof

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
# bindkey "[D" backward-word
bindkey "\e\e[D" backward-word
# bindkey "[C" forward-word
bindkey "\e\e[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# Allow Control-X E to open the editor (doesn't work by default in zsh)
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# Proper 256 color setup
. ~/.shell.d/base16-shell/base16-aaronroyer.sh

COMMON_DIR=~/.shell.d/common
ZSH_DIR=~/.shell.d/zsh


# Various PATHs
source $COMMON_DIR/path.sh
fpath=(~/.shell.d/zsh/functions /usr/local/share/zsh-completions /usr/local/share/zsh/site-functions $fpath)
autoload -U ~/.shell.d/zsh/functions/*(:t)

# Ruby setup

if which rbenv > /dev/null; then
  eval "$(rbenv init - --no-rehash)"
fi

# Common shell stuff

source $COMMON_DIR/misc_variables.sh

# Load shy plugin manager; if not present, then shim it
# if which shy &> /dev/null; then
#   eval "$(shy init)"
# else
  shy() { [ "$1" = 'load' ] && source "$2"; }
# fi
source $COMMON_DIR/plugins.sh

# zsh specific stuff
# source $ZSH_DIR/prompt.zsh
source $ZSH_DIR/new_prompt.zsh
source $ZSH_DIR/completion.zsh

# unset COMMON_DIR ZSH_DIR

# fzf shell integration
which fzf &> /dev/null && [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Figure out how to make this less slow
# https://www.growingwiththeweb.com/2018/01/slow-nvm-init.html
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Do not intercept Ctrl-S and Ctrl-Q for legacy functionality
stty -ixon

# zprof
