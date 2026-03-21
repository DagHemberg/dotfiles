return {
  'gregorias/toggle.nvim',
  opts = {
    keymaps = {
      toggle_option_prefix = '¡t',
      status_dashboard = '<leader>xs',
    },
  },
  config = function(_, opts)
    local toggle = require('toggle')
    toggle.register(
      'W',
      toggle.option.NotifyOnSetOption(toggle.option.OnOffOption({
        name = 'which-key',
        get_state = function()
          return vim.g.wk_enabled
        end,
        set_state = function(new_value)
          vim.g.wk_enabled = new_value
        end,
      }))
    )
    toggle.register(
      'w',
      toggle.option.NotifyOnSetOption(toggle.option.OnOffOption({
        name = 'wrap',
        get_state = function()
          return vim.o.wrap
        end,
        set_state = function(new_value)
          vim.o.wrap = new_value
          local wk = require('which-key')
          if new_value then
            wk.add({
              mode = { 'n', 'v' },
              { 'j', 'gj' },
              { 'k', 'gk' },
              { '0', 'g0' },
              { '$', 'g$' },
            })
          else
            -- "unset" mapping
            -- probably not how you do this
            wk.add({
              mode = { 'n', 'v' },
              { 'j', 'j' },
              { 'k', 'k' },
              { '0', '0' },
              { '$', '$' },
            })
          end
        end
      }))
    )
    toggle.setup(opts)
  end,
}
