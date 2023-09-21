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
