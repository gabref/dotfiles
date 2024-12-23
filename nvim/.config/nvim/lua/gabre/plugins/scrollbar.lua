return {
	"petertriho/nvim-scrollbar",
	event = "VeryLazy",
	dependencies = {
		"lewis6991/gitsigns.nvim",
	},
	config = function()
		local scrollbar = require("scrollbar")
		-- TODO: get bg color from current colorscheme
		local colorscheme = require('tokyonight')
		if vim.g.colorscheme_name ~= nil then
			colorscheme = require(vim.g.colorscheme_name)
		end
		scrollbar.setup({
			show_in_active_only = true,
			handle = {
				blend = 0,
				text = " ",
				color = colorscheme.bg_highlight,
				color_nr = 234,
			},
			marks = {
				Search = { color = "#C9A554" },
				Error  = { color = "#685742" },
				Warn   = { color = "#B36D43" },
				Info   = { color = "#5f875f" },
				Hint   = { color = "#5f875f" },
				Misc   = { color = "#bb7744" },
				Cursor = { color = "#222222", text = " " },
			}
		})
	end,
}
