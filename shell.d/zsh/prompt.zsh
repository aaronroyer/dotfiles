setopt prompt_subst

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


prompt_user_and_host() {
	if is_ssh_shell; then
		local h=$(hostname -s)
		if [[ -n "$h" ]]; then
			h="@$h"
		else
			h="@(unknown host)"
		fi
		echo "${USER}$h "
	else
		[[ "$USER" != 'aaron' ]] && echo "$USER "
	fi
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

prompt_git() {
	local dirty git_status color
	git_status=$(git status 2>/dev/null)
	[ "$git_status" ] || return
	if [[ "$git_status" == *'working directory clean'* ]]; then
		color=$PR_GREEN
	else
		color=$PR_YELLOW
		dirty=' *'
	fi
	echo "($color$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')$PR_NO_COLOR$dirty)"
}

prompt_svn() {
	local dirty rev=$(svn info 2>/dev/null | grep Revision | sed -e 's/Revision: //')
	[ "$rev" ] || return
	[ "$(svn st)" ] && dirty=' *'
	echo "(r$rev$dirty)"
}



#PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

PS1='%{$bold_color%}$(prompt_user_and_host)%{$reset_color%}%1~$(prompt_git)$(prompt_svn)$(prompt_ruby)%(?..[%?])%# '