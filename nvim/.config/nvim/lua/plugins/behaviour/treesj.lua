return {
  'Wansmer/treesj',
  lazy = true,
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  keys = {
    {
      'L',
      function() require('treesj').toggle({ split = { recursive = false } }) end,
      desc = 'Toggle line split',
      mode = { 'n', 'x' },
    },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 10000,
  },
}
