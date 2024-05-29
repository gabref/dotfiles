return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- branch = "main",
		tag = "v0.9.2",
		lazy = false,
		config = function()
			require('gabre.treesitter').setup()
		end
	},
}
