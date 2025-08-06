return {
  'folke/todo-comments.nvim',
  event = { 'BufRead', 'BufNewFile' },
  opts = {
    -- signs = true
  },
  keys = {
    {
      '<leader>st',
      function()
        ---@diagnostic disable-next-line: undefined-field
        require('snacks').picker.todo_comments({ keywords = { 'TODO', 'BUG', 'FIX', 'FIXME' } })
      end,
      desc = 'todos',
    },
    {
      '<leader>sn',
      function()
        ---@diagnostic disable-next-line: undefined-field
        require('snacks').picker.todo_comments({ keywords = { 'NOTE' } })
      end,
      desc = 'notes',
    },
  },
}
