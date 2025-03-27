-- Enable language servers
vim.lsp.enable("lua-language-server")

-- Enable autocompletion
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Diagnostic in virtual lines
vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = true,
})
