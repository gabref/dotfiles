-- makes color codes colorful #5f8e8e
return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		local c = require("colorizer")

		vim.opt.termguicolors = true

		c.setup({
			'*',
			html = {
				mode = 'foreground',
			}
		})
	end
}
