# SKARRO

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# don't put duplicate lines or lines starting with space in the history. See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# some more ls aliases, also note option: '&& lsd --group-dirs first -lF'
function cd {
    builtin cd "$@" && pwd && ls  --color=auto --group-directories-first -CF
    }

alias ll='ls  --color=auto --group-directories-first -alF'
alias la='ls  --color=auto --group-directories-first -A'
alias l='ls  --color=auto --group-directories-first -CF'
alias ls='ls  --color=auto --group-directories-first -lF'
alias lsd='lsd --group-dirs first -alF'``
alias q="exit"
alias norm='norminette'
alias gerr='gcc -Wall -Wextra -Werror'
alias ..='cd ..'
alias r='gerr *.c && ./a.out'
#alias ra='ranger'
alias bat='batcat'
alias rm='rm -iv'
alias gitlog='git log --oneline --graph --color --all --decorate'
alias f='find | grep --color=auto'
alias grep='grep --color=auto'

#export PAGER="most"
export PAGER="less -N"


#export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
#export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
#export LESS_TERMCAP_ue=$'\e[0m'
#export LESS_TERMCAP_us=$'\e[1;4;31m'
#
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
