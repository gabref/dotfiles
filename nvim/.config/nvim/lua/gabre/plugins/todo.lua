-- Highlight, list and search todo comments in your projects
return {
	'folke/todo-comments.nvim',
	event = 'VeryLazy',
	dependencies = { 'nvim-lua/plenary.nvim' },
	-- stylua: ignore
	keys = {
		{ ']t', function() require('todo-comments').jump_next() end, desc = 'Next Todo Comment' },
		{ '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous Todo Comment' },
		-- TODO: configure other stuff
		-- { '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
		-- { '<leader>xT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
		-- { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
		-- { '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
	},
	opts = { signs = false },
}