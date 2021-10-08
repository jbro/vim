if exists('g:vscode')
    call plug#begin('~/.config/nvim/plugged')
        "Well it's only sensible
        Plug 'tpope/vim-sensible'

        "Operate on sandwiches
        Plug 'machakann/vim-sandwich'
    call plug#end()

    set hlsearch
    set showcmd
    set visualbell

    "Use POSIX shell highlighting for sh scripts
    let g:is_posix = 1

    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine

    highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline
    highlight OperatorSandwichChange guifg='#edc41f' gui=underline ctermfg='yellow' cterm=underline
    highlight OperatorSandwichAdd guibg='#b1fa87' gui=none ctermbg='green' cterm=none
    highlight OperatorSandwichDelete guibg='#cf5963' gui=none ctermbg='red' cterm=none
else
    :runtime vimrc
endif