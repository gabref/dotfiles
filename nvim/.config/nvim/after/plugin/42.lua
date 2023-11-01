local status, header42 = pcall(require, '42header')
if (not status) then return end

header42.setup({
  length = 80, -- headers of different sizes are incompatible with each other
  margin = 5,
  default_map = true, -- default Mapping <F1> in normal mode
  auto_update = true, -- update header when saving
  user = "galves-f", -- your user
  mail = "marvin@42.fr", -- your mail
  -- asciiart = { "......", "......",} -- headers with different ascii arts are incompatible with each other
})

-- FORMATTER

local M = {}
local api = vim.api

M.opts = {
  formatter = "c_formatter_42",
  filetypes = { c = true, h = true, cpp = true, hpp = true },
}


M.set_equalprg = function(formatter)
  local current_buf = api.nvim_get_current_buf()
  api.nvim_buf_set_option(current_buf, "equalprg", formatter)
end


M.format = function(filetypes, formatter)
  if filetypes[vim.bo.filetype] then
    M.set_equalprg(formatter)
    api.nvim_feedkeys("gg=G", "n", true)
  else
    vim.notify("Unsupported file type", vim.log.levels.WARN)
  end
end

M.setup = function(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})


  api.nvim_create_user_command("CFormat42", function()
    M.format(M.opts.filetypes, M.opts.formatter)
  end, {})
end

M.setup({M.opts})

vim.api.nvim_set_keymap('n', '<leader>4', ':CFormat42<CR>', { noremap = true, silent = true })
