local status, neodev = pcall(require, 'neodev')
if (not status) then return end

-- lua and plugin docs, help and completion
neodev.setup()

-- mason
local statusm, mason = pcall(require, 'mason')
if (not statusm) then return end

mason.setup({
	ui = {
		border = 'rounded'
	}
})

-- lsp zero
local statusl, lsp = pcall(require, 'lsp-zero')
if (not statusl) then return end

lsp.preset({})

lsp.ensure_installed({
	'tsserver',
	'rust_analyzer',
	'pyright',
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format() end, opts)
end)

lsp.set_sign_icons({
	error = '✘',
	warn = '▲',
	hint = '⚑',
	info = '»'
})

-- lspconfig
local statusc, nvim_lsp = pcall(require, 'lspconfig')
if (not statusc) then return end

-- the nvim-cmp almost supports LSP's capabilities so advertise it to LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- advertise to clangd
nvim_lsp.clangd.setup {
	capabilities = capabilities
}

nvim_lsp.jdtls.setup {
	capabilities = capabilities
}

nvim_lsp.tsserver.setup {
	-- cragtzdog
	-- on_attach = on_attach,
	filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx', 'vue', 'svelte', 'astro' },
	cmd = { 'typescript-language-server', '--stdio' },
	capabilities = capabilities
}

nvim_lsp.lua_ls.setup {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- get the language server to recognize the vim global
				globals = { 'vim' }
			},
			-- workspace = {
			--     -- make the server aware of neovim runtime files
			--     library = vim.api.nvim_get_runtime_file('', true),
			--     checkThirdParty = false
			-- }
		}
	}
}

nvim_lsp.tailwindcss.setup {
	capabilities = capabilities
}

nvim_lsp.cssls.setup {
	capabilities = capabilities
}

lsp.setup()

-- configs auto completion
local cmp = require('cmp')
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
	sources = {
		{ name = 'path' },
		{ name = 'buffer',  keyword_length = 3 },
		{ name = 'luasnip', keyword_length = 2 },
		{ name = 'nvim_lsp' }
	},
	mapping = cmp.mapping.preset.insert({
		['<c-k>'] = cmp.mapping.select_prev_item(cmp_select_opts),
		['<c-j>'] = cmp.mapping.select_next_item(cmp_select_opts),
		['<c-u>'] = cmp.mapping.scroll_docs(-4),
		['<c-d>'] = cmp.mapping.scroll_docs(-4),
		['<c-a>'] = cmp.mapping.abort(),
		['<cr>'] = cmp.mapping.confirm({ select = true }),
		-- ['<tab>'] = cmp_action.luasnip_supertab(),
		['<s-tab>'] = cmp_action.luasnip_shift_supertab(),
	}),
	-- preselect first item
	preselect = 'item',
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	formatting = {
		-- changing the order of fields so the icon is the first
		fields = { 'abbr', 'kind', 'menu' },
		format = require('lspkind').cmp_format({
			mode = 'symbol', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

		})
	}
})
