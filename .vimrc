""""""""""""""""""""""
" Package management "
""""""""""""""""""""""

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'klen/python-mode'

Plugin 'vimoutliner/vimoutliner'
Plugin 'nelstrom/vim-markdown-folding'

Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'bling/vim-airline'
Plugin 'tfnico/vim-gradle'
Plugin 'honza/dockerfile.vim'
Plugin 'b4winckler/vim-angry'

Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'

Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'vim-scripts/AnsiEsc.vim.git'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-unimpaired'

call vundle#end()

"""""""""""""""""""""""""
" Common editor options "
"""""""""""""""""""""""""

" Common options
set re=1
set ttyfast
set autoread                      " Auto reload modified files
set backspace=indent,eol,start    " backspace erases in insert mode
set backup
set formatoptions=l               " Don't break comments at middle of words
set history=100                   " reasonable history
set lbr
set nocompatible                  " Ensure VIM really is in IMproved mode
set nowrap                        " don't wrap lines
set number                        " show line numbers
set ruler                         " show line/character in statusbar
set showcmd                       " show number of lines selected in visual
set wildmenu                      " Expanded menu for command-line completion
set cursorline                    " Show the cursorline

" File encodings
set encoding=utf-8
set fileencoding=utf-8

" Highlight searches, searches begin immediately
set hlsearch
set incsearch

" Non-case-sensitive searches
set ignorecase
set smartcase
set infercase

" Tab settings
set expandtab                     " tabs as space
set shiftwidth=2                  " set spaces for autoindent
set smartindent                   " smart autoindenting on a new line
set softtabstop=2
set tabstop=2                     " tab character amount

" Folding (disabled by default)
set foldcolumn=1
set foldmethod=manual
set foldlevelstart=10
set nofoldenable

" Navigation
set nostartofline                 " navigate closest column
set showtabline=2                 " tab bar always on

" Disable visual bells
set t_vb=''

" Mouse support (cursor position, tab selection - hold shift to select
" n = normal mode, i = insert, c = command, a = all
set mouse=ni

set scrolloff=4

" Setting menu tab completion
set wildignore+=*.o,*~,.lo
set wildignore+=.jpg,.png,.jpeg,.gif,~,.swp,.swo,.info,.o,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo
set suffixes+=.in,.a

" Leader key is ','
let mapleader=","

" Add easier foldlevel aliases
map z0 :set foldlevel=0<CR>
map z1 :set foldlevel=1<CR>
map z2 :set foldlevel=2<CR>
map z3 :set foldlevel=3<CR>
map z4 :set foldlevel=4<CR>
map z5 :set foldlevel=5<CR>
map z6 :set foldlevel=6<CR>
map z7 :set foldlevel=7<CR>
map z8 :set foldlevel=8<CR>
map z9 :set foldlevel=9<CR>
map ze :set foldenable foldmethod=indent foldlevelstart=0 foldlevel=0<CR>
map zd :set nofoldenable foldmethod=manual foldlevelstart=99<CR>

" Ctrl-A increments on a whole line
vmap <C-a> :s/\d\+/\=(submatch(0)+1)/g<CR>gv

" Auto-reload .vimrc when saved
au! bufWritePost .vimrc source %

""""""""""""""
" Appearance "
""""""""""""""

" Lettuce colorscheme
colorscheme lettuce

" Show trailing whitespaces
au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Use 256 color palette if available
if &term=="xterm"
 set t_Co=256
endif

""""""""""""""""""
" Syntax options "
""""""""""""""""""

" Enable syntax highlighting
syntax on

" Enable filetype plugins
filetype on
filetype plugin on
filetype plugin indent on

" Default completion function
set ofu=syntaxcomplete#Complete

" Disable completion for included files
set complete-=i

"""""""""""
" Plugins "
"""""""""""

" Backup in ~/.vim/backup
if filewritable(expand("~/.vim/backup")) == 2
	set backupdir=$HOME/.vim/backup
else
	if has("unix") || has("win32unix")
		call system("mkdir $HOME/.vim/backup -p")
		set backupdir=$HOME/.vim/backup
	endif
endif

" Vim 7 spell checker
if has("spell")
    setlocal spell spelllang=
    " Language : FR
    map ,lf :setlocal spell spelllang=fr<cr>
    " Language : EN
    map ,le :setlocal spell spelllang=en<cr>
    " Language : Aucun
    map ,ln :setlocal spell spelllang=<cr>
endif

" Powerline
set laststatus=2

" Tagbar
map <Leader>c :TagbarToggle<CR>

" Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
noremap <leader>f :Unite -buffer-name=files   -start-insert file_rec/async<cr>
noremap <leader>d :Unite -buffer-name=files   -start-insert file<cr>
noremap <leader>r :Unite -buffer-name=mru     -start-insert file_mru<cr>
noremap <leader>y :Unite -buffer-name=yank    history/yank<cr>
noremap <leader>e :Unite -buffer-name=buffer  buffer<cr>

" Syntastic
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_auto_loc_list = 1
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--max-line-length=95'
"let g:syntastic_auto_loc_list=2

" Disable expensive Python mode scripts : most of the useful things are handled
" by YCM and Syntastic.
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_folding = 0

" Indent Guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#080808 ctermbg=232
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#121212 ctermbg=233
autocmd VimEnter * silent exe ":IndentGuidesEnable"

" NERDCommenter
let g:NERDCustomDelimiters= {
      \ 'python': {'left': '# '}
\ }

"""""""""""""""""""""
" Keyboard bindings "
"""""""""""""""""""""

" Copy/Paste using Ctrl-C and Ctrl-V
vmap <C-c> "+y
vmap <C-x> "+d
imap <C-v> <Esc>"+pi

" Wrapped line navigation
noremap <C-J> gj
noremap <C-K> gk

" Run "make" with Enter
" noremap <C-M> :!make<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" New tab with ,t and Ctrl-T
map <Leader>t :tabnew<CR>
nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:tabnew<CR>
map <Leader>n :tabnext<CR>
map <Leader>p :tabprevious<CR>
map <Leader>s :sort<CR>

" Space bar un-highligts search
noremap <silent> <Space> :silent noh<Bar>echo<CR>

""""""""""""""""""""""""""
" Auto template commands "
""""""""""""""""""""""""""

"HTML Pages
au bufNewFile *.html 0r ~/.vim/templates/html
au bufNewFile *.html silent exe "%s/%PLACE_CURSOR%//"
au bufNewFile *.htm 0r ~/.vim/templates/html
au bufNewFile *.htm silent exe "%s/%PLACE_CURSOR%//"

"PHP Scripts
au bufNewFile *.php 0r ~/.vim/templates/php
au bufNewFile *.php silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.php silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.php silent exe "%s/%PLACE_CURSOR%//"

"CSS Stylesheets
au bufNewFile *.css 0r ~/.vim/templates/css
au bufNewFile *.css silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.css silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.css silent exe "%s/%PLACE_CURSOR%//"

"Bash scripts
au bufNewFile *.sh 0r ~/.vim/templates/bash
au bufNewFile *.sh silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.sh silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.sh silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.sh vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1# \2/g<CR>:silent noh<CR>

"Python Scripts
au bufNewFile *.py 0r ~/.vim/templates/python
au bufNewFile *.py silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.py silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.py silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.py vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1# \2/g<CR>:silent noh<CR>

"Python2 Scripts
au bufNewFile *.py2 0r ~/.vim/templates/python2
au bufNewFile *.py2 silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.py2 silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.py2 silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.py2 vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1# \2/g<CR>:silent noh<CR>

"C++ Source files
au bufNewFile *.cpp 0r ~/.vim/templates/cpp
au bufNewFile *.cpp silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.cpp silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.cpp silent exe "%s:%PLACE_FILENOEXT%:".substitute(expand("%"), ".cpp$", "", "g").":g"
au bufNewFile *.cpp silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.cpp vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1\/\/ \2/g<CR>:silent noh<CR>

"Haskell Source files
au bufNewFile *.hs 0r ~:.vim:templates:hs
au bufNewFile *.hs silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.hs silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.hs silent exe "%s/%PLACE_FILENOEXT%/".substitute(expand("%"), ".hs$", "", "g")."/g"

"C++ Headers
au bufNewFile *.hpp 0r ~/.vim/templates/hpp
au bufNewFile *.hpp silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.hpp silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.hpp silent exe "%s:%PLACE_FILENOEXT%:".substitute(expand("%"), ".hpp$", "", "g").":g"
au bufNewFile *.hpp silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.hpp vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1\/\/ \2/g<CR>:silent noh<CR>

"C Source files
au bufNewFile *.c 0r ~/.vim/templates/c
au bufNewFile *.c silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.c silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.c silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.c vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1\/\/ \2/g<CR>:silent noh<CR>

"C Headers
au bufNewFile *.h 0r ~/.vim/templates/h
au bufNewFile *.h silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.h silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.h silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.h vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1\/\/ \2/g<CR>:silent noh<CR>

"Java source code
au bufNewFile *.java 0r ~/.vim/templates/java
au bufNewFile *.java silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.java silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.java silent exe "%s:%PLACE_FILENOEXT%:".substitute(expand("%"), ".java$", "", "g").":g"
au bufNewFile *.java silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.java vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1\/\/ \2/g<CR>:silent noh<CR>

"C for CUDA source code
au bufNewFile *.cu 0r ~/.vim/templates/cu
au bufNewFile *.cu silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.cu silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.cu silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.cu vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1\/\/ \2/g<CR>:silent noh<CR>

"Ninja Build Script
au bufNewFile *.ninja 0r ~/.vim/templates/ninja
au bufNewFile *.ninja silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.ninja silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.ninja silent exe "%s/%PLACE_CURSOR%//"

"JavaScript
au bufNewFile *.js 0r ~/.vim/templates/js
au bufNewFile *.js silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
au bufNewFile *.js silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
au bufNewFile *.js silent exe "%s/%PLACE_CURSOR%//"
au bufRead,bufNewFile *.js vmap <C-/> :s/^\([ \t]*\)\(.*\)/\1\/\/ \2/g<CR>:silent noh<CR>
au bufRead,bufNewFile *.js vmap \ :s/^\([ \t]*\)\/\/ *\(.*\)/\1\2/g<CR>:silent noh<CR>

"JSON
au bufRead,bufNewFile *.json map <C-j> :%w !jsonv<CR>

"Lua
au bufRead,bufNewFile *.lua map <C-j> :%w !luav<CR>

" Log files with color
" au bufRead *.log AnsiEsc

function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction
command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
