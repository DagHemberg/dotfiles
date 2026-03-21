return {
  'jake-stewart/multicursor.nvim',
  config = function()
    local mc = require('multicursor-nvim')
    mc.setup()
    -- require('which-key').add({
    --   { '<up>', function() mc.lineAddCursor(-1) end, mode = { 'n', 'x' }, desc = 'Add cursor up' },
    --   { '<down>', function() mc.lineAddCursor(1) end, mode = { 'n', 'x' }, desc = 'Add cursor down' },
    -- })
  end,
}
