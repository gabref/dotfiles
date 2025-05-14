return {
	{
		'davidmh/mdx.nvim',
		config = true,
		event = 'BufEnter *.mdx',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		'iamcco/markdown-preview.nvim',
		build = 'cd app && npm install',
		init = function()
			vim.g.mkdp_filetypes = { 'markdown' }
			vim.g.mkdp_port = '3002'
		end,
		ft = { 'markdown' },
	},
}
