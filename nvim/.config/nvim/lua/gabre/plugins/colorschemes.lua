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

All_colorschemes = {
	{
		"xiyaowong/nvim-transparent",
	},
	{
		"Mofiqul/dracula.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("dracula")
		end,
		config = function()
			require("gabre.picker")
		end,
	},
}

for _, colors in ipairs(colorschemes) do
	table.insert(All_colorschemes, colors)
end

return All_colorschemes
