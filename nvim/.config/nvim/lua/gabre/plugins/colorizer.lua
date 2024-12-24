-- makes color codes colorful #5f8e8e
return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		vim.opt.termguicolors = true
		require('colorizer').setup({
			filetypes = {
				"*",
				html = { mode = "foreground" },
			},
			user_default_options = {
				tailwind = true,
			}
		})
	end
}
