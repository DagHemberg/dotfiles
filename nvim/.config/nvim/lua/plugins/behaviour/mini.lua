return {
  'nvim-mini/mini.nvim',
  version = false,
  event = 'BufRead',
  config = function()
    require('mini.move').setup()
    require('mini.align').setup()

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
        -- update_n_lines = '',
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

    -- re-adding all textobjects because mini.ai messes them up :(
    local operators = {
      { 'd', group = 'delete' },
      { 'c', group = 'change' },
      { 'y', group = 'yank' },
      { 's', group = 'substitute' },

      { 'ga', desc = 'align' },
      { 'gA', desc = 'align w/ preview' },
      { 'g~', desc = 'toggle case' },
      { 'gu', desc = 'lowercase' },
      { 'gU', desc = 'UPPERCASE' },
      { 'gw', desc = 'justify' },
      { 'gc', desc = 'toggle comment' },

      { '=', desc = 'fix indent' },
      { '<', desc = 'indent left' },
      { '>', desc = 'indent right' },
    }

    local modifiers = {
      { 'a', group = 'around' },
      { 'i', group = 'inside' },
      { 's', group = 'surrounding' },
    }

    local builtin = {
      { '0', desc = 'start of line' },
      { 'e', desc = 'next end of word' },
      { 'E', desc = 'next end of WORD' },
      { 'f', desc = 'to next char' },
      { 'F', desc = 'to prev char' },
      { 'G', desc = 'last line' },
      { 'h', desc = 'left' },
      { 'j', desc = 'down' },
      { 'k', desc = 'up' },
      { 'l', desc = 'right' },
      { 't', desc = 'before next char' },
      { 'T', desc = 'before prev char' },
      { 'w', desc = 'next word' },
      { 'W', desc = 'next WORD' },
      { '$', desc = 'end of line' },
      { '%', desc = 'matching (){}[]' },
      { ',', desc = 'prev ft/FT' },
      { ';', desc = 'next ft/FT' },
      { '/', desc = 'search fwd' },
      { '?', desc = 'search bwd' },
      { '{', desc = 'prev empty line' },
      { '}', desc = 'next empty line' },
      { '^', desc = 'soft start of line' },
      { 'gc', desc = 'comment textobject' },
      { 'ge', desc = 'prev end of word' },
      { 'gg', desc = 'first line' },
    }

    local textobjects = {
      { ' ', desc = 'whitespace' },
      { 'q', desc = 'quote `"\'' },
      { '"', desc = '" string' },
      { "'", desc = "' string" },
      { '`', desc = '` string' },
      { '(', desc = '() block' },
      { ')', desc = '() block with ws' },
      { '[', desc = '[] block' },
      { ']', desc = '[] block with ws' },
      { '{', desc = '{} block' },
      { '}', desc = '{} with ws' },
      { '<', desc = '<> block' },
      { '>', desc = '<> block with ws' },
      { 'b', desc = '{[( block' },
      { 'B', desc = ')]} block' },
      { '_', desc = 'underscore' },
      { 't', desc = 'tag' },
      { 'C', desc = 'class' },
      { 'f', desc = 'function call' },
      { 'F', desc = 'function definition' },
      { '?', desc = 'user prompt' },
      { 'o', desc = 'treesitter block' },
      { 'a', desc = 'argument' },
      { 'i', desc = 'indentation' },
    }

    local wk = require('which-key')
    for _, op in pairs(operators) do
      wk.add(op)
      for _, mod in pairs(modifiers) do
        local modname = op[1] .. mod[1]
        wk.add({ modname, group = mod.group })
        for _, obj in pairs(textobjects) do
          if mod[1] ~= 's' then
            wk.add({ op[1] .. mod[1] .. obj[1], desc = obj.desc })
          end
        end
        for _, bi in pairs(builtin) do
          local biname = op[1] .. bi[1]
          wk.add({ biname, desc = bi.desc })
        end
      end
    end

    wk.add({ '"', 'gs"', mode = { 'v' } })
    wk.add({ "'", "gs'", mode = { 'v' } })

    -- TODO: make consistent across program, e.g '(' -> no ws
    wk.add({ '(', 'gs)', mode = { 'v' } })
    wk.add({ '[', 'gs]', mode = { 'v' } })
    wk.add({ '{', 'gs}', mode = { 'v' } })
  end,
}
