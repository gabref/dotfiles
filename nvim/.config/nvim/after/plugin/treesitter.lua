local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then return end

ts.setup {
	ensure_installed = { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "rust", "tsx", "json", "css", "java" },
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	ignore_install = {},
	modules = {},
	highlight = {
		enable = true,
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(_, buf) -- lang , buf
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,

	},

	autotag = {
		enable = true,
	},
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
