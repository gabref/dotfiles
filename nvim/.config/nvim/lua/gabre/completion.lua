-- require "gabre.snippets"
-- inspired by https://github.com/Tibor5/Dotfiles/blob/main/.config/nvim/lua/plugins/cmp.lua

local border = {
  { "┌", "Normal" },
  { "─", "Normal" },
  { "┐", "Normal" },
  { "│", "Normal" },
  { "┘", "Normal" },
  { "─", "Normal" },
  { "└", "Normal" },
  { "│", "Normal" },
}

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")
local devicons = require("nvim-web-devicons")

cmp.setup({
	sources = {
		{
			name = "nvim_lsp",
			keyword_length = 1,
			max_item_count = 10,
			priority = 1000,
			option = { markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] } },
		},
		{ name = "nvim_lsp_signature_help", keyword_length = 2, max_item_count = 10, priority = 850 },
		{ name = "luasnip", keyword_length = 2, max_item_count = 10, priority = 850 },
		{ name = "nvim_lua", keyword_length = 2, max_item_count = 10, priority = 800 },
		{ name = "buffer", keyword_length = 2, max_item_count = 10, priority = 800 },
		{ name = "path", keyword_length = 3, max_item_count = 10, priority = 550 },
		{ name = "treesitter", keyword_length = 2, max_item_count = 10, priority = 525 },
		{ name = "vimtex", keyword_length = 2, max_item_count = 10, priority = 400 },
		{ name = "cody" },
	},
	mapping = {
		["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<c-k>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<c-j>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<c-u>"] = cmp.mapping.scroll_docs(-4),
		["<c-d>"] = cmp.mapping.scroll_docs(4),
		["<c-a>"] = cmp.mapping.abort(),
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<c-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
	},
	-- Enable luasnip to handle snippet expansion for nvim-cmp
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered({ scrollbar = false, border = border }),
		documentation = cmp.config.window.bordered({ scrollbar = true, border = border }),
	},

	-- preselect = 'item',
	-- completion = {
	-- 	completeopt = 'menu,menuone,noinsert',
	-- },

	-- formatting = {
	-- 	fields = { "abbr", "kind", "menu" },
	-- 	expandable_indicator = true,
	-- 	format = lspkind.cmp_format({
	-- 		mode = "symbol",
	-- 		-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
	-- 		-- ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
	-- 	}),
	-- },

	formatting = {
		fields = { "abbr", "kind", "menu" },
		expandable_indicator = true,
		format = function(entry, item)
			if vim.tbl_contains({ "path" }, entry.source.name) then
				local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
				if icon then
					item.kind = icon
					item.kind_hl_group = hl_group
					return item
				end
			end
			return lspkind.cmp_format({
				mode = "symbol",
				menu = {
					nvim_lsp = "[LSP]",
					nvim_lua = "[Lua]",
					luasnip = "[SNIP]",
					path = "[Path]",
					buffer = "[Buf]",
					cmdline = "[CMD]",
					vimtex = "[Tex]",
				},
			})(entry, item)
		end,
	},
})

-- Setup up vim-dadbod
cmp.setup.filetype({ "sql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})
