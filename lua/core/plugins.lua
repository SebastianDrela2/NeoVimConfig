local M = {}

function M.load()
  require('plugins.setup.telescope')
  require('plugins.setup.treesitter')
  require('plugins.setup.nvim-cmp')
  require('plugins.setup.lsp')
  require('plugins.setup.mason')
  require('plugins.setup.colorscheme')
  require('plugins.setup.runners')
  require('plugins.setup.debug')
end

return M
