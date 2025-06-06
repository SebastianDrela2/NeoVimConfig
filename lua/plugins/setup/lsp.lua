local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspConfig = require('lspconfig')

lspConfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

lspConfig.roslyn.setup({
  on_attach = function(client, bufnr)
    print("This will run when the server attaches!")
  end,
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  }
})

lspConfig.clangd.setup({
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
    init_options = {
        fallbackFlags = { '-std=c++23' },
    },
    filetypes = { "c", "cpp", "h", "hpp" }
})


