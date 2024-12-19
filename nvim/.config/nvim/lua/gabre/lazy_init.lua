local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- validate if lua/plugins or lua/plugins.lua exists
local user_path = vim.fn.stdpath("config") .. "/lua"
local has_user_plugins = vim.uv.fs_stat(user_path .. "/plugins") ~= nil
	or vim.uv.fs_stat(user_path .. "/plugins.lua") ~= nil

require("lazy").setup({
    spec = {
		{ import = "gabre.plugins" },
		has_user_plugins and { import = "plugins" } or nil,
	},
	change_detection = { notify = false },
	concurrency = vim.uv.available_parallelism() * 2,
	defaults = { lazy = true, version = false },
	dev = { path = vim.fn.stdpath('config') .. '/dev' },
	install = { missing = true, colorscheme = {} },
	checker = { enabled = true, notify = false },
	ui = {
		size = { width = 0.8, height = 0.85 },
		border = 'rounded',
		wrap = false,
	},
	diff = { cmd = 'terminal_git' },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"vimballPlugin",
				"matchit",
				"matchparen",
				"2html_plugin",
				"tarPlugin",
				-- "netrwPlugin",
				"tutor",
				"zipPlugin",
			}
		}
	}
})
