alias gb='git branch'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gl='git log --pretty=oneline --abbrev-commit --decorate'
#alias glf="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glf="git log --pretty=format:'%C(yellow)%h%Creset %s %Cgreen%cr %C(blue)%an%Creset' --abbrev-commit"
alias glg="git log --graph --pretty=oneline --abbrev-commit"

# alias ccb="git rev-parse --abbrev-ref HEAD | tr -d '\n' | pbcopy"

# Checkout last git branch, as grepped out of the reflog
# TODO fix; doesn't always work correctly
glb() {
  local last_branch=$(git reflog | grep checkout | head -1 | ruby -e 'STDIN.read =~ /from ([\w\d_\-]*)/; puts $1')
  [[ -z "$last_branch" ]] && return 1
  echo "Checking out last branch: $last_branch"
  git co $last_branch
}
