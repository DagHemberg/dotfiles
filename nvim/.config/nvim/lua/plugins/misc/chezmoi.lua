return {
  'xvzc/chezmoi.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- opts = {},
  config = function()
    require('chezmoi').setup({})
  end,
}
