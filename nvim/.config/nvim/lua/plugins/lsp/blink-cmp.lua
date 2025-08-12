return {
  'saghen/blink.cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  build = 'cargo build --release',
  dependencies = {
    'xzbdmw/colorful-menu.nvim',
    'rafamadriz/friendly-snippets',
  },
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
          -- We don't need label_description now because label and
          -- label_description are already combined together in label by
          -- colorful-menu.nvim.
          columns = {
            { 'kind_icon' },
            { 'label', gap = 1 },
          },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
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
}
