vim.g.mapleader = " "

require("gabre.core.functions")
require("gabre.core.options")

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	}
end

-- add lazy to the `runtimepath`, this allow us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "gabre/plugins" }, {
	change_detection = {
		notify = false,
	},
})
