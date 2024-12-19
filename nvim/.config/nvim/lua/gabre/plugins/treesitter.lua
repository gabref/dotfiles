local opts = {
  ensure_installed = {
    'c',
    'lua',
    'vim',
    'vimdoc',
    'query',
    'markdown',
    'markdown_inline',
  },
}

local function config()
  require('nvim-treesitter.configs').setup(opts)
end
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = vim.fn.argc(-1) == 0,
  config = config,
  build = ':TSUpdate',
}
