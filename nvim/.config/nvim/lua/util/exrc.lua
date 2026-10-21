-- Source project-local exrc files (`.nvim.lua` / `.nvimrc` / `.exrc`) on
-- directory change, not just at startup.
--
-- Nvim's built-in 'exrc' only runs once, during startup, based on the launch
-- cwd. If you open nvim in ~ and then cd into a project (e.g. via the project
-- picker), the project's `.nvim.lua` is never sourced. This mirrors exrc's
-- behaviour but re-runs on DirChanged.
--
-- Trust is honoured via vim.secure.read(): untrusted files prompt and are
-- skipped if ignored, exactly like built-in exrc. Each file is executed at
-- most once per session.

local M = {}

-- Files we've already dealt with this session (sourced, or seen untrusted),
-- so cd'ing back and forth doesn't re-run or re-prompt.
local handled = {}

local function source_file(file)
  local contents = vim.secure.read(file) -- nil if untrusted / denied
  if not contents then
    return false
  end

  local ok, err
  if vim.endswith(file, '.lua') then
    local chunk, load_err = loadstring(contents, '@' .. file)
    if not chunk then
      vim.notify('exrc: ' .. load_err, vim.log.levels.ERROR)
      return false
    end
    ok, err = pcall(chunk)
  else
    ok, err = pcall(vim.api.nvim_exec2, contents, {})
  end
  if not ok then
    vim.notify('exrc: ' .. tostring(err), vim.log.levels.ERROR)
    return false
  end
  return true
end

-- Overseer caches its provider list, keyed on 'runtimepath', and only rebuilds
-- it when runtimepath changes. register_template() appends to the provider list
-- but does NOT invalidate that cache, so a template registered after the first
-- list() (e.g. when cd'ing into a project) is ignored until restart. Reset the
-- internal cache marker so the next list() rebuilds. Uses overseer internals;
-- degrades to a no-op if those change.
local function invalidate_overseer_cache()
  local ok, tmpl = pcall(require, 'overseer.template')
  if not ok or type(tmpl.list) ~= 'function' then
    return
  end
  -- `get_providers` is an upvalue of `M.list`; `last_rtp` is an upvalue of it.
  local i = 1
  while true do
    local name, fn = debug.getupvalue(tmpl.list, i)
    if not name then
      break
    end
    if name == 'get_providers' and type(fn) == 'function' then
      local j = 1
      while true do
        local upname = debug.getupvalue(fn, j)
        if not upname then
          break
        end
        if upname == 'last_rtp' then
          debug.setupvalue(fn, j, nil)
        end
        j = j + 1
      end
    end
    i = i + 1
  end
end

function M.run()
  local files = vim.fs.find({ '.nvim.lua', '.nvimrc', '.exrc' }, {
    type = 'file',
    upward = true,
    limit = math.huge,
  })
  local sourced_any = false
  for _, file in ipairs(files) do
    if not handled[file] then
      handled[file] = true
      if source_file(file) then
        sourced_any = true
      end
    end
    -- Match exrc: stop walking up once a file unsets 'exrc'
    if not vim.o.exrc then
      break
    end
  end
  if sourced_any then
    invalidate_overseer_cache()
  end
end

vim.api.nvim_create_autocmd('DirChanged', {
  group = vim.api.nvim_create_augroup('util_exrc', { clear = true }),
  desc = 'Source project-local exrc files after :cd',
  callback = M.run,
})

return M
