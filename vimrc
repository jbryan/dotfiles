if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

call plug#begin('~/.vim/plugged')

Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}


Plug 'derekwyatt/vim-fswitch', { 'for': ['c', 'cpp', 'objc'] }
Plug 'derekwyatt/vim-protodef', { 'for': ['c', 'cpp', 'objc'] }

"Misc
Plug 'github/copilot.vim'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
"Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-rhubarb'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'vim-scripts/DetectIndent'
Plug 'ciaranm/detectindent'
Plug 'docunext/closetag.vim'
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript'
Plug 'mattn/webapi-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'google/vim-searchindex'
Plug 'mhinz/vim-signify'
Plug 'chrisbra/csv.vim'
Plug 'freitass/todo.txt-vim'
Plug 'diepm/vim-rest-console'
Plug 'editorconfig/editorconfig-vim'
"Plug 'w0rp/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'lifepillar/pgsql.vim'

"Plug 'rking/ag.vim'
Plug 'vim-scripts/gnupg'
Plug 'mbbill/undotree'

" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap gs :call fzf#vim#ag(expand('<cword>'))<CR>
nnoremap gt :call fzf#vim#tags(expand('<cword>'))<CR>
nnoremap <c-p> :FZF<cr>
vnoremap gs y:Ag <C-r>"<CR>
nnoremap gb :Buffers<CR>

" Todo.txt
nnoremap td :vs ~/Sync/todo/todo.txt<CR>

" Run in terminal
vnoremap tt :ter ++noclose<CR>
nnoremap tt :. ter ++noclose<CR>
nnoremap tp :ter ipython<CR>
nnoremap tb :ter ++noclose<CR>

function! s:build_qf_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-l': function('s:build_qf_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

"Auto closer
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
set undofile
set encoding=utf8
set ml
set dictionary="/etc/dictionaries-common/words"
set nobackup
set number
set backspace=indent,eol,start
set ve=block
set autoread
set clipboard=unnamedplus

"set undo paths
if !isdirectory($HOME . "/.cache/vim/backup")
    call mkdir($HOME . "/.cache/vim/backup", "p")
    call mkdir($HOME . "/.cache/vim/undo", "p")
    call mkdir($HOME . "/.cache/vim/swap", "p")
endif
set backupdir=~/.cache/vim/backup//
set undodir=~/.cache/vim/undo//
set directory=~/.cache/vim/swap//

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

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" tagbar
nnoremap <leader>e :TagbarOpenAutoClose<CR>
let g:tagbar_left=1
nmap qq :q<CR>

" nerdtree
nmap <leader>t :NERDTreeToggle<CR>

" undo tree
nmap <leader>u :UndotreeShow<CR>:UndotreeFocus<CR>

let g:NERDTreeQuitOnOpen=1

"Latex default compiler
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='lualatex'
let g:Tex_ViewRuleComplete_pdf='okular "$*.pdf" &'
let g:Tex_ViewRuleComplete_dvi='okular "$*.dvi" &'
let g:Tex_MultipleCompileFormats='dvi,pdf'

"clang complete options

"ALE options
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_completion_enabled = 0

let g:airline#extensions#coc#enabled = 1
let g:airline_extensions = ['branch', 'coc']
let g:airline_powerline_fonts=1

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"Signify
let g:signify_sign_add               = '→'
let g:signify_sign_delete            = '←'
let g:signify_sign_delete_first_line = '←'
let g:signify_sign_change            = '≈'
let g:signify_sign_changedelete      = g:signify_sign_change

"Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
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
let g:ale_python_pylint_options='--disable=line-too-long,missing-docstring'
autocmd FileType * let g:detectindent_preferred_indent=2
autocmd FileType python let g:detectindent_preferred_indent=4
autocmd FileType python let b:ale_fixers = ['black']
autocmd FileType python let b:ale_linters = ['pylint']
autocmd FileType python setlocal equalprg=black\ -q\ -

" xml
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" c++
autocmd FileType cpp let b:ale_fixers = ['clang-format']
nmap <silent> <Leader>of :FSHere<cr>
nmap <silent> <Leader>ol :FSRight<cr>
nmap <silent> <Leader>oL :FSSplitRight<cr>
nmap <silent> <Leader>oh :FSLeft<cr>
nmap <silent> <Leader>oH :FSSplitLeft<cr>
nmap <silent> <Leader>ok :FSAbove<cr>
nmap <silent> <Leader>oK :FSSplitAbove<cr>
nmap <silent> <Leader>oj :FSBelow<cr>
nmap <silent> <Leader>oJ :FSSplitBelow<cr>

"turn on syntax highlighting if available
if &t_Co > 1 || has("gui_running")
	colors jellyx
	syntax on
endif

" Language server
set hidden
" Or map each action separately
nnoremap <F5> :<C-u>call CocActionAsync("codeAction")<CR>
nnoremap <silent> K :<C-u>call CocActionAsync("doHover")<CR>
nnoremap <silent> gd :<C-u>call CocActionAsync("jumpDefinition")<CR>
nnoremap <silent> gr :<C-u>call CocActionAsync("jumpReferences")<CR>
nnoremap <silent> gi :<C-u>call CocActionAsync("jumpImplementation")<CR>
nnoremap <silent> <Leader>r :<C-u>call CocActionAsync("rename")<CR>
nnoremap <silent> <Leader>f :<C-u>call CocActionAsync("format")<CR>
vnoremap <silent> <Leader>f :<C-u>call CocActionAsync("formatSelected")<CR>
"set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

" Signature Settungs
nnoremap m? :SignatureListGlobalMarks<CR>

" Shortcut Shortcuts
nnoremap <Leader>scg :%!scsc get -<CR>
nnoremap <Leader>scc :%!scsc post -<CR>
nnoremap <Leader>scp :%!scsc put -<CR>
