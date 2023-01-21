# Mayamee's theme
#
# git prompt is inspired by official git contrib prompt:
# https://github.com/git/git/tree/master/contrib/completion/git-prompt.sh
get_color() {
	# $1 = text
	# $2 = color
	local m_zsh_color=40
	if [[ -n "$2" ]]; then
		m_zsh_color=$2
	fi
	echo "%F{$m_zsh_color}$1%f"
}
get_bold() {
	# $1 = text
	echo "%B$1%b"
}

local green="%{$fg_bold[green]%}"
local red="%{$fg_bold[red]%}"
local cyan="%{$fg_bold[cyan]%}"
local yellow="%{$fg_bold[yellow]%}"
local blue="%{$fg_bold[blue]%}"
local magenta="%{$fg_bold[magenta]%}"
local white="%{$fg_bold[white]%}"
local reset="%{$reset_color%}"

c_bold_xterm_red() {
	# $1 = text
	echo $(get_bold $(get_color $1 160))
}
c_bold_xterm_green() {
	# $1 = text
	echo $(get_bold $(get_color $1 40))
}

c_bold_xterm_pink() {
	# $1 = text
	echo $(get_bold $(get_color $1 200))
}

add_user_to_prompt() {
	# void
	local prompt_user='%n'
	local user_id=$(id -u)
	if [[ $user_id -eq 0 ]]; then
		echo "${white}$prompt_user${reset}"
	else
		echo "${white}$prompt_user${reset}"
	fi
}

add_prompt_sign() {
	# void
	local curr_user_id=$(id -u)
	if [[ $curr_user_id -eq 0 ]]; then
		echo $(c_bold_xterm_green "#")
	else
		echo $(c_bold_xterm_green "$")
	fi
}

add_hostname_to_prompt() {
	# void
	local prompt_hostname='%m'
	echo "${green}(${reset}${white}$prompt_hostname${reset}${green})${reset}"
}

add_jobs_info_to_prompt() {
	# void
	local jobs_info=''
	local jobs_count=$(jobs -l | wc -l)
	if [[ ${jobs_count} -gt 0 ]]; then
		jobs_info="${white}${jobs_count}:${reset}"
	fi
	echo "$jobs_info"
}

add_current_dir_to_prompt() {
	# void
	local prompt_dir='%1/'
	echo "${blue}$prompt_dir${reset}"
}

local git_prefix_raw='git:('
local git_suffix_raw=')'
ZSH_THEME_GIT_PROMPT_PREFIX="${green}$git_prefix_raw${reset}${white}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${reset}${green}$git_suffix_raw${reset} "
# ZSH_THEME_GIT_PROMPT_DIRTY=''
# ZSH_THEME_GIT_PROMPT_CLEAN=""
# ZSH_THEME_GIT_PROMPT_UNTRACKED="$blue%%"
# ZSH_THEME_GIT_PROMPT_MODIFIED="$red*"
# ZSH_THEME_GIT_PROMPT_ADDED="$green+"
# ZSH_THEME_GIT_PROMPT_STASHED="$blue$"
# ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="$green="
# ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=">"
# ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="<"
# ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$red<>"
RPROMPT='$(add_hostname_to_prompt)'
PROMPT='$(git_prompt_info)'
PROMPT+='$(add_user_to_prompt)'
PROMPT+=' '
# PROMPT+='$(add_current_dir_to_prompt)'
# PROMPT+=' '
PROMPT+='$(add_jobs_info_to_prompt)'
PROMPT+='$(add_prompt_sign)'
PROMPT+=' '
