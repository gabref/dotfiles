return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = 'rafamadriz/friendly-snippets',
	event = { 'InsertEnter', 'CmdlineEnter' },

	-- use a release tag to download pre-built binaries
	version = 'v0.*',
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	---@diagnostic disable: missing-fields
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- see the "default configuration" section below for full documentation on how to define
		-- your own keymap.
		keymap = { preset = 'default' },
		enabled = function()
			return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
				and vim.bo.buftype ~= "prompt"
				and vim.b.completion ~= false
		end,
		completion = {
			menu = {
				border = 'none',
				draw = {
					gap = 2,
					columns = {
						{ "label",      "label_description", gap = 1 },
						{ "kind_icon",  "kind",              gap = 2 },
						{ "source_name" },
					},
				}
			},
			documentation = {
				auto_show = true,
				window = {
					border = 'single'
				}
			},
		},

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono'
		},

		-- default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		-- experimental signature help support
		-- signature = { enabled = true }
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" },
}
