return {
  'mason-org/mason-lspconfig.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>xm', '<cmd>Mason<cr>', desc = 'Open Mason' },
  },
  dependencies = {
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'WhoIsSethDaniel/mason-tool-installer',
  },
  config = function()
    local tools = {
      'basedpyright',
      'bashls',
      'clangd',
      'codelldb',
      'docker_compose_language_service',
      'dockerls',
      'hls',
      'hlint',
      'hyprls',
      'java-test',
      'lua_ls',
      'markdownlint',
      'marksman',
      'ruff',
      'stylua',
      'svelte',
      'tinymist',
      'ts_ls',
      'jdtls',
    }

    require('mason').setup()
    require('mason-tool-installer').setup({ ensure_installed = tools })
    require('mason-lspconfig').setup()
    require('mason-nvim-dap').setup()
  end,
}
