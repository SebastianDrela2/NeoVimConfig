-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
   { "powerman/vim-plugin-AnsiEsc" },
  { "Mofiqul/vscode.nvim" },
  { "askfiy/visual_studio_code" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "marko-cerovac/material.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "rafi/awesome-vim-colorschemes" },
  {
    "preservim/nerdtree",
    dependencies = { "ryanoasis/vim-devicons" }
  },
  {
    "vim-airline/vim-airline",
    dependencies = { "ryanoasis/vim-devicons" }
  },
  { "ryanoasis/vim-devicons" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground" }
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig"
    }
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    }
  },
  { "voldikss/vim-floaterm" },
  { "sbdchd/neoformat" },
  { "mg979/vim-visual-multi" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    }
  },
  {
    "folke/persistence.nvim",
    config = function()
      require("persistence").setup()
    end
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    config = function()
      require("roslyn").setup({})
    end
  }
  },
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})