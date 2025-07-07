local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspConfig = require('lspconfig')

local ran_once = false

local function on_attach(client, bufnr)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        vim.cmd('highlight LspInlayHint guifg=#808080 gui=italic ctermfg=gray cterm=italic');
        vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = vim.api.nvim_get_current_buf() })
        end, { desc = '[T]oggle Inlay [H]ints' })

        vim.lsp.handlers["experimental/serverStatus"] = function(_, result, ctx, _)
            if result.quiescent and not ran_once then
                vim.lsp.inlay_hint.enable(false, nil)
                vim.lsp.inlay_hint.enable(true, nil)
                ran_once = true
            end
        end
    end
end

lspConfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = { group = "module" },
                prefix = "self",
            },
            cargo = {
                buildScripts = { enable = true },
            },
            procMacro = { enable = true },
        }
    },
})

lspConfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

lspConfig.roslyn.setup({
    on_attach = on_attach,
    capabilities = capabilities,
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
    on_attach = on_attach,
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

