alias e='$EDITOR'
alias p='$PAGER'
alias h='fc -l'
alias j='jobs'
alias mi='mv -i'
alias se='sudo -e'
alias eg='egrep -i'
alias rg='egrep -ir'
alias vg='egrep -iv'
alias gf='fgrep -f'
alias vf='fgrep -vf'
alias gg='git grep -Ei'
alias py='python3'

if ls --version >/dev/null 2>&1; then
    alias lc='ls --color=auto -h'
    alias ll='ls --color=auto -hl'
    alias la='ls --color=auto -hlA'
    alias lr='ls --color=auto -hlrt'
else
    alias lc='ls -h'
    alias ll='ls -hl'
    alias la='ls -hlA'
    alias lr='ls -hlrt'
fi

cutc() { expand | cut -c "1-$(($COLUMNS-1))"; }
untab() { column -s '	' -t "$@"; }
dua() { du -ksx "$@" | perl -alne '$s+=$F[0]; END{print $s/1024}'; }
every() { t="$1"; shift; while true; do "$@"; sleep "$t"; done; }
gh() { h 1 | eg "$*"; }
md() { mkdir -p "$@" && cd "$@"; }
shot() { xwd "$@" | xwdtopnm | pnmtopng; }
sus() { sort | uniq -c | sort -n "$@"; }
whost() { whois "$@" | egrep -v '^(#|$)'; host "$@"; }
avgtime() { ptime -f %s.%L -r "$@" | navg; }

alias bcl='bc -lq'
alias be='bundle exec'
alias bigmsg='gxmessage -center -font "${BIGMSG_FONT:-Mono 72}"'
alias diffp='pee diffstat colordiff | $PAGER'
alias duh='du -shx'
alias dfh='df -h -x tmpfs -x devtmpfs -x cgroup'
alias fm='mplayer -fs'
alias fullclear='yes "" | head -99999'
alias isomonth='date +%Y-%m'
alias isoweek='date +%Y-W%V'
alias lsmp3='mp3info -r a -p "%8.2r %3m:%02s %f\n"'
alias mpn='mplayer -nosound'
alias muff='mutt -f'
alias my='mutt -y'
alias na='normalize-audio'
alias pssh='parallel-ssh'
alias rec44='rec -c 2 -s w -r 44100'
alias rot13='tr "[a-zA-Z]" "[n-za-mN-ZA-M]"'
alias rx='dtrx -v --one=here'
alias selmsg='xsel | perl -pe "chomp if eof" | bigmsg -file -'
alias vt100='TERM=vt100 LANG=C LC_ALL=C'

# This is cribbed from the default bashrc shipped with Ubuntu

alert() {
    notify-send --urgency=low -i "$(test $? = 0 && echo terminal || echo error)" \
        "$(history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')"
}
