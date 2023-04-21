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

path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
[ -f "$HOME/.secrets" ] && . "$HOME/.secrets"
