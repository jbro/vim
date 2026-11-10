vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/nvim-mini/mini.statusline", version = "stable" },
  { src = "https://github.com/nvim-mini/mini.surround", version = "stable" },
  { src = "https://github.com/nvim-mini/mini.ai", version = "stable" },
  { src = "https://github.com/nvim-mini/mini.pairs", version = "stable" },
  { src = "https://github.com/nvim-mini/mini.diff", version = "stable" },
  { src = "https://github.com/nvim-mini/mini-git", version = "stable" },
  { src = "https://github.com/nvim-mini/mini.align", version = "stable" },
  { src = "https://github.com/nvim-mini/mini.clue", version = "stable" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

require("config.treesitter")
require("config.lsp")

require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.pairs").setup()
require("mini.diff").setup({
  view = { style = "sign" },
})
require("mini.git").setup()
require("mini.align").setup()
require("ibl").setup()

local clue = require("mini.clue")
clue.setup({
  triggers = {
    { mode = { "n", "x" }, keys = '"' },
    { mode = { "i", "c" }, keys = "<C-r>" },
  },
  clues = {
    clue.gen_clues.registers({ show_contents = true }),
  },
})

vim.cmd.colorscheme("catppuccin-mocha")
