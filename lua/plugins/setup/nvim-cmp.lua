local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = {
            border = 'rounded',
            max_height = 10,
            scrollbar = true,
            scrolloff = 3,
        },
        documentation = {
            max_height = 15,
            scrollbar = true,
        }
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<PageUp>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<PageDown>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            else
                fallback()
            end
        end, {'i','s'}),
    }),
    sources = cmp.config.sources({
        { 
            name = 'nvim_lsp',
            max_item_count = 2000,
        },
        { 
            name = 'luasnip',
            max_item_count = 1000,
        },
    }, {
        { 
            name = 'buffer',
            max_item_count = 1000,
        },
        { 
            name = 'path',
            max_item_count = 1000,
        },
    }),
    view = {
        entries = {
            name = 'custom',
            selection_order = 'near_cursor',
            follow_cursor = true,
        }
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    }
})
