-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- 
-- local status, packer = pcall(require, 'packer')
-- if (not status) then
-- 	print('packer not found')
-- 	return
-- end

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use {
		'nvim-telescope/telescope-file-browser.nvim',
		requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
	}

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('nvim-treesitter/playground')
	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{
				-- Optional
				'williamboman/mason.nvim',
				-- run = function()
				--     pcall(vim.cmd, 'MasonUpdate')
				-- end,
			},
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required
		}
	}
	use('hrsh7th/cmp-buffer')    -- completion for buffers
	use('hrsh7th/cmp-path')      -- completion filesystem paths

	use('saadparwaiz1/cmp_luasnip') -- lua snippets

	use('folke/neodev.nvim')     -- lsp for lua
	use('onsails/lspkind-nvim')

	use('nvim-lualine/lualine.nvim')

	-- autopairs
	use('windwp/nvim-autopairs')
	use('windwp/nvim-ts-autotag')

	-- icons
	use('nvim-tree/nvim-web-devicons')

	-- colorizer
	use('norcalli/nvim-colorizer.lua')

	-- git signs
	use('lewis6991/gitsigns.nvim')

	-- barbecue bar
	use({
		'utilyre/barbecue.nvim',
		tag = '*',
		requires = {
			'SmiteshP/nvim-navic'
		}
	})

	-- highlighting other uses of the word under the cursor
	use('RRethy/vim-illuminate')

	-- comments
	use({
		'numToStr/Comment.nvim',
		requires = {
			'JoosepAlviste/nvim-ts-context-commentstring'
		}
	})

	-- 42
	use('Diogo-ss/42-header.nvim')


	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },
	})

	-- colorscheme
	use('rebelot/kanagawa.nvim')
	use('folke/tokyonight.nvim')
	use('catppuccin/nvim')
	use('ellisonleao/gruvbox.nvim')
	use('Mofiqul/dracula.nvim')
	use('craftzdog/solarized-osaka.nvim')
	use({ 'rose-pine/neovim', as = 'rose-pine' })
	use { 'hardhackerlabs/theme-vim', as = 'hardhacker' }

	-- folding
	use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

	-- Background Transparent
	use("xiyaowong/nvim-transparent")

	-- use('github/copilot.vim')

	use('mfussenegger/nvim-jdtls')


	-- folke/trouble.nvim
	-- folke/zen-mode.nvim
	-- theprimeagen/refactoring.nvim
	-- nvim-treesitter/nvim-treesitter-context
	-- eandrju/cellular-automaton.nvim
	-- laytan/cloak.nvim
	-- glepnir/lspsaga.nvim -- plugin for lsp
	if packer_bootstrap then
    	require('packer').sync()
  	end

end)
