# no window title path
# unset update_terminal_cwd
# unset PROMPT_COMMAND

# no sessions
[ -e ~/.bash_sessions_disable ] || touch ~/.bash_sessions_disable

# single history, see /etc/bashrc_Apple_Terminal
# export SHELL_SESSION_HISTORY=0

# give "\C-o" back to readline (stty discard = flush),
# which is bind default '"\C-o": operate-and-get-next'
# stty discard undef

# give "\C-s", "\C-q" back to readline, disables pausing with C-s/C-q,
# which is bind sequence '"\C-s": forward-search-history'
# stty -ixon

set -o ignoreeof
shopt -s cdspell extglob no_empty_cmd_completion

export CDPATH=.:~:~/src
export CLICOLOR=1
export EDITOR=/usr/bin/vi
export HISTCONTROL=erasedups:ignoreboth
export LESS='-FRXij2'
export LESSSECURE=1
export PAGER=/usr/bin/less

export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin

# source files not ending in '~'
for f in ~/.config/bash/{aliases,completion,functions}/*[!~]; do
	[ -r "$f" ] && . "$f"
done
unset f

# add git status functions to $PROMPT_COMMAND
if type -t git_branch >/dev/null && type -t git_status >/dev/null; then
	if [[ ! "$PROMPT_COMMAND" =~ git_ ]]; then
		PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }git_branch; git_status"
	fi

	PS1='\[\e[0m\]\j \[\e[34m\]\W \[\e[32m\]${GIT_PS_BRANCH/%/ }\[\e[31m\]${GIT_PS_STATUS/%/ }\[\e[33m\]\$\[\e[0m\] '
else
	PS1='\[\e[0m\]\j \[\e[34m\]\W \[\e[33m\]\$\[\e[0m\] '
fi

# restore $OLDPWD from .bash_logout
f=~/.bash_oldpwd
if [ -r "$f" ]; then
	IFS=$'\n' read -r OLDPWD <"$f"
	export OLDPWD
fi
unset f

# restore $DIRSTACK from ~/.bash_logout
f=~/.bash_dirstack
if [ -r "$f" ]; then
	while IFS=$'\n' read -r l; do
		pushd -n "$l"
	done <"$f"
	unset l
fi
unset f
