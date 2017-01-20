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
Plug 'powerline/fonts', { 'dir': $VIMDIR . '/fonts/powerline', 'do': './install.sh' } |
  Plug 'vim-airline/vim-airline-themes' |
  Plug 'bling/vim-airline'

"Change quoting
Plug 'tpope/vim-surround'

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
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    silent !which cmake
    if v:shell_error == 0
      !./install.py --clang-completer
    else
      !./install.py
    end
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

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

"Git stuff
Plug 'tpope/vim-fugitive'

"Scratch buffer
Plug 'vim-scripts/scratch.vim'

"Ruby stuff
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }

"Fish syntax highlighting
Plug 'dag/vim-fish', { 'for': 'fish' }

"Puppet
Plug 'godlygeek/tabular' |
  Plug 'rodjek/vim-puppet', { 'for': 'puppet' }

"Nim
Plug 'zah/nim.vim', { 'for': 'nim' }

call plug#end()

set hidden

set ignorecase
set smartcase
set hlsearch

set visualbell

set number

"Remap annoying numbertoggle, so it doesn't interfere with yankring
let g:NumberToggleTrigger = "<F10>"

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
    set guifont=Source\ Code\ Pro\ for\ Powerline:h16
  else
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
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

set wildmenu
set wildmode=longest,full

set foldmethod=syntax
set nofoldenable

set backupdir^=$VIMDIR/backup
set directory^=$VIMDIR/tmp
if version >= 703
  set undodir^=$VIMDIR/undo
endif
"Where the yankring history file is kept
let g:yankring_history_dir = $VIMDIR . "/tmp"

"Insert date
:inoremap <C-D> <C-R>=strftime("%F")<CR>

"Spelling defaults
set spelllang=en_gb,da
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell

"Fat fingers
nmap <F1> <nop>
imap <F1> <nop>

"Testing auto leave insert mode, to discourage moving in insert mode
au CursorHoldI * stopinsert

