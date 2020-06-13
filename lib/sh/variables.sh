export EDITOR='vim'
export FCEDIT="$EDITOR"
export PAGER='less'
export LESS='-iMQRX'
export BROWSER='w3m'

export LANG='en_US.UTF-8'
export LC_COLLATE='C'
export LC_CTYPE='en_US.UTF-8'
export LC_MESSAGES='en_US.UTF-8'
export LC_MONETARY='en_US.UTF-8'
export LC_NUMERIC='en_US.UTF-8'
export LC_TIME='C'
export LESSCHARSET='utf-8'
export MANFMT='utf8'

# Use $HOME instead of ~ because dash will not perform tilde expansion in a
# set-and-export command (it will for `VAR=val; export VAR` though). I don't
# know if this is a bug.

export TMPDIR="$HOME/tmp"
export TERMINFO="$HOME/.terminfo"
export GTK_DEFAULT_FILECHOOSER_DIR="$HOME/mess"
export PYTHONSTARTUP="$HOME/.python/startup.py"
export RLWRAP_HOME="$HOME/.rlwrap"
export RXVT_SOCKET="$HOME/.urxvt/socket"
export MANPATH="$HOME/.npm-packages/share/man:${MANPATH:-$(manpath)}"

export MANWIDTH='78'
export WHOIS_HIDE='1'
export EMAIL='maeve@unspecified.mail.maeveandrews.com'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Stuff for non-exported use

alphabet='a b c d e f g h i j k l m n o p q r s t u v w x y z'
