return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"onsails/lspkind.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		event = { "BufRead", "BufNewFile" },
		opts = {
			diagnostics = require("gabre.core.diagnostics"),
		},
		config = function(_, opts)
			local neodev = require("neodev")
			neodev.setup({
				-- library = {
				--   plugins = { "nvim-dap-ui" },
				--   types = true,
				-- },
			})

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig")

			local servers = {
				bashls = true,
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
				lua_ls = true,
				rust_analyzer = true,
				templ = true,
				cssls = true,
				tailwindcss = true,

				tsserver = {
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
				},

				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
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

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},

				ocamllsp = {
					manual_install = true,
					settings = {
						codelens = { enable = true },
						inlayHints = { enable = true },
					},

					filetypes = {
						"ocaml",
						"ocaml.interface",
						"ocaml.menhir",
						"ocaml.cram",
					},
					-- TODO: Check if i still need the filtypes stuff i had before
				},

				clangd = {
					-- TODO: Could include cmd, but not sure those were all relevant flags.
					--    looks like something i would have added while i was floundering
					init_options = { clangdFileStatus = true },
					cmd = { "clangd", "--offset-encoding=utf-16" },
					filetypes = { "c", "h", "cpp", "chh", "objc", "objcpp", "cuda", "proto" },
					root_dir = lspconfig.util.root_pattern(
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

				biome = {
					filetypes = {
						"javascript",
						"json",
						"jsonc",
						"typescript",
						"typescript.tsx",
						"astro",
						"svelte",
						"vue",
					},
					root_dir = lspconfig.util.root_pattern(".git", "package.json", "biome.json", "biome.jsonc"),
					cmd = { "biome", "lsp-proxy" },
					single_file_support = false,
				},

				svelte = {
					filetypes = { "svelte", "css", "html", "javascript", "typescript" },
					root_dir = lspconfig.util.root_pattern("biome.json", "biome.jsonc", "svelte.config.js", ".git"),
					single_file_support = true,
				},
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			local mason = require("mason")
			mason.setup({
				ui = {
					border = "rounded",
				},
			})

			-- mason
			local ensure_installed = {
				"stylua",
				"pyright",
				"lua_ls",
				"delve",
				"bash-language-server",
				"clangd",
				"css-lsp",
				"delve",
				"gopls",
				"json-lsp",
				"lua-language-server",
				"rust-analyzer",
				"stylua",
				"svelte-language-server",
				"biome",
				"tailwindcss-language-server",
				"templ",
				"typescript-language-server",
				"docker-compose-language-service",
				"yaml-language-server",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end

				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
					local opts = { buffer = bufnr, remap = false }

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
					-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
					vim.keymap.set("i", "<c-h>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set({ "n", "x" }, "<leader>f", vim.lsp.buf.format, opts)
					vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})

			vim.diagnostic.config(vim.deepcopy(opts.diagnostic))
		end,
	},
}
