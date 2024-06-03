return {
	"Diogo-ss/42-header.nvim",
	config = function()
		local header42 = require("42header")

		header42.setup({
			length = 80,            -- headers of different sizes are incompatible with each other
			margin = 5,
			default_map = true,     -- default Mapping <F1> in normal mode
			auto_update = true,     -- update header when saving
			user = "galves-f",      -- your user
			mail = "galves-f@student.42.fr", -- your mail
		})
	end,
}
