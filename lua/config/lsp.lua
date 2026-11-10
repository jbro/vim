local group = vim.api.nvim_create_augroup("Lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    if client:supports_method("textDocument/completion") then
      local provider = client.server_capabilities.completionProvider
      provider.triggerCharacters = vim.list.unique(vim.list_extend(
        provider.triggerCharacters or {},
        vim.split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789", "")
      ))
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    if client.name == "gopls" and client:supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = group, event = "BufWritePre", buffer = event.buf })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = event.buf,
        callback = function()
          if vim.lsp.get_client_by_id(client.id) then
            vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 1000 })
          end
        end,
      })
    end
  end,
})

if vim.fn.executable("gopls") == 1 then
  vim.lsp.enable("gopls")
else
  vim.notify("Go LSP disabled: gopls is not on PATH", vim.log.levels.WARN)
end
