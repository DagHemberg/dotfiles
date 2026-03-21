return {
  'folke/noice.nvim',
  opts = {
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
