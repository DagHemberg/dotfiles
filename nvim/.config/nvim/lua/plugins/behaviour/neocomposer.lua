return {
  'ecthelionvi/NeoComposer.nvim',
  dependencies = { 'kkharji/sqlite.lua' },
  opts = {
    queue_most_recent = true,
    keymaps = {
      toggle_record = 'qq',
      cycle_next = ']Q',
      cycle_prev = '[Q',
      toggle_macro_menu = '<C-q>',
    },
  },
}
