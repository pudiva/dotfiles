#!/bin/sh
# This script assumes coreutils
set +x
export VERSION_CONTROL=numbered
BASE=$(pwd)
ln='ln -sT'

while getopts ":ibf" opt
do
	case $opt in
	i) ln="$ln -i";;
	b) ln="$ln -b";;
	f) ln="$ln -f";;
	\?)
		echo "Invalid option: -$OPTARG" >&2
		exit -1
		;;
	esac
done

if [ -n "$CODESPACES" ]; then
	sudo apt-get update
	sudo apt-get install -y neovim fzf ripgrep bat netcat
	ln="$ln -b"

	# install alacritty terminfo
	curl -fL 'https://raw.githubusercontent.com/alacritty/alacritty/refs/tags/v0.13.2/extra/alacritty.info' | \
		tic -xe alacritty,alacritty-direct /dev/stdin
fi

# shell config
$ln $BASE/profile			$HOME/.profile
$ln $BASE/bash_profile			$HOME/.bash_profile
$ln $BASE/bashrc			$HOME/.bashrc
$ln $BASE/inputrc			$HOME/.inputrc

# vim config
mkdir -p $HOME/.config
$ln $BASE/vim				$HOME/.vim
$ln $BASE/vim				$HOME/.config/nvim
$ln .vim/init.vim			$HOME/.vimrc

plug_vim="$BASE/vim/autoload/plug.vim"
plug_vim_url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if [ ! -f "$plug_vim" ]; then
	curl -fLo "$plug_vim" --create-dirs "$plug_vim_url" && \
		nvim +PlugInstall +qa
fi

# other stuff
$ln $BASE/alacritty.yml			$HOME/.alacritty.yml
