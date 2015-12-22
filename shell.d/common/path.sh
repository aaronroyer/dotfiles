# General PATH setup
# Path manipulation functions inspired by github.com/rtomayko/dotfiles

# Usage: pls [<var>]
# List path entries of PATH or environment variable <var>.
pls () {
  local p=$PATH
  [[ "$#" -ge 1 ]] && p=$1
  echo $p | tr : '\n'
}

# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value while retaining the original order.
#
# Example:
#   $ puniq /usr/bin:/usr/local/bin:/usr/bin
#   /usr/bin:/usr/local/bin
puniq () {
  local p=$PATH
  [[ "$#" -ge 1 ]] && p=$1
  echo "$p" | tr : '\n' | nl | sort -u -k 2,2 | sort -n |
  cut -f 2- | tr '\n' : | sed -e 's/:$//' -e 's/^://'
}

PATH=~/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$PATH
#MANPATH=/opt/local/share/man:$MANPATH

[[ -d ~/.tmpbin ]] && PATH=$PATH:~/.tmpbin

if which go &> /dev/null; then
  export GOPATH=~/go
  [[ -d "$GOPATH" ]] && PATH=$PATH:$GOPATH/bin
  export GOROOT=`go env GOROOT`
  PATH=$PATH:$GOROOT/bin
fi

export PATH=$(puniq $PATH)
#export MANPATH=$(puniq $MANPATH)
