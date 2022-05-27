#!/bin/sh
# This script assumes coreutils
set -x
export VERSION_CONTROL=numbered
BASE=$(pwd)
ln="ln -bsT"

while getopts ":i" opt
do
	case $opt in
		i)
			ln="$ln -i"
			set +x
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit -1
			;;
	esac
done

if [ -n "$CODESPACES" ]
then
	sudo apt-get update
	sudo apt-get install -y neovim fzf ripgrep bat
fi

# shell config
$ln $BASE/profile			$HOME/.profile
$ln $BASE/bash_profile			$HOME/.bash_profile
$ln $BASE/bashrc			$HOME/.bashrc
$ln $BASE/inputrc			$HOME/.inputrc

# vim config
mkdir -p $HOME/.config
mkdir -p $HOME/.local/share/nvim
$ln $BASE/vim				$HOME/.vim
$ln $BASE/vim				$HOME/.local/share/nvim/site
$ln $BASE/vim				$HOME/.config/nvim
$ln .vim/init.vim			$HOME/.vimrc
nvim +PlugInstall +qall

# other stuff
$ln $BASE/alacritty.yml			$HOME/.alacritty.yml
