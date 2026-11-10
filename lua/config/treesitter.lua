local treesitter = require("nvim-treesitter")
local languages = { "go", "python", "markdown", "markdown_inline", "lua" }

local missing = {}
for _, tool in ipairs({ "tree-sitter", "curl", "tar" }) do
  if vim.fn.executable(tool) == 0 then
    table.insert(missing, tool)
  end
end

local has_compiler = false
for _, compiler in ipairs({ "cc", "clang", "gcc", "cl" }) do
  has_compiler = has_compiler or vim.fn.executable(compiler) == 1
end
if not has_compiler then
  table.insert(missing, "a C compiler")
end

if #missing > 0 then
  vim.notify("Tree-sitter setup skipped: missing " .. table.concat(missing, ", "), vim.log.levels.WARN)
  return
end

-- Wait for missing parsers so highlighting works on the first launch.
treesitter.install(languages):wait(300000)
-- Refresh cached runtime directories after a first-run installation.
vim.o.runtimepath = vim.o.runtimepath

local group = vim.api.nvim_create_augroup("Treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(event)
    local language = vim.treesitter.language.get_lang(event.match)
    if language and vim.treesitter.language.add(language) then
      vim.treesitter.start(event.buf, language)
    end
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  group = group,
  callback = function(event)
    if event.data.spec.name == "nvim-treesitter" and event.data.kind == "update" then
      treesitter.update()
    end
  end,
})
