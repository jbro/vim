vim.opt.termguicolors = true
vim.g.is_posix = 1
vim.opt.undofile = true
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup//"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.guicursor = ""
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 2

vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣", extends = ">", precedes = "<" }

vim.opt.wrap = false
vim.opt.mouse = ""
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.wildmode = "longest,full"
vim.opt.diffopt:append("vertical")
vim.opt.belloff = "all"

vim.opt.spell = true
vim.opt.spelllang = { "en_gb", "da" }
vim.opt.spelloptions:append("noplainbuffer")
local spelldir = vim.fn.stdpath("data") .. "/site/spell"
vim.fn.mkdir(spelldir, "p")
vim.opt.spellfile = spelldir .. "/custom.utf-8.add"
