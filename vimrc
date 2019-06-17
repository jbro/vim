"Set $VIMDIR to ~/.vim if unset
if empty($VIMDIR)
  let $VIMDIR = glob('~/.vim')
end

"Install vimplug, if not present
if empty(glob($VIMDIR . '/autoload/plug.vim'))
  silent !curl -fLo $VIMDIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  call mkdir($VIMDIR . '/spell', 'p')
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin($VIMDIR . '/plugged')
"Well it's only sensible
Plug 'tpope/vim-sensible'

"Colour scheme
Plug 'morhetz/gruvbox'

"Airline
Plug 'bling/vim-airline'
  Plug 'powerline/fonts', { 'dir': $VIMDIR . '/fonts/powerline', 'do': './install.sh' }

"Change quoting
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

"Keep window layout on bdelete
Plug 'qpkorr/vim-bufkill'

"Automatic syntax checking
Plug 'w0rp/ale'

"Comment stuff in and out
Plug 'tpope/vim-commentary'

"Nice mapping pairs from tpope
Plug 'tpope/vim-unimpaired'

" Display register content before selecting on
Plug 'junegunn/vim-peekaboo'

"I like to know far I have to go
Plug 'henrik/vim-indexed-search'

"Look at all the colours!
Plug 'junegunn/rainbow_parentheses.vim'

"Auto end stuff
Plug 'tpope/vim-endwise'

"Auto close parentheses
Plug 'townk/vim-autoclose'

"Better search experience
Plug 'junegunn/vim-slash'

"Git stuff
Plug 'airblade/vim-gitgutter'

"Scratch buffer
Plug 'vim-scripts/scratch.vim'

"Align on stuff
Plug 'godlygeek/tabular'

"More text objects
Plug 'wellle/targets.vim'

"Naming things is challenging
Plug 'Ron89/thesaurus_query.vim', { 'do': 'cd $VIMDIR && curl -o the.zip https://www.openoffice.org/lingucomponent/MyThes-1.zip && unzip the.zip && rm -f the.zip' }
let g:tq_enabled_backends = [ 'openoffice_en', 'datamuse_com']
let g:tq_openoffice_en_file = $VIMDIR . '/MyThes-1.0/th_en_US_new'
let g:tq_online_backends_timeout = 0.4

"File browser
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"REPL inside vim
Plug 'jpalardy/vim-slime'
let g:slime_target = "vimterminal"

"Golang
Plug 'fatih/vim-go', { 'for': 'go' }
autocmd! User vim-go
      \ set nolist |
      \ let g:go_fmt_command = "goimports"

"Ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

"Python
Plug 'python-mode/python-mode', { 'for': 'python' }

"Puppet
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
autocmd! User vim-puppet let g:puppet_align_hashes = 0

"Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
autocmd! User rust.vim let g:rustfmt_autosave = 1

"Automatic line breaks
Plug 'reedes/vim-pencil', { 'for': 'markdown' }

"Visual indent level
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_default_mapping = 1
autocmd FileType python,json,yaml IndentGuidesEnable


"Support some of all the other languages!
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['go', 'ruby', 'python', 'puppet', 'rust']

call plug#end()

set hidden

set ignorecase
set smartcase
set hlsearch
set showcmd

set visualbell

set number
set relativenumber


colorscheme gruvbox
set background=dark
let g:airline_theme = 'gruvbox'

"We have powerline fonts
let g:airline_powerline_fonts = 1

if has('gui_running')
  "Turn off tool bar
  set guioptions-=T
  "Turn off scrollbar
  set guioptions-=r

  set cursorline

  if has("gui_macvim")
    set guifont=Inconsolata-g\ for\ Powerline:h16
  else
    set guifont=Inconsolata-g\ for\ Powerline\ 12
  endif
else
  set nocursorline
endif

set expandtab
set shiftwidth=2
set tabstop=2

set list
set listchars=tab:→\ ,trail:·,extends:<,precedes:>,nbsp:␣
" Make listchars easier to see
hi SpecialKey ctermfg=196 guifg=#ff0000

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

"Use POSIX shell highlighting for sh scripts
let g:is_posix = 1

"Spelling defaults
set spelllang=en_gb,da
autocmd FileType markdown,gitcommit setlocal spell

"Complete
set complete=.,w,b,u,t,i,kspell

"Search for files recursively
set path+=**

"Fat fingers
nmap <F1> <nop>
imap <F1> <nop>

