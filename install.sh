#!/bin/sh
# This script assumes coreutils
set -x
export VERSION_CONTROL=numbered
BASE=$(pwd)

if [ -n "$CODESPACES" ]; then
	sudo apt-get install -y neovim fzf ripgrep
fi

# shell config
ln -bsT $BASE/profile			$HOME/.profile
ln -bsT $BASE/bash_profile		$HOME/.bash_profile
ln -bsT $BASE/bashrc			$HOME/.bashrc
ln -bsT $BASE/inputrc			$HOME/.inputrc

# vim config
mkdir -p $HOME/.config
mkdir -p $HOME/.local/share/nvim
ln -bsT $BASE/vim			$HOME/.vim
ln -bsT $BASE/vim			$HOME/.local/share/nvim/site
ln -bsT $BASE/vim			$HOME/.config/nvim
ln -bsT .vim/init.vim			$HOME/.vimrc
nvim +PlugInstall +qall
