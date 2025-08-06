return {
  'mason-org/mason-lspconfig.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>xm', '<cmd>Mason<cr>', desc = 'Open Mason' },
  },
  dependencies = {
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'WhoIsSethDaniel/mason-tool-installer'
  },
  config = function()
    local tools = {
      'tinymist',
      'lua-language-server',
      'stylua',
      'clangd',
      'rust-analyzer',
      'hlint',
      'hls',
      'java-test',
      'ts_ls',
      'svelte',
      'hyprls',
      'prettier',
      'dockerls',
      'docker-compose-language-service',
    }

    require('mason').setup()
    require('mason-tool-installer').setup({ ensure_installed = tools })
    require('mason-lspconfig').setup()
    require('mason-nvim-dap').setup()
  end,
}
