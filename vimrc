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

"Powerline
Plug 'powerline/fonts', { 'dir': $VIMDIR . '/fonts/powerline', 'do': './install.sh' } |
  Plug 'powerline/powerline', Cond(has('gui_running'), { 'tag': 'master', 'rtp': 'powerline/bindings/vim/' })

"Change quoting
Plug 'tpope/vim-surround'

"Don't ruin layout with buffer closes
Plug 'vim-scripts/kwbdi.vim'

"Automatic syntax checking
Plug 'scrooloose/syntastic', { 'on': [] }
"Delay syntatic load until we aren't doing anything
augroup LazySyntatic
  autocmd!
  autocmd CursorHold * :call plug#load('syntastic')
  autocmd CursorHold * :autocmd! LazySyntatic
augroup END

"Comment stuff in and out
Plug 'tpope/vim-commentary'

"Toggle line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

"Nice mapping pairs from tpope
Plug 'tpope/vim-unimpaired'

"One of the only thins I've missed from Emacs
Plug 'vim-scripts/YankRing.vim', { 'do': 'mkdir -p $VIMDIR/tmp' }

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

"Scratch buffer
Plug 'vim-scripts/scratch.vim'

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
endif

set backupdir^=$VIMDIR/backup
set directory^=$VIMDIR/tmp
if version >= 703
  set undodir^=$VIMDIR/undo
endif

set expandtab
set shiftwidth=2
set tabstop=2

set list
set listchars=tab:→\ ,trail:·,extends:<,precedes:>,nbsp:␣

set nowrap

set wildmenu
set wildmode=longest,full

set foldmethod=syntax
set nofoldenable

"Remap annoying numbertoggle, so it doesn't interfere with yankring
let g:NumberToggleTrigger = "<F10>"

"Where the yankring history file is kept
let g:yankring_history_dir = $VIMDIR . "/tmp"

"Insert date
:inoremap <C-D> <C-R>=strftime("%F")<CR>

"Spelling defaults
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_gb,da
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell

"Fat fingers
nmap <F1> <nop>
imap <F1> <nop>

