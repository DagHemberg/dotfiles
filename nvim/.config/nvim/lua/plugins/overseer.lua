local helpers = {}

do
  helpers.fts = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }

  local function package_uses_vite(path)
    local ok, lines = pcall(vim.fn.readfile, path)
    if not ok then return false end
    local ok2, pkg = pcall(vim.json.decode, table.concat(lines, '\n'))
    if not ok2 then return false end

    local dev_script = (pkg.scripts or {}).dev
    if not dev_script then return false end
    if dev_script:find('vite', 1, true) then return true end
    local deps = pkg.dependencies or {}
    local dev_deps = pkg.devDependencies or {}
    return deps.vite ~= nil or dev_deps.vite ~= nil
  end

  -- Walk upward from the buffer looking for a package.json with a vite-flavored
  -- "dev" script. Keeps going past library packages that have no dev server of
  -- their own (e.g. a monorepo package consumed by a sibling app), stopping at
  -- $HOME so it never scans outside the user's projects.
  local function find_package_json()
    local matches = vim.fs.find('package.json', {
      upward = true,
      path = vim.fn.expand('%:p:h'),
      limit = math.huge,
      stop = vim.uv.os_homedir(),
    })
    for _, path in ipairs(matches) do
      if package_uses_vite(path) then return path end
    end
    return nil
  end

  -- Matches the `{ mgr, "run", "dev*" }` shape overseer's built-in npm/pnpm
  -- template provider builds for a package.json script. Matches any "dev"-
  -- prefixed script (e.g. "dev:mock-api", "dev:mock-api:self_serve"), since
  -- those are typically just the same vite dev server with different env vars.
  local function is_dev_task(task, root)
    return task.cwd == root
      and type(task.cmd) == 'table'
      and task.cmd[2] == 'run'
      and type(task.cmd[3]) == 'string'
      and task.cmd[3]:match('^dev') ~= nil
  end

  local function send_open_key(task)
    local job_id = task.strategy and task.strategy.job_id
    if job_id then pcall(vim.api.nvim_chan_send, job_id, 'o\r') end
  end

  local function wait_and_open(task)
    local timer = vim.uv.new_timer()
    local done = false
    local on_lines

    local function finish()
      if done then return end
      done = true
      if timer then
        timer:stop()
        timer:close()
      end
      task:unsubscribe('on_output_lines', on_lines)
      send_open_key(task)
    end

    on_lines = function(_, lines)
      for _, line in ipairs(lines) do
        if line:match('Local:') or line:match('ready in') then
          finish()
          return
        end
      end
    end

    task:subscribe('on_output_lines', on_lines)
    timer:start(15000, 0, vim.schedule_wrap(finish))
  end

  function helpers.open()
    local pkg_path = find_package_json()
    if not pkg_path then
      vim.notify('vite preview: no vite dev script found upward from this file', vim.log.levels.WARN)
      return
    end

    local root = vim.fs.dirname(pkg_path)
    local overseer = require('overseer')

    local running = overseer.list_tasks({
      status = overseer.STATUS.RUNNING,
      filter = function(t) return is_dev_task(t, root) end,
    })[1]

    if running then
      send_open_key(running)
      return
    end

    overseer.run_task({ search_params = { dir = root } }, function(task, err)
      if err then
        vim.notify('vite preview: ' .. err, vim.log.levels.ERROR)
        return
      end
      if task and is_dev_task(task, root) then wait_and_open(task) end
    end)
  end
end

-- Show a placeholder message in the overseer task list when it has no tasks,
-- since the plugin just leaves the buffer blank otherwise.
do
  local empty_ns = vim.api.nvim_create_namespace('overseer_empty_message')
  local empty_label = 'No tasks'

  local function refresh_empty_message(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) then return end
    vim.api.nvim_buf_clear_namespace(bufnr, empty_ns, 0, -1)

    local is_empty = vim.api.nvim_buf_line_count(bufnr) == 1 and vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] == ''
    if not is_empty then return end

    local winid = vim.fn.bufwinid(bufnr)
    local width = winid ~= -1 and vim.api.nvim_win_get_width(winid) or 30
    local height = winid ~= -1 and vim.api.nvim_win_get_height(winid) or 1

    local pad_left = string.rep(' ', math.max(0, math.floor((width - #empty_label) / 2)))
    local pad_top = math.max(0, math.floor((height - 1) / 2))

    local virt_lines = {}
    for _ = 1, pad_top do
      table.insert(virt_lines, { { '' } })
    end
    table.insert(virt_lines, { { pad_left .. empty_label, 'Comment' } })

    vim.api.nvim_buf_set_extmark(bufnr, empty_ns, 0, 0, { virt_lines = virt_lines })
  end

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'OverseerList',
    desc = '[Overseer] Show a message when the task list is empty',
    callback = function(args)
      local bufnr = args.buf
      refresh_empty_message(bufnr)
      if vim.b[bufnr].overseer_empty_message_attached then return end
      vim.b[bufnr].overseer_empty_message_attached = true
      vim.api.nvim_buf_attach(bufnr, false, {
        on_lines = function()
          vim.schedule(function() refresh_empty_message(bufnr) end)
        end,
      })
    end,
  })

  vim.api.nvim_create_autocmd('WinResized', {
    desc = '[Overseer] Re-center the empty task list message on resize',
    callback = function()
      for _, winid in ipairs(vim.v.event.windows) do
        if vim.api.nvim_win_is_valid(winid) then
          local bufnr = vim.api.nvim_win_get_buf(winid)
          if vim.bo[bufnr].filetype == 'OverseerList' then refresh_empty_message(bufnr) end
        end
      end
    end,
  })
end

--  ▄▄▄  ▄▄ ▄▄ ▄▄▄▄▄ ▄▄▄▄   ▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄
-- ██▀██ ██▄██ ██▄▄  ██▄█▄ ███▄▄ ██▄▄  ██▄▄  ██▄█▄
-- ▀███▀  ▀█▀  ██▄▄▄ ██ ██ ▄▄██▀ ██▄▄▄ ██▄▄▄ ██ ██

return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerRun', 'OverseerToggle', 'OverseerTaskAction' },
  keys = {
    { '<leader>or', function() require('overseer').run_task({}) end, desc = 'Run task (overseer)' },
    {
      '<leader>oo',
      function()
        local explorer = Snacks.picker.get({ source = 'explorer' })[1]
        if explorer then explorer:close() end
        require('overseer').toggle({
          direction = 'left',
        })
      end,
      desc = 'Toggle task list',
    },
    { '<leader>oa', '<cmd>OverseerTaskAction<cr>', desc = 'Task action' },
    { '<leader>P', helpers.open, ft = helpers.fts, desc = 'Open vite preview' },
  },
  opts = {
    task_list = {
      keymaps = {
        q = { '<CMD>q<CR>', nowait = true },
        j = 'keymap.next_task',
        k = 'keymap.prev_task',
      },
    },
  },
}
