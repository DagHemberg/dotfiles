return {
  'nvim-mini/mini.nvim',
  version = '*',
  event = 'BufRead',
  config = function()
    -- ▄▄   ▄▄  ▄▄▄  ▄▄ ▄▄ ▄▄▄▄▄
    -- ██▀▄▀██ ██▀██ ██▄██ ██▄▄
    -- ██   ██ ▀███▀  ▀█▀  ██▄▄▄

    require('mini.move').setup({
      mappings = {
        -- #justmacosthings, uncomment on linux/windows
        left = '˛',
        right = 'ﬁ',
        down = '√',
        up = 'ª',

        line_left = '˛',
        line_right = 'ﬁ',
        line_down = '√',
        line_up = 'ª',
      },
    })

    --  ▄▄▄  ▄▄    ▄▄  ▄▄▄▄ ▄▄  ▄▄
    -- ██▀██ ██    ██ ██ ▄▄ ███▄██
    -- ██▀██ ██▄▄▄ ██ ▀███▀ ██ ▀██

    require('mini.align').setup()

    --  ▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄  ▄▄▄▄   ▄▄▄  ▄▄ ▄▄ ▄▄  ▄▄ ▄▄▄▄
    -- ███▄▄ ██ ██ ██▄█▄ ██▄█▄ ██▀██ ██ ██ ███▄██ ██▀██
    -- ▄▄██▀ ▀███▀ ██ ██ ██ ██ ▀███▀ ▀███▀ ██ ▀██ ████▀

    local sr = require('mini.surround')
    local sr_ts = sr.gen_spec.input.treesitter
    sr.setup({
      n_lines = 500,
      respect_selection_type = true,
      mappings = {
        add = 'gs',
        delete = 'ds',
        replace = 'cs',
        highlight = '',
        find = '',
        find_left = '',
      },
      custom_surroundings = {
        b = {
          input = { { '%b()', '%b[]', '%b{}' }, '^.%s*().-()%s*.$' },
          output = { left = '(', right = ')' },
        },
        B = {
          input = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' },
          output = { left = '{ ', right = ' }' },
        },
        F = { input = sr_ts({ outer = '@function.outer', inner = '@function.inner' }) },
        o = { input = sr_ts({ outer = '@block.outer', inner = '@block.inner' }) },
        c = { input = sr_ts({ outer = '@class.outer', inner = '@class.inner' }) },
      },
    })

    --  ▄▄▄  ▄▄▄▄   ▄▄▄  ▄▄ ▄▄ ▄▄  ▄▄ ▄▄▄▄      █   ▄▄ ▄▄  ▄▄  ▄▄▄▄ ▄▄ ▄▄▄▄  ▄▄▄▄▄
    -- ██▀██ ██▄█▄ ██▀██ ██ ██ ███▄██ ██▀██    █    ██ ███▄██ ███▄▄ ██ ██▀██ ██▄▄
    -- ██▀██ ██ ██ ▀███▀ ▀███▀ ██ ▀██ ████▀   █     ██ ██ ▀██ ▄▄██▀ ██ ████▀ ██▄▄▄

    local ai = require('mini.ai')
    local ai_ts = ai.gen_spec.treesitter
    ai.setup({
      n_lines = 500,
      custom_textobjects = {
        b = { { '%b()', '%b[]', '%b{}' }, '^.%s*().-()%s*.$' },
        B = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' },
        F = ai_ts({ a = '@function.outer', i = '@function.inner' }),
        o = ai_ts({ a = '@block.outer', i = '@block.inner' }),
        c = ai_ts({ a = '@class.outer', i = '@class.inner' }),
      },
    })

    -- ▄▄▄▄  ▄▄▄▄   ▄▄▄   ▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄
    -- ██▄██ ██▄█▄ ██▀██ ██▀▀▀ ██▄█▀ ██▄▄    ██   ██▄▄  ██▀██
    -- ██▄█▀ ██ ██ ██▀██ ▀████ ██ ██ ██▄▄▄   ██   ██▄▄▄ ████▀

    require('mini.bracketed')
  end,
}
