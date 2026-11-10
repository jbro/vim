local spellfile = require("nvim.spellfile")
local defaults = spellfile.config()
spellfile.config({ confirm = false, timeout_ms = 60000 })

for _, language in ipairs({ "en", "da" }) do
  if #vim.api.nvim_get_runtime_file("spell/" .. language .. ".utf-8.spl", false) == 0 then
    spellfile.get(language)
  end
end

spellfile.config(defaults)
vim.opt.spell = true
