return {
  'folke/snacks.nvim',
  opts = {
    lazygit = {}
  },
  keys = {
    { '<leader>lg', require('snacks').lazygit.open, desc = 'Open LazyGit' },
  }
}
