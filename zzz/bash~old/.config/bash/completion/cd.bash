# Complete $CDPATH directories and directories beneath them.
# https://www.gnu.org/software/bash/manual/html_node/A-Programmable-Completion-Example.html

# A completion function for the cd builtin
# based on the cd completion function from the bash_completion package
_comp_cd ()
{
	local IFS=$' \t\n'	# normalize IFS
	local cur _skipdot _cdpath
	local i j k l
	local re="s/[][ !@#%&*()+?{}]/\\\&/g"

	# Tilde expansion, with side effect of expanding tilde to full pathname
	case "$2" in
		\~*)	eval cur="$2" ;;
		*)	cur=$2 ;;
	esac

	# no cdpath or absolute pathname -- straight directory completion
	# if [[ -z "${CDPATH:-}" ]] || [[ "$cur" == @(./*|../*|/*) ]]; then
	if [[ -z "${CDPATH:-}" ]] || [[ "$cur" == ?(.)?(.)/* ]]; then
		# compgen prints paths one per line; could also use while loop
		IFS=$'\n'

		# adding "-S'/'" is hacky I guess, but it works for now.
		COMPREPLY=( $(compgen -d -S'/' "$cur") )
		IFS=$' \t\n'

		# prefix special characters with '\'
		for (( l=0; l < ${#COMPREPLY[@]}; l++)) do
			COMPREPLY[$l]=$(sed "$re" <<<"${COMPREPLY[$l]}")
		done
	# CDPATH+directories in the current directory if not in CDPATH
	else
		IFS=$'\n'
		_skipdot=false

		# preprocess CDPATH to convert null directory names to .
		_cdpath=${CDPATH/#:/.:}
		_cdpath=${_cdpath//::/:.:}
		_cdpath=${_cdpath/%:/:.}

		for i in ${_cdpath//:/$'\n'}; do
			if [[ $i -ef . ]]; then _skipdot=true; fi

			k="${#COMPREPLY[@]}"

			for j in $( compgen -d -S'/' "$i/$cur" ); do
				# prefix special characters with '\'
				j=$(sed "$re" <<<"$j")

				COMPREPLY[k++]=${j#$i/}	# cut off directory
			done
		done

		$_skipdot || COMPREPLY+=( $(compgen -d "$cur") )
		IFS=$' \t\n'
	fi

	# variable names if appropriate shell option set and no completions
	if shopt -q cdable_vars && [[ ${#COMPREPLY[@]} -eq 0 ]]; then
		COMPREPLY=( $(compgen -v "$cur") )
	fi

	return 0
}
complete -o nospace -o bashdefault -F _comp_cd cd pushd
# Tells readline to quote appropriately and append slashes to directories;
# use the bash default completion for other arguments
# "-o filenames" breaks variables - $OLDPWD becomes \$OLDPWD
