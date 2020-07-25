if test "$SHLVL" = 1 -a -x /usr/bin/clear_console; then
    /usr/bin/clear_console -q
fi

if command -v pniq >/dev/null 2>&1; then
    pniq ~/.bash_history~ ~/.bash_history > ~/.bash_history~new~
    test -s ~/.bash_history~new~ && mv ~/.bash_history~new~ ~/.bash_history~
fi
