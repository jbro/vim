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
Plug 'altercation/vim-colors-solarized'

"TUI colour scheme
Plug 'morhetz/gruvbox'

"Airline
Plug 'bling/vim-airline'
  Plug 'powerline/fonts', { 'dir': $VIMDIR . '/fonts/powerline', 'do': './install.sh' }
  Plug 'vim-airline/vim-airline-themes'

"Change quoting
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Keep window layout on bdelete
Plug 'qpkorr/vim-bufkill'

"Automatic syntax checking
Plug 'w0rp/ale'

"Tab completion
Plug 'maralla/completor.vim'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"Comment stuff in and out
Plug 'tpope/vim-commentary'

"Toggle line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

"Nice mapping pairs from tpope
Plug 'tpope/vim-unimpaired'

"Browsing the files
Plug 'tpope/vim-vinegar'
function! BDeleteNetrw()
  for i in range(bufnr('$'), 1, -1)
    if buflisted(i)
      if getbufvar(i, 'netrw_browser_active') == 1 || bufname(i) == ''
        silent exe 'bdelete ' . i
      endif
    endif
  endfor
endfunction
autocmd FileType netrw setl bufhidden=delete
autocmd BufEnter * call BDeleteNetrw()

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

"Auto end stuff
Plug 'tpope/vim-endwise'

"Autoclose parantheses
Plug 'townk/vim-autoclose'

"Better search experience
Plug 'junegunn/vim-slash'

"Sneak up on stuff
Plug 'justinmk/vim-sneak'

"Git stuff
Plug 'airblade/vim-gitgutter'

"Scratch buffer
Plug 'vim-scripts/scratch.vim'

"Align on stuff
Plug 'godlygeek/tabular', { 'for': 'puppet' }

"Automatic line breaks
Plug 'reedes/vim-pencil', { 'for': 'markdown' }

"REPL inside vim
Plug 'jpalardy/vim-slime'
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/vimshell.vim'
let g:slime_target = "vimterminal"

"Golang
Plug 'fatih/vim-go', { 'for': 'go' }
autocmd! User vim-go
      \ set nolist |
      \ let g:go_fmt_command = "goimports"

"Ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

"Python
Plug 'python-mode/python-mode', { 'branch': 'develop' }

"Puppet
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
let g:puppet_align_hashes = 0

"Support some of all the other languages!
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['go', 'ruby', 'python', 'puppet']

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
    set guifont=Roboto\ Mono\ for\ Powerline\ 12
  endif
else
  colorscheme gruvbox
  set background=dark
  let g:airline_theme = 'gruvbox'
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

"Unshift enter command
nmap ; :
noremap ;; ;

