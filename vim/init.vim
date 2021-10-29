" pudiva's ~/.vimrc

set backspace=
set history=666
set ruler
set hls
set vb
set mouse=a

if has("patch-8.1.0360")
	set diffopt+=internal
	set diffopt+=algorithm:patience
	set diffopt+=indent-heuristic
endif

set ignorecase
set smartcase
set incsearch

" color column on F12
nnoremap <silent> <F12> :execute "set cc=" . (&cc == "" ? "81,73" : "")<CR>

" filetypes with 2 space indentation
au FileType ruby,eruby,yaml,json,markdown,html,javascript setl ts=2 sw=2 et

" build graphviz .dot files
au FileType dot setl mp=dot\ -Tpdf\ %\ >\ %.pdf\ \&&\ mupdf\ %.pdf

" nvim specific
if has('nvim')
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
	let &packpath=&runtimepath
else
	set nocompatible
	set guifont=Monospace\ 10
	set ttymouse=sgr

	filetype plugin indent on
	syn on
endif

" terminal-specific
if $TERM =~ '^\(alacritty\|st\)'
	if exists('+termguicolors')
		let &t_8f="[38;2;%lu;%lu;%lum"
		let &t_8b="[48;2;%lu;%lu;%lum"
		set termguicolors
	endif

	if !has('nvim') && !has('gui_running')
		set background=dark
	endif
endif

" plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'vim-test/vim-test'
Plug 'tikhomirov/vim-glsl'
call plug#end()

" test on F11
au FileType ruby nmap <silent> <F11> :TestNearest<CR>
