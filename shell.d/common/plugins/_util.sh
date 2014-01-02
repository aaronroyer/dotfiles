
expand_path() {
  local relpath=$1
  [[ -z "$relpath" ]] && relpath=$(pwd)
  ruby -e "puts File.expand_path('$relpath')"
}

canonical_path() {
  local the_path=$(expand_path $1)
  echo $(cd $(dirname $the_path); pwd -P)/$(basename $the_path)
}

is_osx() {
  echo $OSTYPE | grep -q 'darwin'
}

is_ssh_shell() {
  [[ "$SESSION_TYPE" = 'remote/ssh' ]]
}
