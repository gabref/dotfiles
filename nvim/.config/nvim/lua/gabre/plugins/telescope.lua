return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
	},
	config = function()
		local telescope = require('telescope')
		local actions = require('telescope.actions')
		local builtin = require('telescope.builtin')

		local fb_actions = require("telescope").extensions.file_browser.actions

		telescope.setup({
			defaults = {
				mappings = {
					n = {
						["q"] = actions.close
					}
				}
			},

			extensions = {
				file_browser = {
					theme = "ivy", -- dropdown
					-- disables netrw and use tleescope-file-browser in its place
					hijack_netrw = true,
					hidden = { file_browser = true, folder_browser = true },
					initial_mode = "normal",
					mappings = {
						["i"] = {
							["<c-w>"] = function()
								vim.cmd("normal vbd")
							end,
						},
						["n"] = {
							["q"] = actions.close,
							["%"] = fb_actions.create,
							["d"] = fb_actions.create,
							["R"] = fb_actions.rename,
							["m"] = fb_actions.move,
							["y"] = fb_actions.copy,
							["D"] = fb_actions.remove,
							["l"] = fb_actions.open,
							["-"] = fb_actions.goto_parent_dir,
							["e"] = fb_actions.goto_home_dir,
							["w"] = fb_actions.goto_cwd,
							["t"] = fb_actions.change_cwd,
							["f"] = fb_actions.toggle_browser,
							["h"] = fb_actions.toggle_hidden,
							["s"] = fb_actions.toggle_all,
						},
					},
				},
			}
		})

		pcall(telescope.load_extension, "file_browser")

		-- github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/after/plugin/telescope.rc.lua
		local function telescope_buffer_dir()
			return vim.fn.expand("%:p:h")
		end

		-- keymaps
		vim.keymap.set('n', '<leader>pf', function()
			builtin.find_files({
				no_ignore = false,
				hidden = true,
			})
		end, {}) -- project files
		vim.keymap.set('n', '<C-p>', builtin.git_files, {})
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set('n', '<leader>pb', function()
			builtin.buffers()
		end)
		vim.keymap.set('n', '<leader>pr', function()
			builtin.resume()
		end)
		vim.keymap.set('n', '<leader>pd', function()
			builtin.diagnostics()
		end)
		vim.keymap.set('n', '<leader>pl', function()
			builtin.live_grep()
		end)
		vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>pws', function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set('n', '<leader>pWs', function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)

		vim.keymap.set("n", "<leader>e", function()
			telescope.extensions.file_browser.file_browser({
				path = "%:p:h",
				cwd = telescope_buffer_dir(),
				respect_gitignore = false,
				hidden = true,
				grouped = true,
				previewer = true,
				initial_mode = "normal",
				layout_config = { height = 40 },
			})
		end)
		vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
		vim.keymap.set("n", "<leader>gw", builtin.grep_string)
		vim.keymap.set("n", "<space>vc", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end)
	end
}
