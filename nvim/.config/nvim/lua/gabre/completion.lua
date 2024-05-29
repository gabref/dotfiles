-- require "gabre.snippets"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "cody" },
		{ name = "path" },
		{ name = "buffer" },
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
	-- preselect = 'item',
	-- completion = {
	-- 	completeopt = 'menu,menuone,noinsert',
	-- },
	formatting = {
		fields = { 'abbr', 'kind', 'menu' },
		expandable_indicator = true,
		format = lspkind.cmp_format({
			mode = 'symbol',
			-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
			-- ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
		})
	}
})

-- Setup up vim-dadbod
cmp.setup.filetype({ "sql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})
