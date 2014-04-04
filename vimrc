set nocompatible

if $SHELL =~ 'fish'
  set shell=/bin/sh
endif

execute pathogen#infect()
call pathogen#helptags()

set hidden

set ignorecase
set smartcase
set hlsearch

set visualbell

if has('gui_running')
  colorscheme solarized
  set background=dark

  "Turn on Powerline
  set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
  set laststatus=2
  set noshowmode
  let g:powerline_config_overrides={"ext": {"vim": {"colorscheme": "solarized"}}}

  "Turn off tool bar
  set guioptions-=T
  "Turn off scrollbar
  set guioptions-=r

  set cursorline

  if has("gui_macvim")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h16
  else
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 12
  endif
else
  colorscheme desert
  set nocursorline
endif

set backupdir^=~/.vim/backup
set directory^=~/.vim/tmp
if version >= 703
  set undodir^=~/.vim/undo
endif

set expandtab
set cindent
set shiftwidth=2
set tabstop=2

set list listchars=tab:➝\ ,trail:·,extends:<,precedes:>

set nowrap

set foldmethod=syntax
set nofoldenable

command! -bar -nargs=0 W :silent exe "write !sudo tee % >/dev/null"|silent edit!

set wildmode=longest,list,full

"Ruby stuff
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby let g:rubycomplete_rails = 1
autocmd FileType ruby let g:rubycomplete_classes_in_global = 1

"Tagbar mapping
nmap <F8> :TagbarToggle<CR>

"Remap annoying numbertoggle, so it doesn't interfere with yankring
let g:NumberToggleTrigger = "<F10>"
"Where the yankring history file is kept
let g:yankring_history_dir = "~/.vim/tmp"

"Where the local vimrc cache file is kept
let g:local_vimrc = {'cache_file':$HOME.'/.vim/tmp/vim_local_rc_cache'}

"Override IndexedSearch leader keys with commentary
xmap \\  <Plug>Commentary
nmap \\  <Plug>Commentary
nmap \\\ <Plug>CommentaryLine
nmap \\u <Plug>CommentaryUndo

" Conque stuff
let g:ConqueTerm_FastMode = 0
let g:ConqueTerm_Color = 1
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_TERM = 'vt220'
let g:ConqueTerm_SendVisKey = '<Leader>e'

" Map open buffers in Command-T to \bf
" so it doesn't have to wait for \bd
nnoremap <silent> <Leader>bf :CommandTBuffer<CR>

