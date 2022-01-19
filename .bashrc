# BASHRC

###################################################
###        BASE SETTINGS & FUNCTIONALITY        ###
###################################################

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-256color|*-256color) color_prompt=yes;;
esac

# 256 colors
#export TERM=screen-256color

# Enable vi keys and modes, but you lose Ctrl+L for clear, can add '"\C-l": clear-screen' to ~/.inputrc
#set -o vi 

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

# Terminal prompt settings : name@hostname
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Disable ctrl+s (freeze terminal) and ctrl+q (resume)
if [[ -t 0 && $- = *i* ]]
then
    stty stop ''
    stty start ''
    stty -ixon
    stty -ixoff
    # Unbind ctrl+s, otherwise goes to i-search
	bind -r '\C-s'
fi 

# Allow cd without cd, just type dir name
shopt -s autocd


###################################################
###                   ALIASES                   ###
###################################################

# This prints 'pwd' and 'ls' after cd'ing to another dir
function cd {
    builtin cd "$@" && pwd && lsd --group-dirs first -F
    }

alias ll='ls  --color=auto --group-directories-first -alF'
alias la='ls  --color=auto --group-directories-first -A'
alias l='ls  --color=auto --group-directories-first -CF'
alias ls='ls  --color=auto --group-directories-first -lF'
alias lsd='lsd --group-dirs first -F'

alias q="exit"
alias norm='norminette'
alias gerr='gcc -Wall -Wextra -Werror'
alias ..='cd ..'
alias r='gerr *.c && ./a.out'
alias ra='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias bat='batcat'
alias rm='rm -iv'

alias gitlog='git log --oneline --graph --color --all --decorate'

alias grep='grep  -ni --color=auto'
#alias f='find . | grep -ni --color=auto'
alias fall="find . -type f -name '*' | xargs grep  -ni --color=auto"
alias f="find . -type f -not -path '*/\.*' | xargs grep -ni --color=auto"
alias f3="find . -type f -not -path '*/\.*' | xargs grep -C 3 -ni --color=auto"
alias fzf=' fzf --preview "batcat --style=numbers --color=always --line-range :500 {}" | xargs -o vim'
#alias fzf='fzf --preview "batcat --style=numbers --color=always --line-range :500 {}"'
#alias fz='vim $(fzf)'

alias a='ytfzf -tm --thumbnail-quality=0'
alias v='ytfzf -t --thumbnail-quality=0 -f'
alias moc='mocp -T yellow_red_theme'


###################################################
###                   EXPORTS                   ###
###################################################

# Set pager, this is what man pages uses for example
#export PAGER="most"
export PAGER="less -N"
export EDITOR=vim
export VISUAL=vim
export USER=skarro

# Set man pager custom colors for syntax highlighting
#export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[0;33m'
#export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;31m'
#export LESS_TERMCAP_ue=$'\e[0m'
#export LESS_TERMCAP_us=$'\e[1;4;31m'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


###################################################
###                     FZF                     ###
###################################################
#     ____      ____
#    / __/___  / __/
#   / /_/_  / / /_
#  / __/ / /_/ __/
# /_/   /___/_/ key-bindings.bash
#
# - $FZF_TMUX_OPTS
# - $FZF_CTRL_T_COMMAND
# - $FZF_CTRL_T_OPTS
# - $FZF_CTRL_R_OPTS
# - $FZF_ALT_C_COMMAND
# - $FZF_ALT_C_OPTS

# Key bindings
# ------------
__fzf_select__() {
  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read -r item; do
    printf '%q ' "$item"
  done
  echo
}

if [[ $- =~ i ]]; then

__fzfcmd() {
  [[ -n "$TMUX_PANE" ]] && { [[ "${FZF_TMUX:-0}" != 0 ]] || [[ -n "$FZF_TMUX_OPTS" ]]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

fzf-file-widget() {
  local selected="$(__fzf_select__)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

__fzf_cd__() {
  local cmd dir
  cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  dir=$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m) && printf 'cd -- %q' "$dir"
}

__fzf_history__() {
  local output
  output=$(
    builtin fc -lnr -2147483648 |
      last_hist=$(HISTTIMEFORMAT='' builtin history 1) perl -n -l0 -e 'BEGIN { getc; $/ = "\n\t"; $HISTCMD = $ENV{last_hist} + 1 } s/^[ *]//; print $HISTCMD - $. . "\t$_" if !$seen{$_}++' |
      FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS +m --read0" $(__fzfcmd) --query "$READLINE_LINE"
  ) || return
  READLINE_LINE=${output#*$'\t'}
  if [[ -z "$READLINE_POINT" ]]; then
    echo "$READLINE_LINE"
  else
    READLINE_POINT=0x7fffffff
  fi
}

# Required to refresh the prompt after fzf
bind -m emacs-standard '"\er": redraw-current-line'

bind -m vi-command '"\C-z": emacs-editing-mode'
bind -m vi-insert '"\C-z": emacs-editing-mode'
bind -m emacs-standard '"\C-z": vi-editing-mode'

if (( BASH_VERSINFO[0] < 4 )); then
  # CTRL-T - Paste the selected file path into the command line
  bind -m emacs-standard '"\C-t": " \C-b\C-k \C-u`__fzf_select__`\e\C-e\er\C-a\C-y\C-h\C-e\e \C-y\ey\C-x\C-x\C-f"'
  bind -m vi-command '"\C-t": "\C-z\C-t\C-z"'
  bind -m vi-insert '"\C-t": "\C-z\C-t\C-z"'

  # CTRL-R - Paste the selected command from history into the command line
  bind -m emacs-standard '"\C-r": "\C-e \C-u\C-y\ey\C-u"$(__fzf_history__)"\e\C-e\er"'
  bind -m vi-command '"\C-r": "\C-z\C-r\C-z"'
  bind -m vi-insert '"\C-r": "\C-z\C-r\C-z"'
else
  # CTRL-T - Paste the selected file path into the command line
  bind -m emacs-standard -x '"\C-t": fzf-file-widget'
  bind -m vi-command -x '"\C-t": fzf-file-widget'
  bind -m vi-insert -x '"\C-t": fzf-file-widget'

  # CTRL-R - Paste the selected command from history into the command line
  bind -m emacs-standard -x '"\C-r": __fzf_history__'
  bind -m vi-command -x '"\C-r": __fzf_history__'
  bind -m vi-insert -x '"\C-r": __fzf_history__'
fi

# ALT-C - cd into the selected directory
bind -m emacs-standard '"\ec": " \C-b\C-k \C-u`__fzf_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind -m vi-command '"\ec": "\C-z\ec\C-z"'
bind -m vi-insert '"\ec": "\C-z\ec\C-z"'

fi
