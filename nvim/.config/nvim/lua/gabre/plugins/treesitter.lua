return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufEnter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		tag = "v0.9.2",
		opts = function()
			return {
				ensure_installed = {
					"regex",
					"bash",
					"rust",
					"javascript",
					"typescript",
					"c",
					"cpp",
					"lua",
					"luadoc",
					"vim",
					"vimdoc",
					"rust",
					"tsx",
					"json",
					"css",
					"java",
					"scheme",
					"python",
					"yaml",
					"html",
					"markdown",
					"toml",
					"dockerfile",
					"markdown_inline",
					"svelte",
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
				highlight = {
					enable = true,
					-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					disable = function(_, buf) -- lang, buf
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
				autotag = {
					enable = true,
				},
			}
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
		end,
	},
}
