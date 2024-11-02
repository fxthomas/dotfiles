
" Load Archlinux packages
" so /etc/xdg/nvim/sysinit.vim

" Some default options
set nocompatible                  " Improved mode (always the case for nvim)
set autoread                      " Auto reload modified files (:help autoread)
set backspace=indent,eol,start    " Backspace erases in insert mode (:help i_backspace)
set backup                        " Enable backups (:help backup)
set formatoptions=lq              " Don't break comments at middle of words (:help fo-table)
set history=100                   " Reasonable history
set linebreak                     " Line wrap will break at words
set nowrap                        " Don't wrap lines
set number                        " Show line numbers
set ruler                         " Show line/character in statusbar
set showcmd                       " Show number of lines selected in Visual mode
set wildmenu                      " Completion using a menu
set cursorline                    " Show the cursorline
set laststatus=2                  " Always display status line
set exrc                          " Allow project-specific settings
set secure                        " Only allow secure options in project-specific settings

" Search behavior
set hlsearch                      " Highlight matches during search
set incsearch                     " Update search results as the search pattern is typed
set inccommand=split
set ignorecase
set smartcase
set infercase
" Space bar un-highlights search
noremap <silent> <Space> :silent noh<Bar>echo<CR>

" Tab settings
set expandtab                     " tabs as space
set shiftwidth=2                  " set spaces for autoindent
set smartindent                   " smart autoindenting on a new line
set softtabstop=2
set tabstop=2                     " tab character amount

" Tmux-like bindings
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

" Folding (disabled by default)
set foldcolumn=1
set foldmethod=manual
set foldlevelstart=10
set nofoldenable

" Navigation
set nostartofline                 " navigate closest column
set showtabline=2                 " tab bar always on

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

" Show trailing whitespaces
au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Better show weird characters
set list listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•

" Enable syntax highlighting
syntax on

" Enable filetype plugins
filetype on
filetype plugin on
filetype plugin indent on
lua require('initlsp')

" Backup in ~/.vim/backup
if filewritable(expand("~/.vim/backup")) == 2
  set backupdir=$HOME/.vim/backup
else
  if has("unix") || has("win32unix")
    call system("mkdir $HOME/.vim/backup -p")
    set backupdir=$HOME/.vim/backup
  endif
endif
