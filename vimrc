set nocompatible
"pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags() "call this when installing new plugins
filetype plugin on
filetype indent on

let mapleader=","

"Settings
set nowrap
set showmode
set ruler
set wmnu
set hls
set foldmethod=marker
set formatoptions=tcqro
set incsearch	"incremental search
set ttymouse=xterm2
set history=1000
set undolevels=1000
set encoding=utf8
set ml

"this should check if terminal supports it ... oh well
set t_Co=256

" Hide the mouse pointer while typing
" The window with the mouse pointer does not automatically become the active window
" Right mouse button extends selections
" Turn on mouse support
set mousehide
set nomousefocus
set mousemodel=popup
set mouse=a

" Show paren matches
" For 5 tenths of a second
set showmatch
set matchtime=5

" Setup tabs for 4 spaces
:autocmd BufReadPost * :DetectIndent
:let g:detectindent_preferred_indent = 2
:let g:detectindent_preferred_expandtab = 1

set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set shiftround
set noexpandtab


" Mappings
nnoremap <silent> <F8> :TagbarToggle<CR>
nmap qq :q<CR>
nmap T :NERDTreeToggle<CR>

"Latex default compiler
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRuleComplete_pdf='okular "$*.pdf" &'
let g:Tex_ViewRuleComplete_dvi='okular "$*.pdf" &'
let g:Tex_MultipleCompileFormats='dvi,pdf'

"OmniCPPComplet options
let OmniCpp_MayCompleteDot=0
let OmniCpp_MayCompleteArrow=0
let OmniCpp_MayCompleteScope=0

"clang complete options
let g:clang_user_options="-I/usr/include/SDL"
let g:clang_complete_auto=0
"let g:clang_periodic_quickfix=1
nmap \ck :call g:ClangUpdateQuickFix() <CR> :cope <CR>

"Syntastic options
let g:syntastic_check_on_open=1


"Gist Options
let g:gist_detect_filetype = 1
let g:gist_show_privates = 1

" Only do this part when compiled with support for autocommands
if has("autocmd")
	" Json file
	autocmd BufRead,BufNewFile *.json set ft=javascript
	" In text files, always limit the width of text to 78 characters
	autocmd BufRead *.txt set tw=78
	" When editing a file, always jump to the last cursor position
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
	" don't write swapfile on most commonly used directories for NFS mounts or USB sticks
	autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
	" start with spec file template
	autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec

	" We want mail to use spell checking for Mutt
	autocmd FileType mail set spell
	" And we should expand tabs
	autocmd FileType mail set expandtab

	" Python
	autocmd FileType python set completefunc=pythoncomplete#Complete

	" javascript
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

	" html
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

	" css
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
endif

"turn on syntax highlighting if available
if &t_Co > 1 || has("gui_running")
	colors desert256
	syntax on
endif
