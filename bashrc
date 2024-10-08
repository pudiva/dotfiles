#!/bin/sh
# pudiva's ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1='\u@\h:\W\$ '

alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"

CHRUBY_PATH=/usr/local/share/chruby/chruby.sh
[ -f $CHRUBY_PATH ] && . $CHRUBY_PATH
