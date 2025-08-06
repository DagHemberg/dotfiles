return {
  'lewis6991/gitsigns.nvim',
  lazy = false,
  -- stylua: ignore
  keys = {
    { ']h', function() require('gitsigns').nav_hunk('next') end, desc = 'next git hunk' },
    { ']H', function() require('gitsigns').nav_hunk('last') end, desc = 'last git hunk' },
    { '[h', function() require('gitsigns').nav_hunk('prev') end, desc = 'prev git hunk' },
    { '[H', function() require('gitsigns').nav_hunk('first') end, desc = 'first git hunk' },
    { '<leader>gab', function() require('gitsigns').stage_buffer() end, desc = 'git add buffer' },
    { '<leader>gah', function() require('gitsigns').stage_hunk() end, desc = 'git add hunk' }
  },
}
