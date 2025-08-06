return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      ui_select = true,
      icons = {
        diagnostics = { Hint = '󰌵 ' },
        -- ui = { selected = ' ' },
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { '<leader><space>', function() require('snacks').picker.smart({ title = 'Search' }) end, desc = 'files' },
    { '<leader>h', function() require('snacks').picker.help() end, desc = 'help' },
    { '<leader>ss', function() require('snacks').picker.pickers() end, desc = 'builtin pickers' },
    { '<leader>sk', function() require('snacks').picker.keymaps() end, desc = 'keymaps' },
    { '<leader>su', function() require('snacks').picker.undo() end, desc = 'undo tree' },
    { '<leader>sg', function() require('snacks').picker.grep() end, desc = 'grep' },
    { '<leader>sr', function() require('snacks').picker.resume() end, desc = 'resume previous' },
    { '<leader>sf', function() require('snacks').picker.files() end, desc = 'files' },
    { '<leader>sc', function() require('snacks').picker.files({ cwd = '~/.config/nvim/' }) end, desc = 'config files' },
    -- stylua: ignore end
  },
}
