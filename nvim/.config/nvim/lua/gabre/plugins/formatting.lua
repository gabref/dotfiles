return {
	'stevearc/conform.nvim',
	-- stylua: ignore
	keys = {
		{ '<leader>cic', '<cmd>ConformInfo<CR>',                     silent = true, desc = 'Conform Info' },
		{ '<leader>cf',  function() require('conform').format() end, silent = true, desc = 'Conform Info' },
	},
	opts = {
		formatters_by_ft = {
			-- must install npm i -D prettier-plugin-astro + prettierrc
			astro = { "prettierd", lsp_format = "fallback" },
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "prettierd", stop_after_first = true },
			typescript = { "prettierd", stop_after_first = true },
			javascriptreact = { "prettierd", stop_after_first = true },
			typescriptreact = { "prettierd", stop_after_first = true },
			markdown = { "prettierd" },
		},
	}
}
