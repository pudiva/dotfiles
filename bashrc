# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1="\u@\h:\W\$ "
export VISUAL="nvim"
export EDITOR="nvim -e"
export PAGER="less"
export LESS="FRX--mouse"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
#alias ssh="TERM=xterm-256color ssh"
