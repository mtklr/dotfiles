[ -r ~/.bash_sessions_disable ] || touch ~/.bash_sessions_disable

shopt -s no_empty_cmd_completion

export HISTCONTROL=ignoreboth
export LESSSECURE=1
export PATH=$PATH:~/bin
export PS1='\j \[\e[34m\]\w \[\e[33m\]\$\[\e[0m\] '

# . ~/.config/git/git-prompt.sh
# export PS1='\j \[\e[34m\]\w\[\e[32m\]$(__git_ps1 " (%s)") \[\e[33m\]\$\[\e[0m\] '

complete -cf man sudo

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
