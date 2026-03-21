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
      'ts_ls',
      'astro',
      'basedpyright',
      'bashls',
      'clangd',
      'codelldb',
      'docker_compose_language_service',
      'dockerls',
      'glsl_analyzer',
      'hls',
      'hlint',
      'hyprls',
      'java-test',
      'jdtls',
      'jqls',
      'lua_ls',
      'markdownlint',
      'marksman',
      'qmlls',
      'stylua',
      'svelte',
      'tinymist',
    }

    require('mason').setup()
    require('mason-tool-installer').setup({ ensure_installed = tools })
    require('mason-lspconfig').setup()
    require('mason-nvim-dap').setup()
  end,
}
