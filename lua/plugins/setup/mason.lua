require('mason').setup()
require('mason-lspconfig').setup({
  automatic_enable = true,
  ensure_installed = { 'clangd', 'lua_ls', 'rust_analyzer' }
})

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})
