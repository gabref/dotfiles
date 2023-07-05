local statust, telescope = pcall(require, 'telescope')
if (not statust) then return end
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

-- github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/after/plugin/telescope.rc.lua
local function telescope_buffer_dir()
    return vim.fn.expand('%:p:h')
end

local fb_actions = require 'telescope'.extensions.file_browser.actions

telescope.setup {
    defaults = {
        mappings = {
            n = {
                ['q'] = actions.close
            },
            i = {
                ['<c-k>'] = actions.move_selection_previous,
                ['<c-j>'] = actions.move_selection_next
            }
        }
    },
    extensions = {
        file_browser = {
            theme = 'ivy', -- dropdown
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            hidden = { file_browser = true, folder_browser = true },
            initial_mode = "normal",
            mappings = {
                ['i'] = {
                    ['<c-w>'] = function() vim.cmd('normal vbd') end,
                },
                ['n'] = {
                    ['q'] = actions.close,
                    ['%'] = fb_actions.create,
                    ['d'] = fb_actions.create,
                    ['R'] = fb_actions.rename,
                    ['m'] = fb_actions.move,
                    ['y'] = fb_actions.copy,
                    ['D'] = fb_actions.remove,
                    ['l'] = fb_actions.open,
                    ['-'] = fb_actions.goto_parent_dir,
                    ['e'] = fb_actions.goto_home_dir,
                    ['w'] = fb_actions.goto_cwd,
                    ['t'] = fb_actions.change_cwd,
                    ['f'] = fb_actions.toggle_browser,
                    ['h'] = fb_actions.toggle_hidden,
                    ['s'] = fb_actions.toggle_all,
                }
            }
        }
    }
}

telescope.load_extension 'file_browser'

-- keymaps

vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
        no_ignore = false,
        hidden = true
    })
end) -- project files
vim.keymap.set('n', '<c-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function ()
	builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)
vim.keymap.set('n', '<leader>pb', function()
    builtin.buffers()
end)
vim.keymap.set('n',  '<leader>pr', function()
    builtin.resume()
end)
vim.keymap.set('n', '<leader>pd', function()
    builtin.diagnostics()
end)
vim.keymap.set('n', '<leader>pl', function()
    builtin.live_grep()
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>e', function()
      telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = true,
          initial_mode = "normal",
          layout_config = { height = 40 }
    })
end)
