# Makefile target completion.
# make <tab> uses [mM]akefile targets.
# make -f <tab> completes filenames then targets.
# TODO: maybe option to ignore .o or dot-anything for large projects w/ lots of .o files (mame)?
_comp_make () {
	local cur f prev words

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[$((COMP_CWORD - 1))]}

	# use file completion if preceded by -f
	if [ "$prev" != "-f" ]; then
		if [ -r "$prev" ]; then
			f="$prev"
		else
			if [ -r Makefile ]; then
				f=Makefile
			elif [ -r makefile ]; then
				f=makefile
			elif [ -r GNUmakefile ]; then
				f=GNUmakefile
			fi
		fi

		# build from either -f filename or standard makefile name above
		if [ -r "$f" ]; then
			# read targets from makefile
			words=$(make -n -f "$f" -Rp 2>/dev/null | sed -e "/# Not a target:/{N;};/^[^.# 	].*:/!d;/=/d;/${f}:/d;s/:.*$//")
			COMPREPLY=( $(compgen -W'$words' "$cur") )
		fi
	fi
}
complete -o default -F _comp_make make $(for a in m mn; do [ "$(type -t $a)" = "alias" ] && echo "$a"; done)
