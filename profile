#!/bin/sh
# pudiva's ~/.profile

path_append() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		export PATH="${PATH:+"$PATH:"}$1"
	fi
}

path_prepend(){
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		export PATH="$1${PATH:+":$PATH"}"
	fi
}

export VISUAL="nvim"
export EDITOR="nvim -e"
export PAGER="less"
export LESS="FRX--mouse"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export GOPATH="$HOME/go"

path_prepend "$GOPATH/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"

[ -f "$HOME/.secrets" ] && . "$HOME/.secrets"
