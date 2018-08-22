if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

call plug#begin('~/.vim/plugged')

"Auto complete / programming tools
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'w0rp/ale'
Plug 'Rip-Rip/clang_complete'
Plug 'zchee/deoplete-jedi'
Plug 'derekwyatt/vim-fswitch', { 'for': ['c', 'cpp', 'objc'] }
Plug 'derekwyatt/vim-protodef', { 'for': ['c', 'cpp', 'objc'] }

"Misc
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'vim-scripts/DetectIndent'
Plug 'ciaranm/detectindent'
Plug 'docunext/closetag.vim'
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/ctrlp.vim'
Plug 'mattn/webapi-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rking/ag.vim'
Plug 'vim-scripts/gnupg'

"Auto closer
"Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-smartinput'

"Languages
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/glsl.vim'
Plug 'vim-latex/vim-latex'
Plug 'ekalinin/Dockerfile.vim'
Plug 'juvenn/mustache.vim'
Plug 'jbryan/opencl.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'hashivim/vim-terraform'
Plug 'jbryan/vim-yaml'
Plug 'vale1410/vim-minizinc'

"Color schemes / bling
Plug 'bling/vim-airline'
Plug 'vim-scripts/desert256.vim'
Plug 'fcpg/vim-fahrenheit'
Plug 'guns/jellyx.vim'

call plug#end()


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
set dictionary="/etc/dictionaries-common/words"
set nobackup
set number
set backspace=indent,eol,start
set ve=block
set autoread

"this should check if terminal supports it ... oh well
set t_Co=256

" Right mouse button extends selections
" Turn on mouse support
set nomousehide
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

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Mappings
nnoremap <silent> <F8> :TagbarToggle<CR>
nmap qq :q<CR>
nmap <leader>t :NERDTreeToggle<CR>

let g:NERDTreeQuitOnOpen=1

"Latex default compiler
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRuleComplete_pdf='evince "$*.pdf" &'
let g:Tex_ViewRuleComplete_dvi='evince "$*.dvi" &'
let g:Tex_MultipleCompileFormats='dvi,pdf'

"clang complete options

"ALE options
let g:ale_python_flake8_options='--ignore=E501,W291'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" disable autocomplete by default
"let b:deoplete_disable_auto_complete=1 
"let g:deoplete_disable_auto_complete=1
"call deoplete#custom#buffer_option('auto_complete', v:false)

if !exists('g:deoplete#omni#input_patterns')
		let g:deoplete#omni#input_patterns = {}
endif

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
						\ 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" set sources
let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header ="/usr/include/clang/"


"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=jedi#completions
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

"Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"Ag
let g:ag_lhandler="lopen"
nnoremap gr :LAg! '<cword>'<CR> 

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Thrift file
autocmd BufRead,BufNewFile *.thrift set ft=thrift
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
autocmd FileType * let g:detectindent_preferred_indent=2
autocmd FileType python let g:detectindent_preferred_indent=4
autocmd FileType python let b:ale_fixers = ['yapf']

" javascript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" html
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" css
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" xml
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" c++
autocmd FileType cpp let b:ale_fixers = ['clang-format']

"turn on syntax highlighting if available
if &t_Co > 1 || has("gui_running")
	colors jellyx
	syntax on
endif

" Use for grep
set grepprg=rg\ --vimgrep
command! -nargs=+ Rg execute 'silent grep! <args>' | copen 20
