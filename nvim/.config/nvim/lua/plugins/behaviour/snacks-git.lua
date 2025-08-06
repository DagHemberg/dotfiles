return {
  'folke/snacks.nvim',
  opts = {
    lazygit = {}
  },
  keys = {
    { '<leader>gg', require('snacks').lazygit.open, desc = 'Open LazyGit' },
  }
}
