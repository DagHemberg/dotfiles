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
    toggle.setup(opts)
  end,
}
