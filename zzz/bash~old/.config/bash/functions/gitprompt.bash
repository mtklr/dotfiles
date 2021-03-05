# simple git branch/status in prompt
# call git_branch, git_status from $PROMPT_COMMAND
# add $GIT_PS_BRANCH, $GIT_PS_STATUS to $PS1
# use ${GIT_PS_BRANCH/%/ } to add space to end of branch if variable is set
# use ${GIT_PS_STATUS/%/ } to add space to end of status if variable is set

git_branch () {
	local branch

	# not in a git project, return
	if ! git rev-parse --is-inside-work-tree &>/dev/null; then
		unset GIT_PS_BRANCH
		return
	fi

	branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || return 1)"

	# rev-parse error: empty git project or no branch info
	[ $? = "1" ] && return 1

	# no branch for some reason
	[ -n "$branch" ] || return 1

	# show ref for detached branch
	if [ "$branch" = "HEAD" ]; then
		branch="$(git rev-parse --short HEAD 2>/dev/null)"
	fi

	GIT_PS_BRANCH="$branch"
}

git_status () {
	local line status statusout statustypes s

	statustypes=1

	# if using git_branch () above, check if GIT_PS_BRANCH is set
	# instead of running git rev-parse again
	# * won't show status before commits/branches exist
	if [ -z "$GIT_PS_BRANCH" ]; then
		unset GIT_PS_STATUS
		return 1
	fi

	# * if using without git_branch () in $PROMPT_COMMAND
	# not in a git project, return
	# if ! git rev-parse --is-inside-work-tree &>/dev/null; then
	# 	unset GIT_PS_STATUS
	# 	return 1
	# fi

	unset statusout
	unset GIT_PS_STATUS

	status="$(git status --porcelain 2>/dev/null | \
	while read -r line; do [ -n "$line" ] || continue; echo "${line:0:2}"; done)"

	# no status
	[ -n "$status" ] || return 1

	if [ -n "$statustypes" ]; then
		for s in M A D R C U \? \!; do
			[[ "$status" =~ "$s" ]] && statusout+="$s"
		done

	else
		# print '!' for any status output
		[[ "$status" =~ [MADRCU\?\!] ]] && statusout='!'
		# skip ignored or untracked files
		# [[ "$status" =~ [MADRCU] ]] && statusout='!'
	fi

	GIT_PS_STATUS="$statusout"
}
