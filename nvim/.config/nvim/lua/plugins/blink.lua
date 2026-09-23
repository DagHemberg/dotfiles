return {
  --  ▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄
  -- ██▀▀▀ ██▀▄▀██ ██▄█▀
  -- ▀████ ██   ██ ██
  {
    'saghen/blink.cmp',
    build = function() require('blink.cmp').build():pwait() end,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'saghen/blink.lib',
      'xzbdmw/colorful-menu.nvim',
      'rafamadriz/friendly-snippets',
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'super-tab',
        -- ['<CR>'] = { 'accept', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 1000 },
        menu = {
          -- border = 'rounded',
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', gap = 1 },
            },
            components = {
              label = {
                text = function(ctx) return require('colorful-menu').blink_components_text(ctx) end,
                highlight = function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end,
              },
            },
          },
        },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = 'inherit',
          ['<CR>'] = { 'fallback' },
        },
        completion = {
          menu = { auto_show = true },
          ghost_text = { enabled = false },
        },
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          cmdline = {
            min_keyword_length = function(ctx)
              -- when typing a command, only show when the keyword is 3 characters or longer
              if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
                return 3
              end
              return 0
            end,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    },
  },

  -- ▄▄▄▄   ▄▄▄  ▄▄ ▄▄▄▄   ▄▄▄▄
  -- ██▄█▀ ██▀██ ██ ██▄█▄ ███▄▄
  -- ██    ██▀██ ██ ██ ██ ▄▄██▀
  {
    'saghen/blink.pairs',
    dependencies = 'saghen/blink.lib',
    version = '*',
    build = function() require('blink.pairs').download():pwait(60000) end,
    -- build = 'cargo build --release',

    event = { 'InsertEnter', 'CmdlineEnter' },

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      highlights = { enabled = false },
    },
  },

  -- ▄▄    ▄▄ ▄▄▄▄
  -- ██    ██ ██▄██
  -- ██▄▄▄ ██ ██▄█▀
  {
    'saghen/blink.lib',
  },
}
