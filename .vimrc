""""""""""""""""""""""
" Package management "
""""""""""""""""""""""

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" General
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'

" Themes
Plugin 'morhetz/gruvbox'

" Navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'b4winckler/vim-angry'
Plugin 'dietsche/vim-lastplace'

" Code completion and linting
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'w0rp/ale'

" Language-specific
Plugin 'posva/vim-vue'
Plugin 'klen/python-mode'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tfnico/vim-gradle'
Plugin 'honza/dockerfile.vim'
Plugin 'mattn/emmet-vim'
Plugin 'vim-scripts/AnsiEsc.vim.git'

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
set formatoptions=lq              " Don't break comments at middle of words
set history=100                   " reasonable history
set lbr
set nocompatible                  " Ensure VIM really is in IMproved mode
set nowrap                        " don't wrap lines
set number                        " show line numbers
set ruler                         " show line/character in statusbar
set showcmd                       " show number of lines selected in visual
set wildmenu                      " Expanded menu for command-line completion
set cursorline                    " Show the cursorline
set guicursor=                    " Disable GUI cursor (not supported in Guake)

" File encodings
set encoding=utf-8
set fileencoding=utf-8

" Highlight searches, searches begin immediately
set hlsearch
set incsearch
if has('nvim')
  set inccommand=split
end

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

" Colorscheme
set background=dark
colorscheme gruvbox

" Show trailing whitespaces
au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Better show weird characters
set list listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•

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
    " Language : FR
    map ,lf :setlocal spell spelllang=fr<cr>
    " Language : EN
    map ,le :setlocal spell spelllang=en<cr>
    " Language : Aucun
    map ,ln :setlocal nospell<cr>
endif

" Powerline
set laststatus=2

" Disable expensive Python mode scripts : most of the useful things are
" handled by YCM and ALE which are asynchronous.
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_folding = 0

" YCM
let g:ycm_autoclose_preview_window_after_insertion = 1

" Indent Guides
let g:indent_guides_auto_colors = 1
autocmd VimEnter * silent exe ":IndentGuidesEnable"

" Netrw
let g:netrw_banner = 0         " No banner
let g:netrw_liststyle = 3      " Tree netrw style
let g:netrw_winsize = 20       " Smaller window size
let g:netrw_altv = 1           " Split on right by default
let g:netrw_browse_split = 0   " Reuse the same window when opening

" NERDCommenter
let g:NERDCustomDelimiters= {
      \ 'python': {'left': '# '}
\ }

" Ctrl-P
let g:ctrlp_regexp = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

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

" Space bar un-highligts search
noremap <silent> <Space> :silent noh<Bar>echo<CR>

" Tmux-like bindings
if has('nvim')
  noremap <C-b>n :tabnext<CR>
  noremap <C-b>c :tabnew<CR>
  noremap <C-b>s :new<CR>
  noremap <C-b>v :vnew<CR>
  tnoremap <C-b>n <C-\><C-n>:tabnext<CR>
  tnoremap <C-b>c <C-\><C-n>:tabnew<CR>:terminal<CR>
  tnoremap <C-b>s <C-\><C-n>:new<CR>:terminal<CR>
  tnoremap <C-b>v <C-\><C-n>:vnew<CR>:terminal<CR>
  tnoremap <C-b><Esc> <Esc>
  tnoremap <Esc> <C-\><C-n>
end

""""""""""""""""""""""""""
" Auto template commands "
""""""""""""""""""""""""""

"HTML Pages
augroup html
  au bufNewFile *.html 0r ~/.vim/templates/html
  au bufNewFile *.html silent exe "%s/%PLACE_CURSOR%//"
  au bufNewFile *.htm 0r ~/.vim/templates/html
  au bufNewFile *.htm silent exe "%s/%PLACE_CURSOR%//"
augroup END

"PHP Scripts
augroup php
  au bufNewFile *.php 0r ~/.vim/templates/php
  au bufNewFile *.php silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.php silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.php silent exe "%s/%PLACE_CURSOR%//"
augroup END

"CSS Stylesheets
augroup css
  au bufNewFile *.css 0r ~/.vim/templates/css
  au bufNewFile *.css silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.css silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.css silent exe "%s/%PLACE_CURSOR%//"
augroup END

"Bash scripts
augroup shellscripts
  au bufNewFile *.sh 0r ~/.vim/templates/bash
  au bufNewFile *.sh silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.sh silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.sh silent exe "%s/%PLACE_CURSOR%//"
augroup END

"Python Scripts
augroup pythonscripts
  au bufNewFile *.py 0r ~/.vim/templates/python
  au bufNewFile *.py silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.py silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.py silent exe "%s/%PLACE_CURSOR%//"
  au bufNewFile *.py2 0r ~/.vim/templates/python2
  au bufNewFile *.py2 silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.py2 silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.py2 silent exe "%s/%PLACE_CURSOR%//"
augroup END

"C++ Source files
augroup c_cpp
  au bufNewFile *.cpp 0r ~/.vim/templates/cpp
  au bufNewFile *.cpp silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.cpp silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.cpp silent exe "%s:%PLACE_FILENOEXT%:".substitute(expand("%"), ".cpp$", "", "g").":g"
  au bufNewFile *.cpp silent exe "%s/%PLACE_CURSOR%//"
  au bufNewFile *.hpp 0r ~/.vim/templates/hpp
  au bufNewFile *.hpp silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.hpp silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.hpp silent exe "%s:%PLACE_FILENOEXT%:".substitute(expand("%"), ".hpp$", "", "g").":g"
  au bufNewFile *.hpp silent exe "%s/%PLACE_CURSOR%//"
  au bufNewFile *.c 0r ~/.vim/templates/c
  au bufNewFile *.c silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.c silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.c silent exe "%s/%PLACE_CURSOR%//"
  au bufNewFile *.h 0r ~/.vim/templates/h
  au bufNewFile *.h silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.h silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.h silent exe "%s/%PLACE_CURSOR%//"
augroup END

"Haskell Source files
augroup haskell
  au bufNewFile *.hs 0r ~:.vim:templates:hs
  au bufNewFile *.hs silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.hs silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.hs silent exe "%s/%PLACE_FILENOEXT%/".substitute(expand("%"), ".hs$", "", "g")."/g"
augroup END

"C Headers

"Java source code
augroup java
  au bufNewFile *.java 0r ~/.vim/templates/java
  au bufNewFile *.java silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.java silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.java silent exe "%s:%PLACE_FILENOEXT%:".substitute(expand("%"), ".java$", "", "g").":g"
  au bufNewFile *.java silent exe "%s/%PLACE_CURSOR%//"
augroup END

"C for CUDA source code
augroup cuda
  au bufNewFile *.cu 0r ~/.vim/templates/cu
  au bufNewFile *.cu silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.cu silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.cu silent exe "%s/%PLACE_CURSOR%//"
augroup END

"Ninja Build Script
augroup ninja
  au bufNewFile *.ninja 0r ~/.vim/templates/ninja
  au bufNewFile *.ninja silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.ninja silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.ninja silent exe "%s/%PLACE_CURSOR%//"
augroup END

"JavaScript
augroup js
  au bufNewFile *.js 0r ~/.vim/templates/js
  au bufNewFile *.js silent exe "%s:%PLACE_FILENAME%:".expand("%").":g"
  au bufNewFile *.js silent exe "%s/%PLACE_CREATETIME%/".strftime("%c")."/g"
  au bufNewFile *.js silent exe "%s/%PLACE_CURSOR%//"
augroup END

"Ruby
augroup rb
  au bufNewFile *.rb 0r ~/.vim/templates/rb
augroup END

"QGIS XML files
augroup qgis
  au bufRead,bufNewFile *.qml set syntax=xml
  au bufRead,bufNewFile *.qpt set syntax=xml
  au bufRead,bufNewFile *.qgs set syntax=xml
augroup END

"SQL scripts
augroup sql
  au bufRead,bufNewFile *.sql set formatprg="sqlformat -kupper -r -"
augroup END

"Log files with color
augroup logfiles
  au bufRead *.log AnsiEsc
augroup END

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

" Allow (secure) project-specific settings
set exrc
set secure
