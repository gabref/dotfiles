function ColorMyPencils(color)
	color = color or 'tokyonight' -- 'rose-pine'
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
	vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

ColorMyPencils()

-- ===================================================
-- TELESCOPE THEME PICKER
-- ===================================================

local status, _ = pcall(require, 'telescope')
if (not status) then return end

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local actions_state = require('telescope.actions.state')
local themes = require('telescope.themes')

function Enter(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	ColorMyPencils(selected[1])
	actions.close(prompt_bufnr)
end

function Next_color(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	ColorMyPencils(selected[1])
end

function Prev_color(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	ColorMyPencils(selected[1])
end

function MyColorPicker()
	local colors_table = ColorsSort(vim.fn.getcompletion("", "color"))

	local opts = {
		prompt_title = "Urmom Themes",
		finder = finders.new_table(colors_table),
		sorter = sorters.get_generic_fuzzy_sorter({}),

		attach_mappings = function(_, map)
			map("i", "<cr>", Enter)
			map("i", "<c-j>", Next_color)
			map("i", "<c-k>", Prev_color)

			map("n", "<cr>", Enter)
			map("n", "j", Next_color)
			map("n", "k", Prev_color)
			return true
		end,
	}

	local dropdown = themes.get_dropdown()
	-- local ivy = themes.get_ivy()
	-- local cursor = themes.get_cursor()

	local telescope_picker = pickers.new(dropdown, opts)

	telescope_picker:find()
end

-- ---------------------------------------------------------
-- UTILS FUNCTIONS
-- ---------------------------------------------------------

function ColorsSort(colors_table)
    -- Colorschemes to be moved to the end

    local move_to_end = {
		-- default colorschemes
        "blue", "darkblue", "delek", "desert", "elflord",
        "evening", "industry", "koehler", "morning",
        "murphy", "pablo", "peachpuff", "ron",
        "shine", "slate", "torte", "zellner", "lunaperche",
		"default", "quiet", "habamax",
		-- white colorschemes
		"catppuccin-latte", "kanagawa-lotus", "rose-pine",
		"rose-pine-dawn", "solarized-osaka-day", "tokyonight-day"
    }

    -- Create a table to store the reordered colorschemes
    local reordered_table = {}

    -- Add colorschemes not in move_to_end to the reordered_table
    for _, color in ipairs(colors_table) do
        if not vim.tbl_contains(move_to_end, color) then
            table.insert(reordered_table, color)
        end
    end

    -- Add colorschemes in move_to_end to the end of the reordered_table
    for _, color in ipairs(move_to_end) do

        table.insert(reordered_table, color)
    end

    return reordered_table
end

function Test()
	-- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
	-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

	local colors_table = vim.fn.getcompletion("", "color")
	print(vim.inspect(colors_table))
	print('\n\n')

	local reordered = ColorsSort(colors_table)
	print(vim.inspect(reordered))
end

vim.api.nvim_create_user_command('GabuPicker', MyColorPicker, {})

local default_opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>t", ":GabuPicker<cr>", default_opts)