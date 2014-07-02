# wunjo prompt theme
setopt prompt_subst

autoload -U zgitinit
autoload -U add-zsh-hook
zgitinit

# Some of this based on color stuff from http://aperiodic.net/phil/prompt/
autoload colors zsh/terminfo
colors
#[[ "$terminfo[colors]" -ge 8 ]] && colors
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$fg[${(L)color}]%}'
  eval PR_BOLD_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  (( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

prompt_wunjo_help () {
  cat <<'EOF'

  prompt wunjo

EOF
}

revstring() {
  git describe --tags --always $1 2>/dev/null ||
  git rev-parse --short $1 2>/dev/null
}

coloratom() {
  local off=$1 atom=$2
  if [[ $atom[1] == [[:upper:]] ]]; then
    off=$(( $off + 60 ))
  fi
  echo $(( $off + $colorcode[${(L)atom}] ))
}
colorword() {
  local fg=$1 bg=$2 att=$3
  local -a s

  if [ -n "$fg" ]; then
    s+=$(coloratom 30 $fg)
  fi
  if [ -n "$bg" ]; then
    s+=$(coloratom 40 $bg)
  fi
  if [ -n "$att" ]; then
    s+=$attcode[$att]
  fi

  echo "%{"$'\e['${(j:;:)s}m"%}"
}

prompt_ruby() {
  local version_string
  if which rbenv &> /dev/null; then
    version_string=$(rbenv version-name | cut -d- -f1)
    case $version_string in
      ree)    version_string="✈"  ;;
      1.8.6)  version_string="➇❻"  ;;
      1.8.7)  version_string="➇❼"  ;;
      1.9.1)  version_string="➈❶"  ;;
      1.9.2)  version_string="➈❷"  ;;
      1.9.3)  version_string="➈❸"  ;;
      2.0.0)  version_string="❷"  ;;
      2.1*)  version_string="❷➀"  ;;
      system)  version_string="➆"  ;;
      *)      version_string="♢"  ;;
    esac
  fi
  if [[ -n "$version_string" ]] then
    echo "$PR_RED $version_string $PR_NO_COLOR"
  fi
}

prompt_arr_setup() {
  local verbose
  if [[ $TERM == screen* ]] && [ -n "$STY" ]; then
    verbose=
  else
    verbose=1
  fi

  typeset -A colorcode
  colorcode[black]=0
  colorcode[red]=1
  colorcode[green]=2
  colorcode[yellow]=3
  colorcode[blue]=4
  colorcode[magenta]=5
  colorcode[cyan]=6
  colorcode[white]=7
  colorcode[default]=9
  colorcode[k]=$colorcode[black]
  colorcode[r]=$colorcode[red]
  colorcode[g]=$colorcode[green]
  colorcode[y]=$colorcode[yellow]
  colorcode[b]=$colorcode[blue]
  colorcode[m]=$colorcode[magenta]
  colorcode[c]=$colorcode[cyan]
  colorcode[w]=$colorcode[white]
  colorcode[.]=$colorcode[default]

  typeset -A attcode
  attcode[none]=00
  attcode[bold]=01
  attcode[faint]=02
  attcode[standout]=03
  attcode[underline]=04
  attcode[blink]=05
  attcode[reverse]=07
  attcode[conceal]=08
  attcode[normal]=22
  attcode[no-standout]=23
  attcode[no-underline]=24
  attcode[no-blink]=25
  attcode[no-reverse]=27
  attcode[no-conceal]=28

  local -A pc
  pc[default]='default'
  pc[date]='cyan'
  pc[time]='Blue'
  pc[host]='Green'
  pc[user]='cyan'
  pc[punc]='yellow'
  pc[line]='magenta'
  pc[hist]='green'
  pc[path]='Cyan'
  pc[shortpath]='default'
  pc[rc]='red'
  pc[scm_branch]='Cyan'
  pc[scm_commitid]='Yellow'
  # pc[scm_status_dirty]='Red'
  # pc[scm_status_staged]='Green'

  pc[scm_status_clean]='Cyan'
  pc[scm_status_dirty]='Yellow'
  pc[scm_status_staged]='Green'

  pc[#]='Yellow'
  for cn in ${(k)pc}; do
    pc[${cn}]=$(colorword $pc[$cn])
  done
  pc[reset]=$(colorword . . 00)

  typeset -Ag wunjo_prompt_colors
  wunjo_prompt_colors=(${(kv)pc})

  PROMPT="%1~\$(prompt_arr_scm_branch)$(prompt_ruby)%(?..[%?])%# "

  export PROMPT
  add-zsh-hook precmd prompt_wunjo_precmd
}

prompt_wunjo_precmd() {
  local ex=$?
  psvar=()

  if [[ $ex -ge 128 ]]; then
    sig=$signals[$ex-127]
    psvar[1]="sig${(L)sig}"
  else
    psvar[1]="$ex"
  fi
}

prompt_arr_scm_branch() {
  zgit_isgit || return
  local -A pc
  pc=(${(kv)wunjo_prompt_colors})

  echo -n ' '

  local branch_color=$pc[scm_status_clean]
  local -a dirty

  if zgit_inworktree; then
    local staged=
    zgit_isindexclean || staged=+

    zgit_hasuntracked && dirty+='?'
    zgit_isworktreeclean || dirty+='!'
    zgit_hasunmerged && dirty+='*'

    if [ $#dirty -gt 0 ]; then
      branch_color=$pc[scm_status_dirty]
    elif [ -n "$staged" ]; then
      branch_color=$pc[scm_status_staged]
    fi
  fi

  echo -n "$branch_color$(zgit_head)$pc[reset]$staged${(j::)dirty}"
  if [ -n "$(zgit_tracking_remote)" ];then
    echo -n "📡 "
  else
    # echo -n "🆕 "
  fi
}

prompt_arr_setup "$@"
