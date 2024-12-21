-- Pretty window for navigating LSP locations
return {
	'dnlhc/glance.nvim',
	cmd = 'Glance',
	keys = {
		{ 'gpd', '<cmd>Glance definitions<CR>' },
		{ 'gpr', '<cmd>Glance references<CR>' },
		{ 'gpy', '<cmd>Glance type_definitions<CR>' },
		{ 'gpi', '<cmd>Glance implementations<CR>' },
		{ 'gpu', '<cmd>Glance resume<CR>' },
	},
	opts = function()
		local actions = require('glance').actions
		return {
			folds = {
				fold_closed = '󰅂', -- 󰅂 
				fold_open = '󰅀', -- 󰅀 
				folded = true,
			},
			border = {
				enable = true,
			},
			mappings = {
				list = {
					['<C-u>'] = actions.preview_scroll_win(5),
					['<C-d>'] = actions.preview_scroll_win(-5),
					['sg'] = actions.jump_vsplit,
					['sv'] = actions.jump_split,
					['st'] = actions.jump_tab,
					['p'] = actions.enter_win('preview'),
				},
				preview = {
					['q'] = actions.close,
					['p'] = actions.enter_win('list'),
				},
			},
		}
	end,
}
