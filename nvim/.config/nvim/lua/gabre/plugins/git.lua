return {
	{
		'lewis6991/gitsigns.nvim',
		event = 'VeryLazy',
		opts = {
			signcolumn          = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl               = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl              = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff           = false, -- Toggle with `:Gitsigns toggle_word_diff`
			current_line_blame  = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			attach_to_untracked = true,
			watch_gitdir        = {
				interval = 1000,
				follow_files = true,
			},
			preview_config      = {
				border = 'rounded',
			},
			signs               = {
				add = { text = '▎' },
				change = { text = '▎' },
				delete = { text = '' },
				topdelete = { text = '' },
				changedelete = { text = '▎' },
				untracked = { text = '▎' },
			},
			signs_staged        = {
				add = { text = '▎' },
				change = { text = '▎' },
				delete = { text = '' },
				topdelete = { text = '' },
				changedelete = { text = '▎' },
			},
			on_attach           = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				---@return string
				map('n', ']g', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.nav_hunk('next') end)
					return '<Ignore>'
				end, { expr = true, desc = 'Next git hunk' })

				map('n', '[g', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.nav_hunk('prev') end)
					return '<Ignore>'
				end, { expr = true, desc = 'Previous git hunk' })

				-- Actions
				--
				map('n', ']h', function()
					if vim.wo.diff then
						vim.cmd.normal({ ']c', bang = true })
					else
						gs.nav_hunk('next')
					end
				end, { desc = 'Next Hunk' })

				map('n', '[h', function()
					if vim.wo.diff then
						vim.cmd.normal({ '[c', bang = true })
					else
						gs.nav_hunk('prev')
					end
				end, { desc = 'Prev Hunk' })
				map('n', ']H', function() gs.nav_hunk('last') end, { desc = 'Last Hunk' })
				map('n', '[H', function() gs.nav_hunk('first') end, { desc = 'First Hunk' })
				map('n', '<leader>hs', gs.stage_hunk, { silent = true, desc = 'Stage hunk' })
				map('n', '<leader>hr', gs.reset_hunk, { silent = true, desc = 'Reset hunk' })
				map('x', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
					{ desc = 'Stage hunk' })
				map('x', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
					{ desc = 'Reset hunk' })
				map('n', '<leader>hS', gs.stage_buffer, { silent = true, desc = 'Stage buffer' })
				map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo staged hunk' })
				map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
				map('n', 'gs', gs.preview_hunk, { desc = 'Preview hunk' })
				map('n', '<leader>hp', gs.preview_hunk_inline, { desc = 'Preview hunk inline' })
				map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = 'Show blame commit' })
				map('n', '<leader>hd', gs.diffthis, { desc = 'Diff against the index' })
				map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff against the last commit' })
				map('n', '<leader>hl', function()
					if vim.bo.filetype ~= 'qf' then
						require('gitsigns').setqflist(0, { use_location_list = true })
					end
				end, { desc = 'Send to location list' })

				-- Toggles
				map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Toggle Git line blame' })
				map('n', '<leader>htB', function() gs.blame() end, { desc = 'Blame Buffer' })
				map('n', '<leader>htd', gs.toggle_deleted, { desc = 'Toggle Git deleted' })
				map('n', '<leader>htw', gs.toggle_word_diff, { desc = 'Toggle Git word diff' })
				map('n', '<leader>htl', gs.toggle_linehl, { desc = 'Toggle Git line highlight' })
				map('n', '<leader>htn', gs.toggle_numhl, { desc = 'Toggle Git number highlight' })
				map('n', '<leader>hts', gs.toggle_signs, { desc = 'Toggle Git signs' })

				-- Text object
				map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { silent = true, desc = 'Select hunk' })
			end,
		},
	},

	-- Tabpage interface for cycling through diffs
	{
		'sindrets/diffview.nvim',
		cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
		keys = {
			-- { '<Leader>gd', '<cmd>DiffviewFileHistory %<CR>', desc = 'Diff File' },
			{ '<Leader>gv', '<cmd>DiffviewOpen<CR>', desc = 'Diff View' },
		},
		opts = function()
			local actions = require('diffview.actions')
			vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
				group = vim.api.nvim_create_augroup('rafi_diffview', {}),
				pattern = 'diffview:///panels/*',
				callback = function()
					vim.opt_local.cursorline = true
					vim.opt_local.winhighlight = 'CursorLine:WildMenu'
				end,
			})

			return {
				enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
				keymaps = {
					view = {
						{ 'n', 'q',              actions.close },
						{ 'n', '<Tab>',          actions.select_next_entry },
						{ 'n', '<S-Tab>',        actions.select_prev_entry },
						{ 'n', '<LocalLeader>a', actions.focus_files },
						{ 'n', '<LocalLeader>e', actions.toggle_files },
					},

					file_panel = {
						{ 'n', 'q',              actions.close },
						{ 'n', 'h',              actions.prev_entry },
						{ 'n', 'o',              actions.focus_entry },
						{ 'n', 'gf',             actions.goto_file },
						{ 'n', 'sg',             actions.goto_file_split },
						{ 'n', 'st',             actions.goto_file_tab },
						{ 'n', '<C-r>',          actions.refresh_files },
						{ 'n', '<LocalLeader>e', actions.toggle_files },
					},
					file_history_panel = {
						{ 'n', 'q', '<cmd>DiffviewClose<CR>' },
						{ 'n', 'o', actions.focus_entry },
						{ 'n', 'O', actions.options },
					},
				},
			}
		end,
	},

	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},

	-- Magit clone for Neovim
	-- {
	-- 	'NeogitOrg/neogit',
	-- 	dependencies = {
	-- 		'sindrets/diffview.nvim',
	-- 		'nvim-telescope/telescope.nvim',
	-- 	},
	-- 	cmd = 'Neogit',
	-- 	keys = {
	-- 		{ '<Leader>mg', '<cmd>Neogit<CR>', desc = 'Neogit' },
	-- 	},
	--
	-- 	-- See: https://github.com/TimUntersberger/neogit#configuration
	-- 	opts = {
	-- 		disable_signs = false,
	-- 		disable_context_highlighting = false,
	-- 		disable_commit_confirmation = false,
	-- 		signs = {
	-- 			section = { '>', 'v' },
	-- 			item = { '>', 'v' },
	-- 			hunk = { '', '' },
	-- 		},
	-- 		integrations = {
	--
	-- 			diffview = true,
	-- 		},
	--
	-- 	},
	--
	-- },

	-----------------------------------------------------------------------------
	-- Git blame visualizer
	{
		'FabijanZulj/blame.nvim',
		cmd = 'ToggleBlame',

		-- stylua: ignore
		keys = {
			{ '<leader>gb', '<cmd>BlameToggle virtual<CR>', desc = 'Git blame' },
			{ '<leader>gB', '<cmd>BlameToggle window<CR>',  desc = 'Git blame (window)' },
		},

		opts = {
			date_format = '%Y-%m-%d %H:%M',
			merge_consecutive = false,
			max_summary_width = 30,
			mappings = {
				commit_info = 'K',
				stack_push = '>',
				stack_pop = '<',
				show_commit = '<CR>',
				close = { '<Esc>', 'q' },
			},
		},
	},

	-----------------------------------------------------------------------------

	-- Pleasant editing on Git commit messages
	{
		'rhysd/committia.vim',
		event = 'BufReadPre COMMIT_EDITMSG',
		init = function()
			-- See: https://github.com/rhysd/committia.vim#variables
			vim.g.committia_min_window_width = 30
			vim.g.committia_edit_window_width = 75
		end,
		config = function()
			vim.g.committia_hooks = {
				edit_open = function()
					vim.cmd.resize(10)
					local opts = {
						buffer = vim.api.nvim_get_current_buf(),
						silent = true,
					}
					local function map(mode, lhs, rhs)
						vim.keymap.set(mode, lhs, rhs, opts)
					end
					map('n', 'q', '<cmd>quit<CR>')
					map('i', '<C-d>', '<Plug>(committia-scroll-diff-down-half)')
					map('i', '<C-u>', '<Plug>(committia-scroll-diff-up-half)')
					map('i', '<C-f>', '<Plug>(committia-scroll-diff-down-page)')
					map('i', '<C-b>', '<Plug>(committia-scroll-diff-up-page)')
					map('i', '<C-j>', '<Plug>(committia-scroll-diff-down)')
					map('i', '<C-k>', '<Plug>(committia-scroll-diff-up)')
				end,
			}
		end,
	},
}
