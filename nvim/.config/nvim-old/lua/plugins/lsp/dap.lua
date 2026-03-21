return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'julianolf/nvim-dap-lldb',
  },
  config = function()
    local dap = require('dap')
    local ui = require('dapui')

    local lldb = require('dap-lldb')

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '󰜋', texthl = 'DiagnosticWarn', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '󱈸', texthl = 'DiagnosticError', linehl = '', numhl = '' })

    ui.setup()
    lldb.setup()

    require('which-key').add({
      { '<leader>b', dap.toggle_breakpoint, desc = 'Toggle breakpoint' },
      { '<F5>', dap.continue, desc = 'Start / Continue debugging' },
      { '<F10>', dap.step_over, desc = 'Step over' },
      { '<F11>', dap.step_into, desc = 'Step into' },
      { '<S-F5>', dap.run_to_cursor, desc = 'Run to cursor' },
    })

    dap.listeners.before.attach.dapui_config = ui.open
    dap.listeners.before.launch.dapui_config = ui.open
    dap.listeners.before.event_terminated.dapui_config = ui.close
    dap.listeners.before.event_exited.dapui_config = ui.open

    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "Run or Test Target",
        metals = {
          runType = "runOrTestFile",
        },
      },
      {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
          runType = "testTarget",
        },
      },
      {
        type = "scala",
        request = "attach",
        name = "Attach to Localhost",
        hostName = "localhost",
        port = 5005,
        buildTarget = "root",
      }
    }

  end,
}
