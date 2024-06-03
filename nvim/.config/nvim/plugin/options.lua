vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

-- hey vim, try to be smart about my indent
vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- vim.opt.expandtab = true

vim.opt.smartindent = true

-- tj said I had to turn this one on https://github.com/tjdevries/config.nvim/blob/master/plugin/options.lua
vim.opt.inccommand = "split"

-- split that makes sense
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

-- no back up file, but undotree keeps track
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- remembers stuff when exit neovim
vim.opt.shada = { "'10", "<0", "s10", "h" }

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.cursorline = true

vim.opt.clipboard = "unnamedplus"

-- stop the automatic commenting on new line
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})
-- from tjdevries, similar
-- vim.opt.formatoptions:remove "o"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25

-- 42 stuff
vim.g.user42 = "galves-f"
vim.g.mail42 = "marvin@42.fr"
vim.opt.smarttab = true
