local status, barbecue = pcall(require, 'barbecue')
if (not status) then return end

-- triggers CursorHold event faster
vim.opt.updatetime = 200

barbecue.setup({
    create_autocmd = false -- prevent barbecue from updating itself automatically
})

vim.api.nvim_create_autocmd({
    'WinResized ',   -- or WinResized on NVIM-v0.9 and higher
    'BufWinEnter',
    'CursorHold',
    'InsertLeave',
}, {
    group = vim.api.nvim_create_augroup('barbecue.updater', {}),
    callback = function()
        require('barbecue.ui').update()
    end,
})

vim.keymap.set('n', '<leader>b', function() require('barbecue.ui').toggle() end)
