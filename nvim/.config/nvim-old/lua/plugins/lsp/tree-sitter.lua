return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    -- event = 'VeryLazy',
    -- branch = 'master',
    -- dependencies = {
    --   -- 'OXY2DEV/markview.nvim',
    --   'nvim-treesitter/nvim-treesitter-textobjects',
    --     -- branch = 'main'
    -- },
    -- main = 'nvim-treesitter.config',
    -- opts = {
    --   -- incremental_selection = {
    --   --   enable = true,
    --   --   keymaps = {
    --   --     node_incremental = '<C-Space>',
    --   --     node_decremental = '<BS>',
    --   --   },
    --   -- },
    --   auto_install = true,
    --   highlight = {
    --     enable = true,
    --     -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --     --  If you are experiencing weird indenting issues, add the language to
    --     --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    --     additional_vim_regex_highlighting = { 'ruby' },
    --   },
    --   indent = { enable = true, disable = { 'ruby' } },
    -- },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    branch = 'main',
    build = ':TSUpdate'
  }
}
