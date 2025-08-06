return {
  'stevearc/conform.nvim',
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end,
      desc = 'Format buffer',
    },
  },
  opts = {
    format_on_save = { lsp_format = 'fallback' },
    formatters_by_ft = {
      lua = { 'stylua' },
    },
  },
}
