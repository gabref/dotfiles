local all_colors = {
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

for _, colors in ipairs(Options.colorshemes) do
	table.insert(all_colors, colors)
end

return all_colors
