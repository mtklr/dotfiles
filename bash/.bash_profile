[ -r ~/.bash_sessions_disable ] || touch ~/.bash_sessions_disable

shopt -s no_empty_cmd_completion

export HISTCONTROL=ignoreboth
export LESSSECURE=1
export PATH=$PATH:~/bin
export PS1='\j \[\e[34m\]\w \[\e[33m\]\$\[\e[0m\] '

# . ~/.config/git/git-prompt.sh
# export PS1='\j \[\e[34m\]\w\[\e[32m\]$(__git_ps1 " (%s)") \[\e[33m\]\$\[\e[0m\] '

# bash
alias d='dirs'
alias p='pushd'
alias po='popd'
alias r='pushd +1'
alias u='cd ..'
alias x='cd -'
alias ds="date -j '+%Y-%m-%d-%H%M%S'"
alias j='jobs'
alias le='less'
alias la='ls -AFG'
alias ll='ls -FGl'
alias ls='ls -FG'
alias l='ls'
alias m='make'
alias mn='make -n'

# clear Terminal.app window title (after ssh)
alias wk="printf '\e]1;\0\a\e]2;\0\a'"

# resize terminal
alias wl='printf "\e[8;48;132t"'	# large
alias wn='printf "\e[8;24;80t"'		# normal
alias wt='printf "\e[8;48;80t"'		# tall
alias ww='printf "\e[8;24;132t"'	# wide
# alias wx='printf "\e[9;1t"'		# maximize
# alias wr='printf "\e[9;0t"'		# restore to previous size

# git
alias ga='git add'
alias gb='git branch'
alias gcm='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gh='git help'
alias gl='git log'
alias gr='git reset'
alias grm='git remove'
alias gs='git status'
alias gst='git stash'

complete -cf man sudo
