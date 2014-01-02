# Provides various functions to find and work with project directories

find_projects() {
  for d in $(echo $PROJECT_DIRS | tr : "\n"); do
    find $d -type d -mindepth 1 -maxdepth 1
  done
}

resolve_project() {
  for project in $(find_projects); do
    [[ "$(basename $project)" = "$1" ]] && { echo $project; return 0; }
  done

  return 1
}

is_project_dir() {
  local dir=$1
  [[ -z "$dir" ]] && dir=$(pwd)
  [[ ! -d $dir ]] && return 1

  # .git directory means it's a project
  [[ -d "$(echo $dir | sed -e 's/\/$//')/.git" ]] && return 0

  # Being in one of our project directories means it's a project
  dir=$(canonical_path $dir)
  local parent_dir=$(dirname $dir)
  for d in $(echo $PROJECT_DIRS | tr : "\n"); do
    [[ "$(canonical_path $d)" == "$parent_dir" ]] && return 0
  done

  return 1
}

find_parent_project_dir() {
  local dir=$1
  [[ -z "$dir" ]] && dir=$(pwd)
  [[ ! -d $dir ]] && return 1

  while [[ "$dir" != "/" ]] && [[ -n "$dir" ]]; do
    is_project_dir $dir && { echo $dir; return 0; }
    dir=$(dirname $dir)
  done
  return 1
}

# Find my projects
p() {
  if [[ "$1" = "-h" ]]; then
    echo "Usage: p PROJECTNAME"
  elif [[ $# -eq 0 ]]; then
    local project_dir=$(find_parent_project_dir)
    if [[ -n "$project_dir" ]]; then
      cd $project_dir
    else
      echo "Not in a project directory!" >&2
      return 1
    fi
  else
    local project=$(resolve_project $1)
    if [[ -n "$project" ]]; then
      cd $project
    else
      echo "Could not find project: $1" >&2
      return 1
    fi
  fi
}
