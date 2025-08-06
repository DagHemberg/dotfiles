return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts_extend = { 'spec' },
  opts = {
    preset = 'helix',
    delay = function()
      return vim.g.wk_enabled and 0 or 2500
    end,
    triggers = {
      { '<auto>', mode = 'nixsotc' },
      { 'd', mode = 'n' },
      { 'c', mode = 'n' },
      { 'y', mode = 'n' },
    },
    spec = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = true })
        end,
        desc = 'Show keymaps',
      },
      { '<leader>s', group = 'search' },

      { '<leader>t', proxy = '¡t', group = 'toggle' },
      { '<leader>l', group = 'lsp' },
      { '<Esc>', '<cmd>nohlsearch<CR>', desc = 'Clear search highlight' },

      -- Move between windows
      { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
      { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
      { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
      { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },

      -- windows
      { '-', '<C-w>-', desc = 'Increase height' },
      { '+', '<C-w>+', desc = 'Decrease height' },
      { '<C-->', '<C-w><', desc = 'Increase width' },
      { '<C-+>', '<C-w>>', desc = 'Decrease width' },

      -- Leader key maps
      { '<leader>w', proxy = '<C-w>', group = 'window' },

      -- Insert mode
      { '<C-a>', '<Esc>I', desc = 'Beginning of line', mode = 'i' },
      { '<C-e>', '<Esc>A', desc = 'End of line', mode = 'i' },
      { '<C-BS>', '<C-w>', desc = 'Delete word', mode = 'i' },

      { 'q:', ':' },
    },
  },
}
