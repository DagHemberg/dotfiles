return {
  'folke/snacks.nvim',
  opts = {
    explorer = { replace_netrw = true },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { '.git' },
          -- layout = 'default'
          layout = {
            preview = false,
            layout = {
              position = 'left',
              width = 40,
              min_width = 40,
              height = 0,
              border = 'none',
              box = 'vertical',
              { win = 'list', title = '{title}' },
              { win = 'preview', height = 0.4, border = 'top' },
              { win = 'input', height = 2, border = 'top' },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      '<leader>e',
      function()
        require('snacks').explorer()
      end,
      desc = 'Toggle explorer',
    },
  },
}
