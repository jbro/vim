"Set $VIMDIR if unset
if empty($VIMDIR)
  if has('nvim')
    let $VIMDIR = glob('~/.config/nvim')
  else
    let $VIMDIR = glob('~/.vim')
  end
end

"Install vimplug, if not present
if empty(glob($VIMDIR . '/autoload/plug.vim'))
  silent !curl -fLo $VIMDIR/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  call mkdir($VIMDIR . '/spell', 'p')
  call mkdir($VIMDIR . '/undo', 'p')
  call mkdir($VIMDIR . '/tmp', 'p')
  call mkdir($VIMDIR . '/backup', 'p')
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($VIMDIR . '/plugged')
"Well it's only sensible
Plug 'tpope/vim-sensible'

"Colour scheme
Plug 'morhetz/gruvbox'

"Airline
Plug 'bling/vim-airline'

function! UpdatePowerlineFonts(info)
    if a:info.status != 'unchanged'
      !./install.sh
    endif
endfunction
Plug 'powerline/fonts', { 'dir': $VIMDIR . '/fonts/powerline', 'do': function('UpdatePowerlineFonts') }

function! UpdateJetBrainsMono(info)
    if a:info.status != 'unchanged'
      let os = substitute(system('uname'), '\n', '', '')
      if os == 'Linux'
        !cp ttf/*.ttf "$HOME/.local/share/fonts"
        !fc-cache -f "$HOME/.local/share/fonts"
      elseif os == 'Darwin'
        !cp ttf/*.ttf "$HOME/Library/Fonts"
      endif
    endif
endfunction
Plug 'JetBrains/JetBrainsMono', { 'dir': $VIMDIR . '/fonts/jetbrainsmono', 'do': function('UpdateJetBrainsMono') }

"Change quoting
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

"Automatic syntax checking
Plug 'dense-analysis/ale'
"Ignore long lines and bare excepts are OK
let ale_python_flake8_options = "--ignore=E501,E722"
let ale_puppet_puppetlint_options = '--no-140chars-check --no-arrow-alignment-check'
let ale_linters = { 'puppet': [ 'puppet', 'puppetlint' ] }
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)

"Only install YCM if we have cmake installed
if executable('cmake')
  function! BuildYCM(info)
    let l:install_command = [ '!python3 install.py --system-boost --all' ]

    "Build with Rust support if rustup is availiable
    "if executable('rustup')
    "  call add(l:install_command, '--rust-completer')
    "endif

    if a:info.status != 'unchanged'
      execute join(l:install_command, ' ')
    endif
  endfunction

  "Completer
  Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
  let g:ycm_key_list_select_completion = [ '<Ctrl-n>' ]
  let g:ycm_key_list_previous_completion = [ '<Ctrl-p>' ]
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1
  "Snippets
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<c-j>"
  Plug 'honza/vim-snippets'
  let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', '~/.vim/plugged/vim-snippets/UltiSnips']
endif

"Comment stuff in and out
Plug 'tpope/vim-commentary'

"Nice mapping pairs from tpope
" Plug 'tpope/vim-unimpaired'

"Git integration
Plug 'tpope/vim-fugitive'

" Display register content before selecting on
Plug 'junegunn/vim-peekaboo'

"Visual undo tree
Plug 'mbbill/undotree'

"I like to know far I have to go
Plug 'henrik/vim-indexed-search'

"Look at all the colours!
Plug 'junegunn/rainbow_parentheses.vim'

"Auto end stuff
Plug 'tpope/vim-endwise'

"Auto close parentheses
Plug 'townk/vim-autoclose'
" Fix omkompatibilyt with YCM
let g:AutoClosePumvisible = {"ENTER": "", "ESC": ""}

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
function UpdatetThesaurus(info)
  if a:info.status == 'installed'
    execute '!cd $VIMDIR && curl -o the.zip https://www.openoffice.org/lingucomponent/MyThes-1.zip && unzip -o the.zip && rm -f the.zip'
  endif
endfunction
Plug 'Ron89/thesaurus_query.vim', { 'do': function('UpdatetThesaurus') }
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
augroup VimGo
  autocmd!
  autocmd! User vim-go
        \ set nolist |
        \ let g:go_fmt_command = "goimports"
augroup END

"Ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

"Python
Plug 'python-mode/python-mode', { 'for': 'python' }

"Puppet
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
augroup VimPuppet
  autocmd!
  autocmd! User vim-puppet let g:puppet_align_hashes = 0
augroup END

"Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
augroup RustVim
  autocmd!
  autocmd! User rust.vim let g:rustfmt_autosave = 1
  autocmd! FileType rust let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "'")
augroup END

"Racket
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'racket' }
Plug 'guns/vim-sexp', { 'for': 'racket' }
augroup Racket
  autocmd filetype racket
        \ set lisp |
        \ set autoindent |
        \ :RainbowParentheses |
        \ let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "'")
augroup END

"Automatic line breaks
Plug 'reedes/vim-pencil', { 'for': 'markdown' }

"Visual indent level
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_default_mapping = 1
augroup VimIndentGuides
  autocmd!
  autocmd FileType python,json,yaml IndentGuidesEnable
augroup END


"Support some of all the other languages!
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['go', 'ruby', 'python', 'puppet', 'rust', 'racket' ]

call plug#end()

set hidden

set ignorecase
set smartcase
set hlsearch
set showcmd

set visualbell

set number
set relativenumber

"Quiet error on installation
try
  colorscheme gruvbox
catch
endtry
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
    set guifont=JetBrains\ Mono\ Medium:h16
  else
    set guifont=JetBrains\ Mono\ Medium\ 13
  endif
else
  set nocursorline
  "Fix 256 color scheme not coloring lines in terminal
  set t_ut=

  "neovim specifics
  if has('nvim')
    "Don't change cursor shape in neovim
    set guicursor=
    "Use 'correct' colors in term
    set termguicolors
endif

endif

set expandtab
set shiftwidth=2
set tabstop=2

set list
set listchars=tab:→\ ,trail:·,nbsp:␣

set nowrap

set wildmode=longest,full

set foldmethod=syntax
set nofoldenable

set backupdir^=$VIMDIR/backup
set directory^=$VIMDIR/tmp
if version >= 703
  set undodir^=$VIMDIR/undo
endif

"Persistent undo
set undofile

"Force diff to use vertical split
set diffopt+=vertical

"Insert date
:inoremap <C-D> <C-R>=strftime("%F")<CR>

"Use POSIX shell highlighting for sh scripts
let g:is_posix = 1

"Spelling defaults
set spelllang=en_gb,da
augroup SpellFileTypes
  autocmd!
  autocmd FileType markdown,gitcommit setlocal spell
augroup END

"Complete
set complete=.,w,b,u,t,i,kspell
set completeopt=menuone

"Search for files recursively using :find
set path+=**

"Fat fingers
nnoremap <F1> <nop>
inoremap <F1> <nop>

