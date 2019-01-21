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

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# smarter history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\W\[\033[01;37m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi

# Copied from the following link:
# http://stackoverflow.com/questions/3497885/code-challenge-bash-prompt-path-shortener
_dir_chomp () {
    local p=${1/#$HOME/\~} b s
    s=${#p}
    while [[ $p != "${p//\/}" ]]&&(($s>$2))
    do
        p=${p#/}
        [[ $p =~ \.?. ]]
        b=$b/${BASH_REMATCH[0]}
        p=${p#*/}
        ((s=${#b}+${#p}))
    done
    echo ${b/\/~/\~}${b+/}$p
}

if [ "$color_prompt" = yes ]; then
    if [ -f /etc/bash_completion.d/git-prompt ]; then
        . /etc/bash_completion.d/git-prompt
        PS1='\[\033[01;32m\]$(
         _dir_chomp "$(pwd)" 1  0)\[\033[01;37m\]$(__git_ps1 "(%s)")\[\033[01;34m\]\$\[\033[00m\] '
    else
        PS1='\[\033[01;32m\]$(
         _dir_chomp "$(pwd)" 1  0)\[\033[01;37m\]$()\[\033[01;34m\]\$\[\033[00m\] '
    fi
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\W$(__git_ps1 " (%s)")\[\033[00;37m\]\$ '
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

# setup editors
export EDITOR=ec
export EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"


# source fzf if available
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
