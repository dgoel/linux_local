# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# .bashrc

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
case $- in
    *i*) ;;
      *) return;;
esac

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Don't put duplicate lines in the history. ignoreboth is a shorthand for
# ignoredups and ignorespace. See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append and reload "new" items from the history after each command
PROMPT_COMMAND="history -a; history -n"

# ignore these
HISTIGNORE='ls:ll:cd:pwd:bg:fg:history'

# smarter history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|*ghostty) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    if [ -f /etc/bash_completion.d/git-prompt ]; then
        . /etc/bash_completion.d/git-prompt
        PS1='\n\[\e[033;32m\]\u@\h \[\033[01;34m\]\w\[\033[01;30m\]$(__git_ps1 " (%s)")\n\[\033[01;30m\]$\[\033[00m\] '
    else
        PS1='\n\[\e[033;32m\]\u@\h \[\033[01;34m\]\w\[\033[01;30m\]\n\[\033[01;30m\]$\[\033[00m\] '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

case "$TERM" in
    xterm-color|*-256color|*ghostty)
        export GIT_PS1_SHOWCOLORHINTS=1
	    PRE='\[\e[033;32m\]\u@\h \[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]'
	    ;;
    *)
        PRE='\u@\h:\w'
        ;;
esac
export PROMPT_COMMAND="__git_ps1 '"'${VIRTUAL_ENV:+($(basename "$VIRTUAL_ENV")) }'"$PRE' '\n$ '"

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# setup editors: tell emacsclient to start emacs server if not already running
export EDITOR=ec
export VISUAL=et

# User specific environment and startup programs
export PATH=$PATH:$HOME/local/bin:$HOME/.local/bin

# source fzf if available
[ -f ~/local/bin/fzf.bash ] && source ~/local/bin/fzf.bash

## TODO: source bash completion from bin/
