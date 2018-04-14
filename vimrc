set nocompatible

"Set $VIMDIR to ~/.vim if unset
if empty($VIMDIR)
  let $VIMDIR = glob('~') . '/.vim'
else
  let g:vimdir = $VIMDIR
end

"Install vimplug, if not present
if empty(glob($VIMDIR . '/autoload/plug.vim'))
  silent !curl -fLo $VIMDIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  call mkdir($VIMDIR . '/spell', 'p')
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin($VIMDIR . '/plugged')
"Trick for conditional activation [https://github.com/junegunn/vim-plug/wiki/faq#conditional-activation]
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

"Well it's only sensible
Plug 'tpope/vim-sensible'

"GUI colour scheme
Plug 'altercation/vim-colors-solarized', Cond(has('gui_running'))

"Airline
Plug 'bling/vim-airline'
  Plug 'powerline/fonts', { 'dir': $VIMDIR . '/fonts/powerline', 'do': './install.sh' }
  Plug 'vim-airline/vim-airline-themes'

"Change quoting
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

"Don't ruin layout with buffer closes
Plug 'vim-scripts/kwbdi.vim'

"Automatic syntax checking
Plug 'vim-syntastic/syntastic', { 'on': [] }
"Delay syntatic load until we aren't doing anything
augroup LazySyntatic
  autocmd!
  autocmd CursorHold * :call plug#load('syntastic')
  autocmd CursorHold * :autocmd! LazySyntatic
augroup END

"You complete me
if !empty(glob($VIMDIR . '/enable_ycm'))
  let args = join(readfile(glob($VIMDIR . '/enable_ycm')), ' ')
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py' . ' ' . args}
end

"Comment stuff in and out
Plug 'tpope/vim-commentary'

"Toggle line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

"Nice mapping pairs from tpope
Plug 'tpope/vim-unimpaired'

"One of the only thins I've missed from Emacs
Plug 'vim-scripts/YankRing.vim', { 'do': 'mkdir -p $VIMDIR/tmp' }
"Where the yankring history file is kept
let g:yankring_history_dir = $VIMDIR . "/tmp"

"I like to know far I have to go
Plug 'henrik/vim-indexed-search'

"UNIX stuff directly from Vim
Plug 'tpope/vim-eunuch'

"Look at all the colours!
Plug 'junegunn/rainbow_parentheses.vim'

"Better search experience
Plug 'junegunn/vim-slash'

"Git stuff
Plug 'airblade/vim-gitgutter'

"Scratch buffer
Plug 'vim-scripts/scratch.vim'

"Visual undo tree
Plug 'mbbill/undotree'

"Ruby stuff
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }

"Fish syntax highlighting
Plug 'dag/vim-fish', { 'for': 'fish' }

"Puppet
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
let g:puppet_align_hashes = 0

"Golang
Plug 'fatih/vim-go', { 'for': 'go' }
autocmd! User vim-go set nolist

"Automatic line breaks
Plug 'reedes/vim-pencil', { 'for': 'markdown' }

call plug#end()

set hidden

set ignorecase
set smartcase
set hlsearch

set visualbell

set number

if has('gui_running')
  colorscheme solarized
  set background=dark

  " We have powerline fonts
  let g:airline_powerline_fonts = 1
  let g:airline_theme = 'solarized'

  "Turn off tool bar
  set guioptions-=T
  "Turn off scrollbar
  set guioptions-=r

  set cursorline

  if has("gui_macvim")
    set guifont=Roboto\ Mono\ Light\ for\ Powerline:h16
  else
    set guifont=Roboto\ Mono\ Light\ for\ Powerline\ 10
  endif
else
  colorscheme desert
  let g:airline_theme = 'term'
  set nocursorline
endif

set expandtab
set shiftwidth=2
set tabstop=2

set list
set listchars=tab:→\ ,trail:·,extends:<,precedes:>,nbsp:␣

set nowrap

set wildmode=longest,full

set foldmethod=syntax
set nofoldenable

set backupdir^=$VIMDIR/backup
set directory^=$VIMDIR/tmp
if version >= 703
  set undodir^=$VIMDIR/undo
endif

"Force diff to use vertical split
set diffopt+=vertical

"Insert date
:inoremap <C-D> <C-R>=strftime("%F")<CR>

"Use posix shell highlighting for sh scripts
let g:is_posix = 1

"Spelling defaults
set spelllang=en_gb,da
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell

"Fat fingers
nmap <F1> <nop>
imap <F1> <nop>

