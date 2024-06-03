return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("gabre.completion")
		end,
	},
}
