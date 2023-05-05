vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

-- must have
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
keymap('i', 'jk', '<esc>', opts)
keymap('n', '<leader>w', ':w<cr>', opts)
keymap('n', '<leader>q', ':q<cr>', opts)

keymap("i", "<C-c>", "<Esc>", opts)

-- navigate buffers
keymap('n', '<s-l>', ':bnext<cr>', opts)
keymap('n', '<s-h>', ':bprevious<cr>', opts)

-- move text up and down and keep indenting
keymap("v", "<a-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<a-k>", ":m '<-2<CR>gv=gv", opts)

-- keep cursor
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- greatest remap ever
-- keeps the paste buffer
-- next greatest remap ever : asbjornHaland
keymap("x", "<leader>p", [["_dP]], opts)
keymap("n", "<leader>d", [["_d]], opts)
keymap("v", "<leader>d", [["_d]], opts)
keymap("n", "<leader>y", [["+y]], opts)
keymap("v", "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]], opts)

keymap("n", "Q", "<nop>", opts)
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)

-- quick fix list
keymap("n", "<C-k>", "<cmd>cnext<CR>zz", opts)
keymap("n", "<C-j>", "<cmd>cprev<CR>zz", opts)
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

-- search and replace
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- make executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- go to packer file
keymap("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/gabre/packer.lua<CR>", opts)
-- keymap("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", opts)

-- shout outtt
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Resize with arrows
keymap("n", "<c-Up>", ":resize -2<CR>", opts)
keymap("n", "<c-Down>", ":resize +2<CR>", opts)
keymap("n", "<c-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<c-Right>", ":vertical resize +2<CR>", opts)
