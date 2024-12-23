-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
--- @diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- vim.diagnostic.config({
-- 	virtual_text = {
-- 		prefix = "",
-- 		spacing = 0,
-- 		source = false,
-- 	},
-- 	float = {
-- 		source = true,
-- 	},
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = false,
-- })

return {
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	signs = true,
	virtual_text = {
		spacing = 4,
		severity = nil,
		source = "if_many",
		format = nil,
		prefix = "●",
	},
	float = {
		source = "if_many",
		wrap_at = 64,
		format = function(d)
			if not d.code and not d.user_data then
				return d.message
			end
			local t = vim.deepcopy(d)
			local code = d.code
			if not code then
				if not d.user_data.lsp then
					return d.message
				end
				code = d.user_data.lsp.code
			end
			if code then
				t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
			end
			return t.message
		end,
		border = "rounded",
	},
}
