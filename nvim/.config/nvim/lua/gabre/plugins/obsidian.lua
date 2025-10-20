return {
	"obsidian-nvim/obsidian.nvim",
	-- TODO: when works completion, reinstall
	version = "v3.13.0", -- recommended, use latest release instead of latest commit
	-- ft = "markdown",
	event = {
	  "BufReadPre " .. vim.fn.expand "~" .. "/personal/my-brain/*.md",
	  "BufNewFile " .. vim.fn.expand "~" .. "/personal/my-brain/*.md",
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = "~/personal/my-brain",
			}
		},
	},
}
