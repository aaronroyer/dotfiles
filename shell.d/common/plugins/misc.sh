# Miscellaneous stuff that doesn't seem to belong elsewhere

alias simple_server='ruby -run -e httpd -- . -p 8000'


# Display a man page in Preview
# pman() {
#   [[ -z "$1" ]] && { echo "Usage: $0 MANPAGE" >&2; return 1; }
#   man -t "${1}" | open -f -a /Applications/Preview.app
# }

# Simple history find
# hf() {
#   grep "$@" ~/.zhistory
# }


# Find (checked-in) files in current directory
# TODO: make work without git?
# f() {
#   if [ -n "$1" ]; then
#     git ls-files | grep "$1"
#   else
#     git ls-files | fzf
#   fi
# }

# search the directory frontmost in the Finder
#posfind() { find "$(posd)" -name "*$1*"; }

# grep the directory frontmost in the Finder
#posgrep() { grep -iIrn "$1" "$(posd)"; }


# Opens xcworkspace file if exists, otherwise opens xcodeproj file.
# Returns 0 if a project is found, 1 otherwise.
# xc() {
#   local project="$(ls | grep '.*\.xcworkspace$')"
#   [[ -z $project ]] && project="$(ls | grep '.*\.xcodeproj$')"
#   if [[ -n $project ]]; then
#     open $project
#   else
#     echo "No .xcworkspace or .xcodeproj files in current directory" >&2
#     return 1
#   fi
# }


##### Misc dev
# alias fs='foreman start'
# alias mci='mvn clean install'


# Filter all but specific lines from stdin
for n in 0 1 2 3 4 5 6 7 8 9; do eval alias "l$n='sed -n ${n}p'"; done



##### Shell and dotfile management

alias dotfiles='git --git-dir=$DOTFILES_DIR/.git/ --work-tree=$DOTFILES_DIR'

reload_shell() {
  local rc_file=~/.zshrc
  [[ -z "$ZSH_VERSION" ]] && rc_file=~/.bashrc
  echo -n "Sourcing ${rc_file}... "
  source $rc_file
  echo "Done."
}

# Make symlink dotfiles in HOME to the regular files in Dropbox.
# Just defer to the script that does it - it is standalone to allow
# linking without sourcing this function first.
link_dotfiles() {
  local dropbox_dir=$HOME/Dropbox
  if [ -d $dropbox_dir ]; then
    local link_script=$dropbox_dir/dotfiles/link_dotfiles
    if [ -f $link_script ]; then
      ruby $link_script
    else
      echo "$link_script does not exist or is not a regular file"
      return 1
    fi
  else
    echo "$dropbox_dir does not exist or is not a directory - is Dropbox set up?"
    return 1
  fi
}
