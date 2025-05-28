local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').omnisharp.setup({
  capabilities = capabilities,
  cmd = { "OmniSharp" },
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  filetypes = { 'cs' },
  on_attach = function(client, bufnr)
    vim.keymap.set('n', '<C-.>', function()
      vim.lsp.buf.code_action()
    end, { buffer = bufnr, desc = "Code actions" })

    vim.api.nvim_create_autocmd('DiagnosticChanged', {
      callback = function()
        vim.diagnostic.setqflist({ open = false })
      end,
      buffer = bufnr,
    })
  end
})

require('lspconfig').clangd.setup({
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--offset-encoding=utf-16"
  },
  filetypes = { "c", "cpp", "h", "hpp" }
})