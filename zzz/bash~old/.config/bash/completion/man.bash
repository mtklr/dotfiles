# Manpage completion.
# All $MANPATH names and any manfiles (ending in .[0-9]) in $PWD.
# NOTE: remove ':' from COMP_WORDBREAKS to complete words containing ':', like
#   PerlIO::, etc., without needing a '\' after every ':'.
#   export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
_comp_man () {
	local cur words

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	words=$(apropos '.' | sed 's/), /),\
/g' | cut -d\( -f1 | grep -Fs "$cur")

	# '$words' single quoted, or it doesn't work and
	# accepts any arg to complete
	COMPREPLY=( $(compgen -o default -W'$words' "$cur") )
}
# $(for ...) unquoted or it doesn't loop through aliases
complete -F _comp_man -A command apropos man whatis \
$(for a in wi apr; do [ "$(type -t $a)" = "alias" ] && echo "$a"; done)
