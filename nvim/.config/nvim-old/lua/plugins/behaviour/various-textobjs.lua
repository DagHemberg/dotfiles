return {
  'chrisgrieser/nvim-various-textobjs',
  lazy = true,
  opts = {
    keymaps = {
      useDefaults = false,
    },
  },
  keys = {
    { 'ii', "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>", mode = { 'o', 'x' } },
    { 'ai', "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>", mode = { 'o', 'x' } },
    { 'B', "<cmd>lua require('various-textobjs').entireBuffer()<CR>", mode = { 'o', 'x' } },
    -- TODO: key-value?
    -- "outer `key` and `value` should not include extra space at `=` sign"
  },
}
