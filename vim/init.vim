" satana's ~/.vimrc

set backspace=
set history=666
set ruler
set hlsearch
set visualbell
set mouse=a
set incsearch
set ignorecase
set smartcase
set smartindent
set nofoldenable
set background=dark
silent! set notermguicolors
silent! set nocompatible
silent! set ttymouse=sgr
silent! set diffopt+=internal
silent! set diffopt+=algorithm:patience
silent! set diffopt+=indent-heuristic

silent! colorscheme vim

filetype plugin indent on
syn on
au FileType c set cc=81
au FileType ruby,eruby,yaml,json,markdown,html,javascript setl ts=2 et
au FileType dot setl mp=dot\ -Tpdf\ %\ >\ %.pdf\ \&&\ mupdf\ %.pdf

iab xdate <c-r>=strftime("%Y-%m-%d")<cr>
iab xjn __<c-r>=strftime("%Y-%m-%d")<cr>__<Esc>hi
iab xjt <Esc>:let t=v:lang<cr>:lan C<cr>i<c-r>=strftime("%Y-%m-%d %a")<cr><cr>--------------<cr><cr><Esc>:exe 'lan' t<cr>i

" use plugins if there's vim-plug installed
if !empty(globpath(&rtp, 'autoload/plug.vim'))
	call plug#begin()
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'tikhomirov/vim-glsl'
	Plug 'ojroques/vim-oscyank', {'branch': 'main'}
	Plug 'godlygeek/tabular'
	Plug 'preservim/vim-markdown'
	call plug#end()

	" fix annoying markdown list indentation
	if exists('g:vim_markdown_new_list_item_indent')
		let g:vim_markdown_new_list_item_indent = 2
	endif

	" OSC Yank (clipboard over SSH)
	if (!has('nvim-0.10') && !has('clipboard_working'))
		" In the event that the clipboard isn't working, it's quite likely that
		" the + and * registers will not be distinct from the unnamed register. In
		" this case, a:event.regname will always be '' (empty string). However, it
		" can be the case that `has('clipboard_working')` is false, yet `+` is
		" still distinct, so we want to check them all.
		let s:VimOSCYankPostRegisters = ['', '+', '*']
		function! s:VimOSCYankPostCallback(event)
			if a:event.operator == 'y' && index(s:VimOSCYankPostRegisters, a:event.regname) != -1
				call OSCYankRegister(a:event.regname)
			endif
		endfunction
		augroup VimOSCYankPost
			autocmd!
			autocmd TextYankPost * call s:VimOSCYankPostCallback(v:event)
		augroup END
	endif
endif
