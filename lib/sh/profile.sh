. ~/lib/sh/variables.sh
. ~/lib/sh/path.sh

if [ "_$(uname)" = _Darwin ]; then
    . ~/lib/sh/profile-mac.sh
fi

if [ -e ~/.profile.local ]; then
    . ~/.profile.local
fi
