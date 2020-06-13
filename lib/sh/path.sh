_add_to_PATH() {
    for dir; do
        if test -d "$dir"; then
            case "$PATH" in
                "$dir":*|*:"$dir":*|*:"$dir")
                    # echo "profile: $dir already exists in $PATH" 1>&2
                    ;;
                *)
                    PATH="$dir:$PATH"
                    ;;
            esac
        # else
            # echo "profile: $dir is not a directory" 1>&2
        fi
    done
}

_add_to_PATH \
    /usr/local/bin \
    /usr/local/sbin \
    /opt/bin \
    /var/lib/gems/*/bin \
    ~/.cabal/bin \
    ~/.cargo/bin \
    ~/.gem/ruby/*/bin \
    ~/.lein/bin \
    ~/.local/bin \
    ~/.npm-packages/bin \
    ~/bin \
    ~/opt/bin
