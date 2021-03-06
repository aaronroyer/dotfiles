# Miscellaneous config variables

export PROJECT_DIRS=~/Projects/pro:~/Projects/personal

export DOTFILES_DIR=~/Dropbox/dotfiles

export LC_ALL=en_US.UTF-8

export EDITOR=vim
# GNU Screen sets -o vi if EDITOR=vi, so we have to force it back
set -o emacs

export LESS='iMRw'

export RIPGREP_CONFIG_PATH=~/.ripgreprc

# Are the following old?
export NODE_PATH=/usr/local/lib/node_modules
export NPM_BIN_PATH=/usr/local/share/npm/bin
export PATH="$NPM_BIN_PATH:$PATH"

if [[ -x /usr/libexec/java_home ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home 2> /dev/null)
fi

# Colors
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
# export LSCOLORS=Exfxcxdxbxegedabagacad # Alternative for lighter directory color (OS X ls only?)

# History
export HISTFILE=~/.zhistory
export HISTCONTROL=ignoredups
export HISTFILESIZE=3000
export SAVEHIST=$HISTFILESIZE
export HISTIGNORE="ls:cd:exit:ll:clear:pwd"

# Detect SSH
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
  SESSION_TYPE=remote/ssh
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi

if [[ -f "$HOME/.amazon_keys" ]]; then
  source "$HOME/.amazon_keys";
fi
