local status, ls = pcall(require, "luasnip")
if not status then return end
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.config.set_config {
	updateevents = "TextChanged,TextChangedI"
}

local function cur_date()
	return os.date "%Y-%m-%d"
	-- -%H:%M:%S
end

local function cur_date_long()
	return os.date "%B %d, %Y"
end

ls.add_snippets("md", {
	s("note", {
		t({'---', ''}),
		t({'id: "' .. cur_date() .. '"', ''}),
		t({'aliases:', ''}),
		t({'	- "' .. cur_date_long() .. '"', ''}),
		t({'tags:', ''}),
		i(1, '	- "'),
		i(1, 'daily-notes'),
		t({'"', '---', ''}),
	})
})

local function jump_snippet()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end

local function jump_snippet_back()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end

local opts = { remap = false, silent = true }
vim.keymap.set('i', '<c-l>', jump_snippet, opts)
vim.keymap.set('i', '<c-h>', jump_snippet_back, opts)
