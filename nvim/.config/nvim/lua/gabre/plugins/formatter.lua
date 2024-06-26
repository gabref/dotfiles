return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "x" },
			desc = "[F]ormat current buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			ocaml = { "ocamlformat" },
			rust = { "rustfmt" },
			lua = { "stylua" },
			python = { "ruff_format" },
			fish = { "fish_indent" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			css = { "prettier" },
			scss = { "prettier" },
			yaml = { "prettier" },
			html = { "prettier" },
			markdown = { "prettier" },
			json = { "biome" },
			jsonc = { "biome" },
			javascript = { "biome" },
			typescript = { "biome" },
		},
		-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters = {
			beautysh = { prepend_args = { "-i", "2" } },
			shfmt = { prepend_args = { "--simplify", "--indent", "2", "--binary-next-line", "--case-indent" } },
			biome = { inherit = false, command = "biome", stdin = false, args = { "format", "--write", "$FILENAME" } },
			prettier = { command = "prettier", stdin = true, args = { "--stdin-filepath", "$FILENAME" } },
		},
	},
}
