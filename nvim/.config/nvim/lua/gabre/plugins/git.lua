return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			local status, gitsigns = pcall(require, 'gitsigns')
			if (not status) then return end

			gitsigns.setup {
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map('n', '<leader>gb', gs.toggle_current_line_blame)
				end
			}
		end
	},
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		config = function()
			vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
		end
	}
}
