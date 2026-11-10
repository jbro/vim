-- https://jeffkreeftmeijer.com/vim-number/
local numbers = vim.api.nvim_create_augroup("RelativeNumbers", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FocusGained", "InsertLeave" }, {
  group = numbers,
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= "i" then
      vim.wo.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "FocusLost", "InsertEnter" }, {
  group = numbers,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

local search_keys = { ["/"] = true, ["?"] = true, n = true, N = true, ["*"] = true, ["#"] = true }
vim.on_key(function(key)
  if vim.fn.mode() == "n" then
    vim.v.hlsearch = search_keys[vim.fn.keytrans(key)] and 1 or 0
  end
end, vim.api.nvim_create_namespace("AutoClearSearch"))
