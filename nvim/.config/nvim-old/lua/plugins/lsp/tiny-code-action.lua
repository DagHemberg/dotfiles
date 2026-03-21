return {
  'rachartier/tiny-code-action.nvim',
  event = 'LspAttach',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'folke/snacks.nvim',
      opts = {
        terminal = {},
      },
    },
  },
  opts = {
    backend = 'vim',
    -- backend_opts = {
    --   difftastic = {
    --     args = {
    --       '--color=always',
    --       '--syntax-highlight=on',
    --       -- '--display=inline',
    --       '--width=999',
    --     },
    --   },
    -- },
    picker = {
      'snacks',
      -- opts = { postiton = 'cursor' },
    },
  },
}
