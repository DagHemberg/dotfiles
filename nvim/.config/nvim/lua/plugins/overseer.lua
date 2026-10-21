local vite_preview_fts = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'svelte',
}

--  ▄▄▄  ▄▄ ▄▄ ▄▄▄▄▄ ▄▄▄▄   ▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄
-- ██▀██ ██▄██ ██▄▄  ██▄█▄ ███▄▄ ██▄▄  ██▄▄  ██▄█▄
-- ▀███▀  ▀█▀  ██▄▄▄ ██ ██ ▄▄██▀ ██▄▄▄ ██▄▄▄ ██ ██

return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerRun', 'OverseerToggle', 'OverseerTaskAction' },
  keys = {
    { '<leader>or', function() require('overseer').run_task({}) end, desc = 'Run task (overseer)' },
    { '<leader>oR', '<CMD>OverseerShell<CR>' },
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
    {
      '<leader>P',
      function()
        local open = function(task)
          if task then
            ---@diagnostic disable-next-line: invisible, undefined-field
            local job_id = task.strategy and task.strategy.job_id
            if job_id then pcall(vim.api.nvim_chan_send, job_id, 'o\r') end
          end
        end

        local overseer = require('overseer')
        local running_tasks = overseer.list_tasks({ status = overseer.STATUS.RUNNING })

        if #running_tasks == 0 then
          overseer.run_task({}, open)
        elseif #running_tasks == 1 then
          open(running_tasks[1])
        else
          Snacks.picker.select(running_tasks, { format_item = function(item) return item.name end }, open)
        end
      end,
      ft = vite_preview_fts,
      desc = 'Open vite preview',
    },
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
