return {
	{
		"xiyaowong/nvim-transparent",
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("dracula")
			require("gabre.picker")
			-- if ColorMyPencils ~= nil then
			-- 	print("ColorMyPencils")
			-- 	ColorMyPencils()
			-- end
		end,
		-- config = function()
		-- require("gabre.picker")
		-- if ColorMyPencils ~= nil then
		-- 	ColorMyPencils()
		-- end
		-- end
	},
	{ "folke/tokyonight.nvim", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "rktjmp/lush.nvim", lazy = true },
	{ "tckmn/hotdog.vim", lazy = true },
	{ "dundargoc/fakedonalds.nvim", lazy = true },
	{ "craftzdog/solarized-osaka.nvim", lazy = true },
	{ "eldritch-theme/eldritch.nvim", lazy = true },
	{ "jesseleite/nvim-noirbuddy", lazy = true },
	{ "vim-scripts/MountainDew.vim", lazy = true },
	{ "miikanissi/modus-themes.nvim", lazy = true },
	{ "rebelot/kanagawa.nvim", lazy = true },
	{ "gremble0/yellowbeans.nvim", lazy = true },
	{ "rockyzhang24/arctic.nvim", lazy = true },
	{ "Shatur/neovim-ayu", lazy = true },
	-- "RRethy/base16-nvim",
	{ "xero/miasma.nvim", lazy = true },
	{ "cocopon/iceberg.vim", lazy = true },
	{ "kepano/flexoki-neovim", lazy = true },
	{ "ntk148v/komau.vim", lazy = true },
	{ "uloco/bluloco.nvim", lazy = true },
	{ "LuRsT/austere.vim", lazy = true },
	{ "ricardoraposo/gruvbox-minor.nvim", lazy = true },
	"NTBBloodbath/sweetie.nvim",
	{ "hardhackerlabs/theme-vim", as = "hardhacker", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
}
