return {
  -- ▄▄▄▄  ▄▄    ▄▄▄▄▄ ▄▄  ▄▄  ▄▄▄  ▄▄▄▄  ▄▄ ▄▄
  -- ██▄█▀ ██    ██▄▄  ███▄██ ██▀██ ██▄█▄ ▀███▀
  -- ██    ██▄▄▄ ██▄▄▄ ██ ▀██ ██▀██ ██ ██   █
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },

  -- ▄▄  ▄▄ ▄▄▄▄▄  ▄▄▄   ▄▄▄▄  ▄▄▄  ▄▄   ▄▄ ▄▄▄▄   ▄▄▄   ▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄
  -- ███▄██ ██▄▄  ██▀██ ██▀▀▀ ██▀██ ██▀▄▀██ ██▄█▀ ██▀██ ███▄▄ ██▄▄  ██▄█▄
  -- ██ ▀██ ██▄▄▄ ▀███▀ ▀████ ▀███▀ ██   ██ ██    ▀███▀ ▄▄██▀ ██▄▄▄ ██ ██
  {
    'ecthelionvi/NeoComposer.nvim',
    event = 'InsertEnter',
    dependencies = {
      'kkharji/sqlite.lua',
    },
    opts = {
      queue_most_recent = true,
      keymaps = {
        toggle_record = 'qq',
        cycle_next = ']Q',
        cycle_prev = '[Q',
        toggle_macro_menu = '<C-q>',
      },
    },
  },

  --  ▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄   ▄▄▄▄ ▄▄▄▄▄▄ ▄▄ ▄▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄
  -- ███▄▄ ██ ██ ██▄██ ███▄▄   ██   ██   ██   ██ ██   ██   ██▄▄
  -- ▄▄██▀ ▀███▀ ██▄█▀ ▄▄██▀   ██   ██   ██   ▀███▀   ██   ██▄▄▄
  {
    'gbprod/substitute.nvim',
    dependencies = { 'rachartier/tiny-glimmer.nvim' },
    opts = {
      on_substitute = function()
        require('tiny-glimmer.support.substitute').substitute_cb()
      end,
      highlight_substituted_text = { enabled = false },
    },
    -- stylua: ignore start
    keys = {
      { 's', function() require('substitute').operator() end, noremap = true },
      { 'S', function() require('substitute').eol() end, noremap = true },
      { 'ss', function() require('substitute').line() end, noremap = true },
      { 's', function() require('substitute').visual() end, noremap = true, mode = 'x' },
      { 'sx', function() require('substitute.exchange').operator() end, noremap = true },
      { 'sxx', function() require('substitute.exchange').line() end, noremap = true },
      { 'X', function() require('substitute.exchange').visual() end, noremap = true, mode = 'x' },
    },
    -- stylua: ignore end
  },

  --  ▄▄▄▄ ▄▄    ▄▄ ▄▄   ▄▄ ▄▄   ▄▄ ▄▄▄▄▄ ▄▄▄▄
  -- ██ ▄▄ ██    ██ ██▀▄▀██ ██▀▄▀██ ██▄▄  ██▄█▄
  -- ▀███▀ ██▄▄▄ ██ ██   ██ ██   ██ ██▄▄▄ ██ ██
  {
    'rachartier/tiny-glimmer.nvim',
    event = 'BufRead',
    priority = 10,
    opts = {
      -- transparency_color = '#1A1B26',
      -- transparency_color = '#0E1415',
      animations = {
        fade = {
          max_duration = 400,
          min_duration = 400,
          to_color = '#1A1B26',
          from_color = '#283457',
        },
      },
      support = {
        substitute = {
          enabled = true,
        },
      },
      overwrite = {
        yank = { default_animation = 'fade' },
        paste = { default_animation = 'fade' },
        undo = { enabled = true, default_animation = { name = 'fade', settings = { from_color = '#442328' } } },
        redo = { enabled = true, default_animation = { name = 'fade', settings = { from_color = '#0e6252' } } },
      },
    },
  },

  -- ▄▄▄▄▄▄ ▄▄▄  ▄▄▄▄   ▄▄▄       ▄▄▄▄  ▄▄▄  ▄▄   ▄▄ ▄▄   ▄▄ ▄▄▄▄▄ ▄▄  ▄▄ ▄▄▄▄▄▄ ▄▄▄▄
  --   ██  ██▀██ ██▀██ ██▀██ ▄▄▄ ██▀▀▀ ██▀██ ██▀▄▀██ ██▀▄▀██ ██▄▄  ███▄██   ██  ███▄▄
  --   ██  ▀███▀ ████▀ ▀███▀     ▀████ ▀███▀ ██   ██ ██   ██ ██▄▄▄ ██ ▀██   ██  ▄▄██▀
  {
    'folke/todo-comments.nvim',
    event = { 'BufRead', 'BufNewFile' },
    opts = {},
    keys = {
      {
        '<leader>st',
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments({ keywords = { 'TODO', 'BUG', 'FIX', 'FIXME' } })
        end,
        desc = 'todos',
      },
      {
        '<leader>sn',
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments({ keywords = { 'NOTE' } })
        end,
        desc = 'notes',
      },
    },
  },

  --  ▄▄▄▄  ▄▄▄  ▄▄     ▄▄▄  ▄▄▄▄  ▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄
  -- ██▀▀▀ ██▀██ ██    ██▀██ ██▄█▄ ██   ▄█▀ ██▄▄  ██▄█▄
  -- ▀████ ▀███▀ ██▄▄▄ ▀███▀ ██ ██ ██ ▄██▄▄ ██▄▄▄ ██ ██
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufRead',
    opts = {
      user_default_options = {
        names = false,
        mode = 'virtualtext',
        virtualtext = '󱓻',
        virtualtext_inline = 'before',
        css_fn = true,
        RRGGBBAA = true,
      },
    },
  },

  --  ▄▄▄▄ ▄▄    ▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄▄▄ ▄▄ ▄▄
  -- ███▄▄ ██    ██▄▄  ██ ██   ██   ██▄██
  -- ▄▄██▀ ██▄▄▄ ██▄▄▄ ▀███▀   ██   ██ ██
  {
    'tpope/vim-sleuth',
    event = 'BufRead',
  },

  -- ▄▄▄▄▄▄ ▄▄▄▄   ▄▄▄  ▄▄ ▄▄ ▄▄▄▄  ▄▄    ▄▄▄▄▄
  --   ██   ██▄█▄ ██▀██ ██ ██ ██▄██ ██    ██▄▄
  --   ██   ██ ██ ▀███▀ ▀███▀ ██▄█▀ ██▄▄▄ ██▄▄▄
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>d', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    },
  },

  -- ▄▄ ▄▄  ▄▄  ▄▄▄▄     ▄▄▄▄  ▄▄▄▄▄ ▄▄  ▄▄  ▄▄▄  ▄▄   ▄▄ ▄▄▄▄▄
  -- ██ ███▄██ ██▀▀▀ ▄▄▄ ██▄█▄ ██▄▄  ███▄██ ██▀██ ██▀▄▀██ ██▄▄
  -- ██ ██ ▀██ ▀████     ██ ██ ██▄▄▄ ██ ▀██ ██▀██ ██   ██ ██▄▄▄
  {
    'smjonas/inc-rename.nvim',
    event = 'BufRead',
    opts = {},
  },

  --  ▄▄▄▄ ▄▄ ▄▄▄▄▄▄ ▄▄▄▄ ▄▄  ▄▄▄▄ ▄▄  ▄▄  ▄▄▄▄
  -- ██ ▄▄ ██   ██  ███▄▄ ██ ██ ▄▄ ███▄██ ███▄▄
  -- ▀███▀ ██   ██  ▄▄██▀ ██ ▀███▀ ██ ▀██ ▄▄██▀
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    opts = {},
  },
}
