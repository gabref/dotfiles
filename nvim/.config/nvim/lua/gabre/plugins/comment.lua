return {
	-- Set the commentstring based on the cursor location
	{
		'folke/ts-comments.nvim',
		event = 'VeryLazy',
		opts = {},
	},

	-- TODO: get right this stuff
	-- Powerful line and block-wise commenting
	{
		'numToStr/Comment.nvim',
		dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
		-- stylua: ignore
		keys = {
			{ '<leader>;', '<Plug>(comment_toggle_linewise_current)', mode = 'n', desc = 'Comment' },
			{ '<leader>;', 'V<Plug>(comment_toggle_blockwise_visual)',  mode = 'x', desc = 'Comment' },
		},
		opts = function(_, opts)
			local ok, tcc =
				pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
			if ok then
				opts.pre_hook = tcc.create_pre_hook()
				opts.padding = true
				opts.sticky = true
				opts.ignore = nil
			end
		end,
	},

}
