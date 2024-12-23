-- inspired by https://github.com/rafi/vim-config/blob/master/lua/rafi/config/init.lua

local M = {}

local lazy_clipboard

function M.setup()
	-- autocmds can be loaded lazily when not opening a file
	local lazy_autocmds = vim.fn.argc(-1) == 0
	if not lazy_autocmds then
		M.load('autocmds')
	end

	local group = vim.api.nvim_create_augroup('GabuVim', { clear = true })
	vim.api.nvim_create_autocmd('User', {
		group = group,
		pattern = 'VeryLazy',
		callback = function()
			if lazy_autocmds then
				M.load('autocmds')
			end
			M.load('keymaps')
			M.load('terminal')
			if lazy_clipboard ~= nil then
				vim.opt.clipboard = lazy_clipboard
			end
		end
	})
end

-- load lua/gabre/* files
---@param name 'autocmds' | 'set' | 'keymaps' | 'terminal'
function M.load(name)
	require('gabre.' .. name)
	if vim.bo.filetype == 'lazy' then
		vim.cmd([[do VimResized]])
	end
	local pattern = 'GabuVim' .. name:sub(1, 1):upper() .. name:sub(2)
	vim.api.nvim_exec_autocmds('User', { pattern = pattern, modeline = false })
end

-- Check if table has a value that ends with a suffix.
---@param tbl table
---@param suffix string
---@return boolean
local function tbl_endswith(tbl, suffix)
	local l = #suffix
	for _, v in ipairs(tbl) do
		if string.sub(v, -l) == suffix then
			return true
		end
	end
	return false
end

-- This is the main entry-point once lazy.nvim is set-up.
-- Called from `lua/gabre/plugins/init.lua`
M.did_init = false
function M.init()
	if M.did_init then
		return
	end
	M.did_init = true

	-- Load set options here, before lazy init while sourcing plugin modules
	-- this is needed to make sure options will be correctly applied
	-- after installing missing plugins
	M.load('set')

	-- Defer built-in clipboard handling: "xsel" and "pbcopy" can be slow
	lazy_clipboard = vim.opt.clipboard
	vim.opt.clipboard = ''
end

return M
