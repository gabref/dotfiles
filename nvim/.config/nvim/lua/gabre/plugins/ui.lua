return {

	-- Icon provider
	{
		'echasnovski/mini.icons',
		lazy = true,
		opts = {
			file = {
				['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
				['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
			},
			filetype = {
				dotenv = { glyph = '', hl = 'MiniIconsYellow' },
			},
		},
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			package.preload['nvim-web-devicons'] = function()
				require('mini.icons').mock_nvim_web_devicons()
				return package.loaded['nvim-web-devicons']
			end
		end,
	},

	-- UI Component Library
	{ 'MunifTanjim/nui.nvim', lazy = false },

	-- Notify (use folke/noice when cmdline can be used normally separate from messages)

	{
		"rcarriga/nvim-notify",
		lazy = false,
		event = "VimEnter",
		keys = {
			{
				'<leader>nth',
				function()
					require('telescope').extensions.notify.notify()
				end,
				mode = 'n'
			},
			{
				'<leader>nh',
				function()
					require("notify").history()
				end,
				mode = 'n'
			}
		},
		opts = {
			-- Animation style
			stages = "fade_in_slide_out",
			-- Default timeout for notifications
			timeout = 1500,
			background_colour = "#2E3440",
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	}

}
