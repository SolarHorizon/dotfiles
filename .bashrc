# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
		*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
	else
	color_prompt=
	fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	if test -r ~/.dircolors; then eval "$(dircolors -b ~/.dircolors)"; else eval "$(dircolors -b)"; fi
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# WSL
if grep -qi Microsoft /proc/version > /dev/null 2>&1; then
	. ~/.bash_wsl
fi

# starship prompt
eval "$(starship init bash)"

# projectrc
# Automatically finds a .projectrc file in the working directory & asks to source it

declare -A PROJRC_TRUSTED
prc_trusted_path="$HOME/.projectrc_trusted_sources"
touch "${prc_trusted_path}"

readarray -t lines < "${prc_trusted_path}"
for line in "${lines[@]}"; do
	key="${line%%=*}"
	value="${line#*=}"
	PROJRC_TRUSTED[$key]=$value
done

__projrc_is_trusted() {
	[[ "$1" ]] && echo "${PROJRC_TRUSTED[$1]}"
}

__projrc_remove_dir() {
	unset 'PROJRC_TRUSTED[$1]'
	sed -i "\%^$1%d" "${prc_trusted_path}";
}

__projrc_add_dir() {
	__projrc_remove_dir "$1"
	PROJRC_TRUSTED["$1"]+="$2"
	echo "$1=$2" >> "${prc_trusted_path}"
}

prc_allow() { __projrc_add_dir "${1:-${PWD}}" "true"; }
prc_deny() { __projrc_add_dir "${1:-${PWD}}" "false"; }
prc_remove() { __projrc_remove_dir "${1:-${PWD}}"; }

__projrc_prompt() {
	printf "\033[0;33m\nA .projectrc file was detected in this directory. Running resource files can be dangerous.\n\033[1;33mIf you do not trust the author, DO NOT source this file!\n\n\033[0m"
	read -rp $'Source .projectrc file? (\033[1;32mY\033[0mes/\033[1;31mN\033[0mo/\033[1;32mA\033[0mlways/ne\033[1;31mV\033[0mer): ' yn
	case "${yn}" in
		[YyAa]*) . .projectrc ;&
		[Aa]*) prc_allow ;;
		[Vv]*) prc_deny && echo -e "\n\033[0;33mThis directory is now marked as untrusted.\033[0m" ;;
		[Nn]*) echo -e "\n\033[0;33mAborted.\033[0m" ;;
	esac
}

projectrc() {
	[[ $(type -t cleanup_projectrc) == "function" ]] && cleanup_projectrc
	if [[ -f ".projectrc" ]]; then
		trusted=$(__projrc_is_trusted "${PWD}")
		case "${trusted}" in
			true) . .projectrc ;;
			false) echo -e "\n\033[0;33mThis directory was marked as untrusted.\033[0m" ;;
			* ) __projrc_prompt ;;
		esac
	fi
}

cd() {
	builtin cd "$@" || return
	projectrc
}
cd .

export EDITOR='nvim'
export PATH=$HOME/bin:$HOME/.foreman/bin:$HOME/.cargo/bin:$PATH
. "$HOME/.cargo/env"

