vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_length = 0
vim.g.neovide_cursor_vfx_mode = ""

require('plugins.init')
require('core.options')
require('core.keymaps')
require('core.configs')
require('core.autocmds')
require('core.plugins').load()

