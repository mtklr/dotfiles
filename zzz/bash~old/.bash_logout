sudo -K
clear

# $PWD becomes next session's $OLDPWD
echo "$PWD" > ~/.bash_oldpwd

# keep $DIRSTACK for next session
dirs -l -p | sed '1d' > ~/.bash_dirstack
# remove duplicates, preserve order
# dirs -l -p | sed '1d' | pr -n\ 1 -t | sort -k2 -u | sort | cut -d ' ' -f2- > ~/.bash_dirstack
