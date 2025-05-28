require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'c_sharp' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
  },
  playground = {
    enable = true,
  }
}