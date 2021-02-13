# Basic git command completion.
_comp_git () {
	local cur f prev words

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[$((COMP_CWORD - 1))]}
	f=${GIT_CONFIG:-~/.gitconfig}

	# Complete branch name with these git commands and aliases.
	if [[ "${COMP_WORDS[1]}" = "branch" \
		|| "${COMP_WORDS[1]}" = "checkout" \
		|| "${COMP_WORDS[1]}" = "diff" \
		|| "${COMP_WORDS[1]}" = "rebase" \
		|| "${COMP_WORDS[0]}" = "gb" \
		|| "${COMP_WORDS[0]}" = "gco" \
		|| "${COMP_WORDS[0]}" = "gd" ]]; then
		# Only get branch names if inside git repo.
		if git rev-parse --git-dir >/dev/null 2>&1; then
			words=$(git branch -a --color=never --format '%(refname:short)')
		fi
	# Complete git commands on first arg or 'help'
	elif [[ "$COMP_CWORD" -eq 1 || "$prev" = "help" ]]; then
		words="$(git help -a | sed '/^  /!d;s/^  *//' | cut -d ' ' -f 1)"
		[ -r "$f" ] && words="${words} $(sed '/\[alias/,/\[.*\]/!d;/=/!d;/^[ 	]*[;#]/d;s/^[ 	]*//g' "$f" | cut -d'=' -f1)"
	fi

	if [ "$prev" = "--" ]; then
		COMPREPLY=( $(compgen -o bashdefault) )
	else
		COMPREPLY=( $(compgen -o bashdefault -W'$words' "${cur//--/}") )
	fi
}
# $(for ...) unquoted, or it doesn't loop through aliases
complete -o default -F _comp_git git $(for a in gb gco gd ghelp; do [ "$(type -t $a)" = "alias" ] && echo "$a"; done)
