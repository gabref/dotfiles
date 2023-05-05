-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'nvim-telescope/telescope-file-browser.nvim',
        requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
    }

    use({ 'rose-pine/neovim', as = 'rose-pine' })
    vim.cmd('colorscheme rose-pine')

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
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }
    use('hrsh7th/cmp-buffer')       -- completion for buffers
    use('hrsh7th/cmp-path')         -- completion filesystem paths

    use('saadparwaiz1/cmp_luasnip') -- lua snippets

    use('folke/neodev.nvim')        -- lsp for lua
    use('onsails/lspkind-nvim')

    use('folke/tokyonight.nvim')

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

    -- folke/trouble.nvim
    -- folke/zen-mode.nvim
    -- theprimeagen/refactoring.nvim
    -- nvim-treesitter/nvim-treesitter-context
    -- github/copilot
    -- eandrju/cellular-automaton.nvim
    -- laytan/cloak.nvim
    -- glepnir/lspsaga.nvim -- plugin for lsp
end)
