""""""""""""""""""""""
" Package management "
""""""""""""""""""""""

set nocompatible
filetype off
call plug#begin('~/AppData/Local/nvim/plugged')

" General
Plug 'VundleVim/Vundle.vim'
Plug 'vim-airline/vim-airline'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'editorconfig/editorconfig-vim'

" Themes
Plug 'morhetz/gruvbox'

" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'b4winckler/vim-angry'
Plug 'dietsche/vim-lastplace'

" Code completion and linting
" Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Language-specific
Plug 'klen/python-mode'
Plug 'nelstrom/vim-markdown-folding'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'tfnico/vim-gradle'
Plug 'honza/dockerfile.vim'
Plug 'mattn/emmet-vim'
Plug 'PProvost/vim-ps1'
" Plug 'vim-scripts/AnsiEsc.vim.git'

call plug#end()

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

" Powershell is our shell (but keep diff running)
" if has('win32')
"   set shell=powershell
"   set diffexpr="diff.exe -a v:fname_in v:fname_new > v:fname_out"
" end

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

" Use Ctrl-Wheel to change font size
let s:fontsize = 11
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Consolas:h" . s:fontsize
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

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
if filewritable(expand("~/AppData/Local/nvim/backup")) == 2
	set backupdir=~/AppData/Local/nvim/backup
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

" Netrw: Default configuration settings
let g:netrw_banner = 0         " No banner
let g:netrw_liststyle = 3      " Tree netrw style
let g:netrw_winsize = 20       " Smaller window size
let g:netrw_altv = 1           " Split on right by default
let g:netrw_browse_split = 0   " Reuse the same window when opening

" Netrw: Automatically open a left-explore window if launched with no arguments
"
" Interestingly, Lexplore will by default work much better than Vexplore for
" IDE-style file explorer, because the window won't resize the way standard
" Vim windows do (like Vexplore and Sexplore).
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * if argc() == 0 | Lexplore | endif
augroup END

" NERDCommenter: Use PEP8-compliant Python comments (space between # and text)
let g:NERDCustomDelimiters= {
      \ 'python': {'left': '# '}
\ }

" CtrlP: Allow regular expressions, and use Git to take .gitignore into account
let g:ctrlp_regexp = 1
let g:ctrlp_clear_cache_on_exit = 0
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Change Python paths
let g:python_host_prog = 'C:\Python27\python.exe'

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
