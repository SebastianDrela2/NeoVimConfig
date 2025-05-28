local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'powerman/vim-plugin-AnsiEsc'
  use { 'Mofiqul/vscode.nvim' }
  use { 'askfiy/visual_studio_code' }
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use { 'marko-cerovac/material.nvim' }
  use { 'rebelot/kanagawa.nvim' }
  use { 'rafi/awesome-vim-colorschemes' }

  use {
    'preservim/nerdtree',
    requires = 'ryanoasis/vim-devicons'
  }
  use {
    'vim-airline/vim-airline',
    requires = 'ryanoasis/vim-devicons'
  }
  use 'ryanoasis/vim-devicons'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/playground'
    }
  }

  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig'
    }
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    }
  }

  use 'voldikss/vim-floaterm'
  use 'sbdchd/neoformat'
  use 'mg979/vim-visual-multi'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)