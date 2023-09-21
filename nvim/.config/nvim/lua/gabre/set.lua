vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

-- hey vim, try to be smart about my indent
vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true

vim.opt.smartindent = true

-- 42 tab
vim.opt.smarttab = true

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

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.cursorline = true

vim.opt.clipboard = "unnamedplus"

-- stop the automatic commenting on new line
vim.api.nvim_create_autocmd("BufEnter", { callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" } end,
})

-- 42 stuff
vim.g.user42 = 'galves-f'
vim.g.mail42 = 'marvin@42.fr'
