#!/bin/sh
# This script assumes coreutils
set +x
export VERSION_CONTROL=numbered
LNOPTS=""
BASE="`pwd`"

dotlink() {
	target="$BASE/$1"
	link_name="$HOME/$2"
	mkdir -p "`dirname "$link_name"`"
	ln $LNOPTS -rsT "$target" "$link_name"
}

if [ -n "$CODESPACES" ]
then
	set -- "-b" "$@" # default to -b on codespaces
fi

while getopts ":ibf" opt
do
	case $opt in
	i) LNOPTS="$LNOPTS -i";;
	b) LNOPTS="$LNOPTS -b";;
	f) LNOPTS="$LNOPTS -f";;
	\?)
		echo "Invalid option: -$OPTARG" >&2
		exit -1
		;;
	esac
done

if [ -n "$CODESPACES" ]
then
	sudo apt-get update
	sudo apt-get install -y neovim fzf ripgrep bat netcat

	# alacritty terminfo
	curl -fL 'https://raw.githubusercontent.com/alacritty/alacritty/refs/tags/v0.13.2/extra/alacritty.info' | \
		tic -xe alacritty,alacritty-direct /dev/stdin
fi

plug_vim="vim/autoload/plug.vim"
plug_vim_url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if [ ! -f "$plug_vim" ]; then
	curl -fLo "$plug_vim" --create-dirs "$plug_vim_url" && \
		nvim +PlugInstall +qa
fi

dotlink profile		.profile
dotlink bash_profile	.bash_profile
dotlink bashrc		.bashrc
dotlink inputrc		.inputrc
dotlink vim		.config/nvim
dotlink vim		.vim
dotlink vim/init.vim	.vimrc
dotlink alacritty.yml	.alacritty.yml
dotlink sway		.config/sway
