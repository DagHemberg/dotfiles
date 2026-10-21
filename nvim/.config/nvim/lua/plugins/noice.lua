return {
  -- ▄▄  ▄▄  ▄▄▄  ▄▄  ▄▄▄▄ ▄▄▄▄▄
  -- ███▄██ ██▀██ ██ ██▀▀▀ ██▄▄
  -- ██ ▀██ ▀███▀ ██ ▀████ ██▄▄▄

  'folke/noice.nvim',
  lazy = false,
  keys = {
    { '<leader>xn', '<cmd>NoiceSnacks<CR>' },
  },
  opts = {
    routes = {
      {
        filter = { event = 'lsp', find = 'Validate documents' },
        opts = { skip = true },
      },
      {
        filter = { event = 'lsp', find = 'Publish Diagnostics' },
        opts = { skip = true },
      },
      {
        filter = { event = 'lsp', find = 'lint: mccabe' },
        opts = { skip = true },
      },
      {
        filter = { event = 'lsp', find = 'lint: pycodestyle' },
        opts = { skip = true },
      },
      {
        filter = { event = 'lsp', find = 'lint: pyflakes' },
        opts = { skip = true },
      },
      {
        filter = { find = 'Wrote Mason lockfile' },
        opts = { skip = true },
      },
    },
    presets = {
      command_palette = true,
      lsp_doc_border = true,
    },
    lsp = {
      hover = { silent = true },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    views = {
      cmdline_popup = {
        border = 'none',
        size = { min_width = 3 },
        position = { col = 0, row = -1 },
      },
      mini = {
        position = { row = -1 },
        timeout = 4000,
      },
      confirm = {
        size = { min_width = 60, max_width = 120 },
      },
    },
    popupmenu = { enabled = true },
    messages = { enabled = true },
    cmdline = {
      enabled = true,
      format = {
        cmdline = false,
        lua = { icon = ':lua' },
        help = { icon = ':help' },
        IncRename = {
          pattern = '^:%s*IncRename%s+',
          icon = '󰑕 ',
          conceal = true,
          opts = {
            border = 'rounded',
            relative = 'cursor',
            size = { min_width = 20 },
            position = { row = -2, col = 0 },
          },
        },
      },
    },
  },
}
