local colorschemes = {
	{ "folke/tokyonight.nvim",            lazy = true, name = "tokyonight" },
	{ "ellisonleao/gruvbox.nvim",         lazy = true, name = "gruvbox" },
	{ "rktjmp/lush.nvim",                 lazy = true, name = "lush" },
	{ "tckmn/hotdog.vim",                 lazy = true, name = "hotdog" },
	{ "dundargoc/fakedonalds.nvim",       lazy = true, name = "fakedonalds" },
	{ "craftzdog/solarized-osaka.nvim",   lazy = true, name = "solarized-osaka" },
	{ "eldritch-theme/eldritch.nvim",     lazy = true, name = "eldritch" },
	{ "jesseleite/nvim-noirbuddy",        lazy = true, name = "noirbuddy" },
	{ "vim-scripts/MountainDew.vim",      lazy = true, name = "mountaindew" },
	{ "miikanissi/modus-themes.nvim",     lazy = true, name = "modus" },
	{ "rebelot/kanagawa.nvim",            lazy = true, name = "kanagawa" },
	{ "gremble0/yellowbeans.nvim",        lazy = true, name = "yellowbeans" },
	{ "rockyzhang24/arctic.nvim",         lazy = true, name = "arctic" },
	{ "Shatur/neovim-ayu",                lazy = true, name = "ayu" },
	{ "xero/miasma.nvim",                 lazy = true, name = "miasma" },
	{ "cocopon/iceberg.vim",              lazy = true, name = "iceberg" },
	{ "kepano/flexoki-neovim",            lazy = true, name = "flexoki" },
	{ "ntk148v/komau.vim",                lazy = true, name = "komau" },
	{ "uloco/bluloco.nvim",               lazy = true, name = "bluloco" },
	{ "LuRsT/austere.vim",                lazy = true, name = "ausetere" },
	{ "ricardoraposo/gruvbox-minor.nvim", lazy = true, name = "minor" },
	{ "NTBBloodbath/sweetie.nvim",        lazy = true, name = "sweetie" },
	{ "rose-pine/neovim",                 lazy = true, name = "rose-pine" },
	{ "catppuccin/nvim",                  lazy = true, name = "catppuccin" },
	{ "hardhackerlabs/theme-vim",         lazy = true, name = "hardhacker",     as = "hardhacker" },
}

return {
	{
		"cformat42",
		dir = "~/personal/projects/cformat42.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>4", ":CFormat42<CR>", desc = "Format C files following 42 School Norm" }
		}
	},
	{
		"themelume",
		dir = "~/personal/projects/themelume.nvim",
		lazy = false,
		dependencies = {
			"xiyaowong/nvim-transparent",
		},
		config = function()
			require('themelume').setup({
				colorschemes = colorschemes,
				default_colorscheme = "rose-pine",
				transparency_enabled = false,
				push_to_bottom = { "MountainDew" },
				keymap = "<leader>t",
				theme = 'dropdown',
			})
		end
	},
	colorschemes
}
