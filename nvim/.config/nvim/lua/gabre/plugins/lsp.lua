return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
		config = function()
			require('mason').setup({
				ui = {
					border = "rounded",
				}
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"b0o/SchemaStore.nvim",
			{ 'saghen/blink.cmp' },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } }
					}
				}
			},
		},
		init = function()
			-- reserve a space in the gutter
			-- this will avoid an annoying layout shift in the screen
			vim.opt.signcolumn = 'yes'
		end,
		opts = {
			diagnostics = require('gabre.diagnostics'),
			ensure_installed = {
				"lua_ls",
				"bash-language-server",
				"templ",
				"gopls",
				"prismals",
				"rust_analyzer",
				"cssls",
				"css-lsp",
				"json-lsp",
				"tailwindcss-language-server",
				"typescript-language-server",
				"marksman",
				"yaml-language-server",
			},
		},
		config = function(_, opts)
			local lspconfig = require('lspconfig')

			local servers = {
				lua_ls = {},
				cssls = {},
				tailwindcss = {},

				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},

				ts_ls = {
					-- from my old config, maybe there better solution nowadays
					filetypes = {
						"typescript",
						"typescriptreact",
						"typescript.tsx",
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"vue",
						"svelte",
						"astro",
					},
					cmd = { "typescript-language-server", "--stdio" },
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},


				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},


				clangd = {
					-- TODO: Could include cmd, but not sure those were all relevant flags.
					--    looks like something i would have added while i was floundering
					init_options = { clangdFileStatus = true },
					cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
					filetypes = { "c", "h", "cpp", "chh", "objc", "objcpp", "cuda", "proto" },
					root_dir = require('lspconfig').util.root_pattern(
						".clangd",
						".clang-tidy",
						".clang-format",
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac",
						".git"
					),
					single_file_support = true,
				},

				docker_compose_language_service = {
					filetypes = { "yaml.docker-compose" },
					root_dir = lspconfig.util.root_pattern(
						"docker-compose.yaml",
						"docker-compose.yml",
						"compose.yaml",
						"compose.yml",
						".git"
					),
					cmd = { "docker-compose-langserver", "--stdio" },
					single_file_support = true,
				},

				taplo = {
					filetype = { "toml" },
				},

				pyright = {
					filetypes = { "python" },
					root_dir = lspconfig.util.root_pattern(
						"*.py",
						"__init__.py",
						".git",
						"ruff.toml",
						"pyproject.toml"
					),
					settings = {
						pylsp = {
							plugins = {
								autopep8 = { enabled = false },
								flake8 = { enabled = false },
								yapf = { enabled = false },
								mccabe = { enabled = false },
								pycodestyle = { enabled = false },
								pyflakes = { enabled = false },
								pylint = { enabled = false },
							},
						},
					},
					cmd = { "pylsp" },
					single_file_support = true,
				},
			}

			for server, config in pairs(servers) do
				config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			vim.list_extend(opts.ensure_installed, servers_to_install)
			require('mason-tool-installer').setup({ ensure_installed = opts.ensure_installed })

			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = function(event)
					local kopts = { buffer = event.buf, remap = false }
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, kopts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, kopts)
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, kopts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, kopts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, kopts)
					vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, kopts)
					vim.keymap.set('i', '<c-h>', vim.lsp.buf.signature_help, kopts)
					vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, kopts)
					vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, kopts)
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, kopts)
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, kopts)
				end,
			})

			vim.diagnostic.config(vim.deepcopy(opts.diagnostic))
		end,
	}
}
