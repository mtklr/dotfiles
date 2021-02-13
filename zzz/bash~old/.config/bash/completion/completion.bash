# Miscellaneous bash completion.
complete -A alias alias unalias
complete -A binding bind
complete -A builtin builtin
# complete -A directory cd pushd
complete -W'$(dirs -p)' popd
complete -A command command type whereis which
complete -A function function "$([ "$(type -t fl)" = "alias" ] && echo "fl")"
complete -A builtin -A keyword help
complete -A job bg disown fg jobs "$([ "$(type -t j)" = "alias" ] && echo "j")"
complete -A setopt set
complete -A shopt shopt
complete -A user groups id last w
complete -A variable -A function unset
complete -o default -A variable -A function declare export readonly
