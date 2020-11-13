# Only run this in interactive shells

case $- in
    *i*) ;;
    *) return;;
esac

# Set up terminal

if test -t 0; then
    # If these are not cleared, C-s, C-q, and C-v cannot be bound by readline
    stty stop ''
    stty start ''
    stty lnext ''
fi

# Below mostly adapted from the default Ubuntu bashrc

test -x /usr/bin/lesspipe && eval "$(SHELL=/bin/sh lesspipe)"

# All non-printing escape sequences in prompts need to be surrounded by these
# to avoid counting their bytes towards the length of the prompt.

if test -n "$BASH_VERSION"; then
    _ignore_enable=''
    _ignore_on='\['
    _ignore_off='\]'
    _user_glyph='\$'
elif test -n "$KSH_VERSION"; then
    _ignore_enable=$(printf '\001\r')
    _ignore_on=$(printf '\001')
    _ignore_off=$(printf '\001')
    _user_glyph="$(test "$(id -u)" = 0 && echo '#' || echo '$')"
fi

_att() {
    local text="$1"; shift
    echo -n "${_ignore_on}\\e[$(IFS=';'; echo "$*")m${_ignore_off}"
    echo -n "$text"
    echo -n "${_ignore_on}\\e[00m${_ignore_off}"
}

_title() {
    echo -n "${_ignore_on}\\e]0;$*\\a${_ignore_off}";
}

if [ -z "$_chroot" ] && [ -r /etc/debian_chroot ]; then
    _chroot="($(cat /etc/debian_chroot))"
fi

_check_exit() {
    if [ $1 -eq 0 ]; then
        unset _fail
        _ok=yes
    else
        unset _ok
        if [ $1 -gt 128 -a $1 -le 192 ]; then
            _fail="sig $(kill -l $(($1 & ~0x80)))"
        else
            _fail="exit $1"
        fi
    fi
}

cd() { command cd "$@" && _update_vcs; }
git() { command git "$@" && _update_vcs; }
hg() { command hg "$@" && _update_vcs; }

_update_vcs() {
    unset _vcs _branch
    if test -e .novcs; then
        _vcs=disabled
    elif test -d .hg || command hg id >/dev/null 2>&1; then
        _vcs=hg
    elif test -d .git || command git rev-parse HEAD >/dev/null 2>&1; then
        _vcs=git
    fi
    case "$_vcs" in
        hg)
            _branch="$(command hg id -b)@$(command hg id -n)"
            ;;
        git)
            local h="$(command git symbolic-ref -q HEAD)"
            if test -n "$h"; then
                _branch="${h##refs/heads/}"
            else
                h="$(command git describe --all --contains --always HEAD)"
                _branch="${h#remotes/}"
            fi
            ;;
        *)
            unset _branch
            ;;
    esac
}

PROMPT_COMMAND='_check_exit $?'
_update_vcs

case "$TERM" in
    alacritty|linux|*color*)
        # Basic prompt
        PS1="\${_chroot}$(_att '\u@\h' 34):$(_att '\W' 01 35) "
        # Add git branch
        PS1="$PS1\${_branch:+$(_att '$_branch' 36) }"
        # Add exit status and colorization of user glyph (note: break out of
        # quotes to interpolate $_user_glyph *now*, because if it is
        # interpolated at display time, it won't be treated magically)
        PS1="$PS1\${_fail:+$(_att '[$_fail]' 01 33) $(_att \""$_user_glyph"\" 01 31)}\${_ok:+$(_att \""$_user_glyph"\" 01 32)} "
        ;;
    *)
        PS1='${_chroot}\u@\h:\W $? \$ '
        ;;
esac

case "$TERM" in
    xterm*|rxvt*|screen*|tmux*)
        PS1="$(_title '\u@\h: \w')$PS1"
        ;;
    *)
        ;;
esac

if test -r ~/.dircolors; then
    eval "$(dircolors -b ~/.dircolors)"
else
    eval "$(dircolors -b)"
fi

. ~/lib/sh/aliases.sh

# Per-shell settings

export GPG_TTY="$(tty)"

# Finally, override

if [ -e ~/.shrc.local ]; then
    . ~/.shrc.local
fi
