-- Code outline sidebar powered by LSP
return {
	'hedyhli/outline.nvim',
	cmd = { 'Outline', 'OutlineOpen' },
	keys = {
		{ '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
	},
	opts = function()
		local defaults = require('outline.config').defaults
		local opts = {
			symbols = {
				icons = {},
			},
			keymaps = {
				up_and_jump = '<up>',
				down_and_jump = '<down>',
			},
		}

		for kind, symbol in pairs(defaults.symbols.icons) do
			opts.symbols.icons[kind] = {
				icon = symbol.icon,
				hl = symbol.hl,
			}
		end
		return opts
	end,
}
