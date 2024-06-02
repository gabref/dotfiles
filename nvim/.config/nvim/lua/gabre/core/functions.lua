F = {}

-- ~  --------------------------------------------------------------------------------  ~ --

---@param bufnr number
---@return boolean
function F.IsBigBuff(bufnr)
  local max_filesize = 1024 * 1024

  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  ---@diagnostic disable-next-line: return-type-mismatch
  return ok and stats and stats.size > max_filesize
end

-- ~  --------------------------------------------------------------------------------  ~ --

---@return boolean
function F.IsBufEmpty() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end

-- ~  --------------------------------------------------------------------------------  ~ --

---@return boolean
function F.IsGitRepo()
  local bufferpath = vim.fn.expand("%:p:h")
  local gitdir = vim.fn.finddir(".git", bufferpath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #bufferpath
end

-- ~  --------------------------------------------------------------------------------  ~ --

return F
