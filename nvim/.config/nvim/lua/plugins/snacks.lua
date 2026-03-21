return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,

  -- ▄▄ ▄▄ ▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄  ▄▄ ▄▄  ▄▄ ▄▄▄▄   ▄▄▄▄
  -- ██▄█▀ ██▄▄  ▀███▀ ██▄██ ██ ███▄██ ██▀██ ███▄▄
  -- ██ ██ ██▄▄▄   █   ██▄█▀ ██ ██ ▀██ ████▀ ▄▄██▀

  keys = {
    -- stylua: ignore start

    -- Pickers
    { '<leader><space>', function() Snacks.picker.smart({ title = 'Search' }) end, desc = 'Search files' },
    { '<leader>h', function() Snacks.picker.help() end, desc = 'help' },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = 'builtin pickers' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'keymaps' },
    { '<leader>su', function() Snacks.picker.undo() end, desc = 'undo tree' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'grep' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = 'resume previous' },
    { '<leader>sf', function() Snacks.picker.files() end, desc = 'files' },
    { '<leader>sc', function() Snacks.picker.lazy() end, desc = 'lazy packages' },
    { '<leader>sC', function() Snacks.picker.files({ cwd = '~/.config/nvim/', title = 'Neovim config files' }) end, desc = 'nvim config files' },
    { '<leader>sd', function() Snacks.picker.files({ cwd = '~/.dots/', title = '.dotfiles', hidden = true }) end, desc = 'dotfiles' },

    -- Explorer
    { '<leader>e', function() Snacks.explorer() end, desc = 'Toggle explorer'},

    -- LazyGit
    { '<leader>lg', function() Snacks.lazygit.open() end, desc = 'Open LazyGit' },

    -- Term
    { '<C-ö>', function() Snacks.terminal.toggle() end, desc = 'Toggle terminal', mode = { 'n', 't' } },
    -- { '<Esc>', '<C-\\><C-n>', mode = { 't' } }

    -- stylua: ignore end
  },

  config = function(_, opts)
    require('snacks').setup(opts)

    -- toggle binds have are set with :map('keybind') instead of
    -- Snacks.keymap.set so i have to put them here :(
    local inlay_hints = {
      name = 'inlay hints',
      get = vim.lsp.inlay_hint.is_enabled,
      set = vim.lsp.inlay_hint.enable,
    }

    Snacks.toggle.option('wrap'):map('<leader>tw')
    Snacks.toggle.new(inlay_hints):map('<leader>th')
  end,

  ---@type snacks.Config
  opts = {
    -- ▄▄▄▄  ▄▄  ▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄▄ ▄▄▄▄
    -- ██▄█▀ ██ ██▀▀▀ ██▄█▀ ██▄▄  ██▄█▄
    -- ██    ██ ▀████ ██ ██ ██▄▄▄ ██ ██

    explorer = { replace_netrw = true },
    picker = {
      ui_select = true,
      icons = {
        diagnostics = { Hint = '󰌵 ' },
        -- ui = { selected = ' ' },
      },
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { '.git' },
          layout = {
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

    -- ▄▄ ▄▄  ▄▄ ▄▄▄▄  ▄▄ ▄▄ ▄▄▄▄▄▄
    -- ██ ███▄██ ██▄█▀ ██ ██   ██
    -- ██ ██ ▀██ ██    ▀███▀   ██

    input = {
      relative = 'cursor',
      row = -3,
      col = 0,
    },

    -- ▄▄ ▄▄   ▄▄  ▄▄▄   ▄▄▄▄ ▄▄▄▄▄
    -- ██ ██▀▄▀██ ██▀██ ██ ▄▄ ██▄▄
    -- ██ ██   ██ ██▀██ ▀███▀ ██▄▄▄

    image = {
      doc = { enabled = true },
      math = { enabled = false },
    },

    --  ▄▄▄▄ ▄▄▄▄▄▄ ▄▄ ▄▄ ▄▄    ▄▄▄▄▄  ▄▄▄▄
    -- ███▄▄   ██   ▀███▀ ██    ██▄▄  ███▄▄
    -- ▄▄██▀   ██     █   ██▄▄▄ ██▄▄▄ ▄▄██▀

    styles = {
      terminal = {
        keys = {
          term_normal = {
            '<esc>',
            function()
              vim.cmd('stopinsert')
            end,
            mode = 't',
            expr = true,
          },
        },
      },
    },

    -- ▄▄   ▄▄ ▄▄  ▄▄▄▄  ▄▄▄▄
    -- ██▀▄▀██ ██ ███▄▄ ██▀▀▀
    -- ██   ██ ██ ▄▄██▀ ▀████

    lazygit = {},
    statuscolumn = {},
    keymap = {},
    term = {},
    toggle = {},
    words = { debounce = 0 },
  },
}
