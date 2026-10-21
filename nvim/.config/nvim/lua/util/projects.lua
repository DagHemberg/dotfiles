-- Project tracking for the snacks dashboard picker.

local M = {}

local PROJECTS_FILE = vim.fn.stdpath('state') .. '/projects'

---@return string
function M.cwd() return vim.uv.fs_realpath(vim.uv.cwd() or '') or '' end

---@return string[]
function M.projects()
  local ok, lines = pcall(vim.fn.readfile, PROJECTS_FILE)
  if not ok then return {} end
  local paths = {}
  for _, line in ipairs(lines) do
    line = vim.trim(line)
    if line ~= '' then paths[#paths + 1] = line end
  end
  return paths
end

--- The project this instance should open: the cwd when it is itself tracked,
--- otherwise the most recently opened one. Nil when nothing is tracked.
---@return string?
function M.target()
  local tracked = M.projects()
  local cwd = M.cwd()
  if cwd and vim.tbl_contains(tracked, cwd) then return cwd end
  return tracked[1]
end

--- Track cwd as the most recently opened project.
function M.reorder()
  local cwd = M.cwd()
  local kept = {}
  for _, path in ipairs(M.projects()) do
    if path ~= cwd then kept[#kept + 1] = path end
  end
  table.insert(kept, 1, cwd)
  vim.fn.mkdir(vim.fn.stdpath('state'), 'p')
  vim.fn.writefile(kept, PROJECTS_FILE)
end

--- Directory the active session belongs to, or nil if none is active.
local function active_dir()
  if vim.v.this_session == '' then return nil end
  return vim.uv.fs_realpath(vim.fn.fnamemodify(vim.v.this_session, ':h'))
end

--- Switch to `dir` and restore its session, saving the outgoing one first.
---@param dir string
function M.open(dir)
  local sessions = require('mini.sessions')

  if active_dir() == M.cwd() then sessions.write(nil, { force = true, verbose = false }) end

  local autowrite = sessions.config.autowrite
  sessions.config.autowrite = false
  local ok, err = pcall(function()
    vim.fn.chdir(dir)
    if vim.fn.filereadable(dir .. '/' .. sessions.config.file) == 1 then
      sessions.read()
    else
      -- Nothing to restore; leave us in the directory and show the files
      Snacks.picker.explorer()
    end
  end)
  sessions.config.autowrite = autowrite

  if not ok then error(err) end
end

return M
