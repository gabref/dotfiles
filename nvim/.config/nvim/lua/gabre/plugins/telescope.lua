return {
	{ 
		"nvim-telescope/telescope.nvim", 
		tag = "0.1.4",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- { "nvim-telescope/telescope-smart-history.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "kkharji/sqlite.lua" },
		},
		config = function()
			require("gabre.telescope")
		end
	},
}