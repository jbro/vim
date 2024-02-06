"Set $VIMDIR if unset
if empty($VIMDIR)
  let $VIMDIR = glob('~/.config/nvim')
end

"Install vimplug, if not present
if empty(glob($VIMDIR . '/autoload/plug.vim'))
  silent !curl -fLo $VIMDIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  call mkdir($VIMDIR . '/undo', 'p')
  call mkdir($VIMDIR . '/tmp', 'p')
  call mkdir($VIMDIR . '/backup', 'p')
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($VIMDIR . '/plugged')
"Well it's only sensible
Plug 'tpope/vim-sensible'

"Operate on sandwiches
Plug 'machakann/vim-sandwich'
highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline
highlight OperatorSandwichChange guifg='#edc41f' gui=underline ctermfg='yellow' cterm=underline
highlight OperatorSandwichAdd guibg='#b1fa87' gui=none ctermbg='green' cterm=none
highlight OperatorSandwichDelete guibg='#cf5963' gui=none ctermbg='red' cterm=none

"I like to know far I have to go
Plug 'henrik/vim-indexed-search'

"Better search experience
Plug 'junegunn/vim-slash'

"More text objects
Plug 'wellle/targets.vim'

call plug#end()

" Commentry like behaviour
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

set ignorecase
set smartcase
set hlsearch
set showcmd

set visualbell

set wildmode=longest,full

set backupdir^=$VIMDIR/backup
set directory^=$VIMDIR/tmp
if version >= 703
  set undodir^=$VIMDIR/undo
endif

"Persistent undo
set undofile
