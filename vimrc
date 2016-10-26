set nocompatible

if $SHELL =~ 'fish'
  set shell=/bin/sh
endif

call plug#begin('~/.vim/plugged')
"Well it's only sensible
Plug 'tpope/vim-sensible'

"GUI colour scheme
Plug 'altercation/vim-colors-solarized'

"Powerline
Plug 'powerline/fonts', { 'dir': g:plug_home . '/../fonts/powerline', 'do': './install.sh' } |
  Plug 'powerline/powerline', { 'tag': 'master', 'rtp': 'powerline/bindings/vim/' }

"Change quoting
Plug 'tpope/vim-surround'

"Don't ruin layout with buffer closes
Plug 'vim-scripts/kwbdi.vim'

"Automatic syntax checking
Plug 'scrooloose/syntastic'

"Comment stuff in and out
Plug 'tpope/vim-commentary'

"Toggle line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

"Nice mapping pairs from tpope
Plug 'tpope/vim-unimpaired'

"One of the only thins I've missed from Emacs
Plug 'vim-scripts/YankRing.vim', { 'do': 'mkdir -p ' . g:plug_home . '/../tmp' }

"I like to know far I have to go
Plug 'henrik/vim-indexed-search'

"UNIX stuff directly from Vim
Plug 'tpope/vim-eunuch'

"Look at all the colours!
Plug 'kien/rainbow_parentheses.vim'

"Ruby stuff
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }

"Fish syntax highlighting
Plug 'dag/vim-fish', { 'for': 'fish' }

"Git stuff
Plug 'tpope/vim-fugitive'

call plug#end()

syntax on
filetype plugin indent on

set hidden

set ignorecase
set smartcase
set hlsearch

set visualbell

set number

if has('gui_running')
  colorscheme solarized
  set background=dark

  "Powerline theme
  let g:powerline_config_overrides={"ext": {"vim": {"colorscheme": "solarized"}}}

  "Turn off tool bar
  set guioptions-=T
  "Turn off scrollbar
  set guioptions-=r

  set cursorline

  if has("gui_macvim")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h16
  else
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
  endif
else
  colorscheme desert
  set nocursorline
  "Trick powerline into thinking it is already loaded
  let g:powerline_loaded = 1
endif

set backupdir^=~/.vim/backup
set directory^=~/.vim/tmp
if version >= 703
  set undodir^=~/.vim/undo
endif

set expandtab
set shiftwidth=2
set tabstop=2

set list
set listchars=tab:→\ ,trail:·,extends:<,precedes:>,nbsp:␣

set nowrap

set foldmethod=syntax
set nofoldenable

set wildmode=longest,list,full

"Remap annoying numbertoggle, so it doesn't interfere with yankring
let g:NumberToggleTrigger = "<F10>"

"Where the yankring history file is kept
let g:yankring_history_dir = g:plug_home . "/../tmp"

