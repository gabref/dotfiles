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
	"folke/tokyonight.nvim",
	"ellisonleao/gruvbox.nvim",
	"rktjmp/lush.nvim",
	"tckmn/hotdog.vim",
	"dundargoc/fakedonalds.nvim",
	"craftzdog/solarized-osaka.nvim",
	"eldritch-theme/eldritch.nvim",
	"jesseleite/nvim-noirbuddy",
	"vim-scripts/MountainDew.vim",
	"miikanissi/modus-themes.nvim",
	"rebelot/kanagawa.nvim",
	"gremble0/yellowbeans.nvim",
	"rockyzhang24/arctic.nvim",
	"Shatur/neovim-ayu",
	-- "RRethy/base16-nvim",
	"xero/miasma.nvim",
	"cocopon/iceberg.vim",
	"kepano/flexoki-neovim",
	"ntk148v/komau.vim",
	"uloco/bluloco.nvim",
	"LuRsT/austere.vim",
	"ricardoraposo/gruvbox-minor.nvim",
	"NTBBloodbath/sweetie.nvim",
	{ 'hardhackerlabs/theme-vim', as = 'hardhacker' },
	{ "rose-pine/neovim",         name = "rose-pine" },
	{ "catppuccin/nvim",          name = "catppuccin" },
}
