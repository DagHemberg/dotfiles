return {
  -- ▄▄     ▄▄▄▄ ▄▄▄▄   ▄▄▄▄  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄ ▄▄  ▄▄▄▄
  -- ██    ███▄▄ ██▄█▀ ██▀▀▀ ██▀██ ███▄██ ██▄▄  ██ ██ ▄▄
  -- ██▄▄▄ ▄▄██▀ ██    ▀████ ▀███▀ ██ ▀██ ██    ██ ▀███▀
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    config = function()
      -- vim.lsp.log.set_level('trace')
      -- vim.lsp.log.set_format_func(vim.inspect)

      vim.lsp.config('*', {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      -- Lua
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            hint = { arrayIndex = 'Disable' },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                vim.fn.stdpath('data') .. '/lazy/snacks.nvim',
              },
            },
          },
        },
      })

      -- Typst
      vim.lsp.config('tinymist', {
        settings = {
          formatterMode = 'typstyle',
          lint = { enabled = true, when = 'onType' },
        },
      })

      -- JSON
      vim.lsp.config('jsonls', {
        settings = {
          json = {
            validate = { enable = true, comments = 'warning' },
            format = { enable = true },
          },
        },
      })

      -- Python
      vim.lsp.config('pylsp', {
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = { ignore = { 'E501' } },
            },
          },
        },
      })

      vim.lsp.inlay_hint.enable(true)

      local set = Snacks.keymap.set
      local pick = Snacks.picker

      -- defaults
      set('n', '<leader>r', ':IncRename ', { desc = 'rename' })
      set('n', '<Leader>gd', pick.lsp_definitions, { desc = 'Go to definition' })
      set('n', '<Leader>gD', pick.lsp_declarations, { desc = 'Go to declaration' })
      set('n', '<leader>gr', pick.lsp_references, { desc = 'Go to references' })
      set('n', '<leader>gt', pick.lsp_type_definitions, { desc = 'Go to type definition' })
      set('n', '<leader>gi', pick.lsp_implementations, { desc = 'Go to implementations' })
      set('n', '<leader>lw', pick.lsp_workspace_symbols, { desc = 'Open workspace symbols' })
      set('n', '<leader>lW', pick.lsp_symbols, { desc = 'Open symbols' })
      set('n', '<leader>lC', pick.lsp_config, { desc = 'Open symbols' })
      set('n', '<leader>lc', vim.lsp.codelens.run, { desc = 'Run codelens' })

      -- tinymist
      local lsp_tm = { lsp = { name = 'tinymist' } }
      set('n', '<leader>pp', '<cmd>LspTinymistPinMain<CR>', lsp_tm)
    end,
  },

  -- ▄▄   ▄▄  ▄▄▄   ▄▄▄▄  ▄▄▄  ▄▄  ▄▄
  -- ██▀▄▀██ ██▀██ ███▄▄ ██▀██ ███▄██
  -- ██   ██ ██▀██ ▄▄██▀ ▀███▀ ██ ▀██
  {
    {
      'mason-org/mason.nvim',
      opts = {},
      keys = {
        { '<leader>M', '<cmd>Mason<cr>' },
      },
    },
    {
      -- auto-enable tools installed from mason
      'mason-org/mason-lspconfig.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = {
        { 'mason-org/mason.nvim' },
        { 'neovim/nvim-lspconfig' },
      },
      opts = {},
    },
    {
      'zapling/mason-lock.nvim',
      opts = {},
      dependencies = {
        'mason-org/mason.nvim',
      },
    },
  },

  --  ▄▄▄▄  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄  ▄▄▄  ▄▄▄▄  ▄▄   ▄▄
  -- ██▀▀▀ ██▀██ ███▄██ ██▄▄  ██▀██ ██▄█▄ ██▀▄▀██
  -- ▀████ ▀███▀ ██ ▀██ ██    ▀███▀ ██ ██ ██   ██
  {
    'stevearc/conform.nvim',
    keys = {
      {
        '<leader>F',
        function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
        desc = 'Format buffer',
      },
    },
    opts = {
      format_on_save = { lsp_format = 'fallback' },
      formatters_by_ft = {
        lua = { 'stylua' },
        typst = { lsp_format = 'prefer' },
        java = { 'google-java-format' },
        typescriptreact = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
        json = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
        jsonc = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },

  -- ▄▄ ▄▄  ▄▄  ▄▄▄▄     ▄▄▄▄  ▄▄▄▄▄ ▄▄  ▄▄  ▄▄▄  ▄▄   ▄▄ ▄▄▄▄▄
  -- ██ ███▄██ ██▀▀▀ ▄▄▄ ██▄█▄ ██▄▄  ███▄██ ██▀██ ██▀▄▀██ ██▄▄
  -- ██ ██ ▀██ ▀████     ██ ██ ██▄▄▄ ██ ▀██ ██▀██ ██   ██ ██▄▄▄
  {
    'smjonas/inc-rename.nvim',
    event = 'BufRead',
    opts = {},
  },

  -- ▄▄▄▄▄▄ ▄▄ ▄▄  ▄▄ ▄▄ ▄▄      ▄▄▄▄  ▄▄▄  ▄▄▄▄  ▄▄▄▄▄      ▄▄▄   ▄▄▄▄ ▄▄▄▄▄▄ ▄▄  ▄▄▄  ▄▄  ▄▄
  --   ██   ██ ███▄██ ▀███▀ ▄▄▄ ██▀▀▀ ██▀██ ██▀██ ██▄▄  ▄▄▄ ██▀██ ██▀▀▀   ██   ██ ██▀██ ███▄██
  --   ██   ██ ██ ▀██   █       ▀████ ▀███▀ ████▀ ██▄▄▄     ██▀██ ▀████   ██   ██ ▀███▀ ██ ▀██
  {
    'rachartier/tiny-code-action.nvim',
    event = 'LspAttach',
    keys = {
      {
        '<leader>a',
        function() require('tiny-code-action').code_action({}) end,
        noremap = true,
        silent = true,
      },
    },
    opts = { picker = { 'buffer' } },
  },

  -- ============================[Language-specific plugins]==============================

  -- ▄▄     ▄▄▄  ▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄  ▄▄▄▄▄ ▄▄ ▄▄
  -- ██    ██▀██   ▄█▀ ▀███▀ ██▀██ ██▄▄  ██▄██
  -- ██▄▄▄ ██▀██ ▄██▄▄   █   ████▀ ██▄▄▄  ▀█▀
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },

  -- ▄▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄   ▄▄▄▄ ▄▄▄▄▄▄    ▄▄▄▄  ▄▄▄▄  ▄▄▄▄▄ ▄▄ ▄▄ ▄▄ ▄▄▄▄▄ ▄▄   ▄▄
  --   ██   ▀███▀ ██▄█▀ ███▄▄   ██  ▄▄▄ ██▄█▀ ██▄█▄ ██▄▄  ██▄██ ██ ██▄▄  ██ ▄ ██
  --   ██     █   ██    ▄▄██▀   ██      ██    ██ ██ ██▄▄▄  ▀█▀  ██ ██▄▄▄  ▀█▀█▀
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {
      dependencies_bin = {
        tinymist = '/home/dag/.local/share/nvim/mason/bin/tinymist',
      },
    },
    config = function(this, opts)
      require('typst-preview').setup(opts)
      Snacks.keymap.set('n', '<leader>P', '<cmd>TypstPreview<CR>', { ft = this.ft })
    end,
  },

  -- ▄▄   ▄▄ ▄▄▄▄      ▄▄▄▄  ▄▄▄▄  ▄▄▄▄▄ ▄▄ ▄▄ ▄▄ ▄▄▄▄▄ ▄▄   ▄▄
  -- ██▀▄▀██ ██▀██ ▄▄▄ ██▄█▀ ██▄█▄ ██▄▄  ██▄██ ██ ██▄▄  ██ ▄ ██
  -- ██   ██ ████▀     ██    ██ ██ ██▄▄▄  ▀█▀  ██ ██▄▄▄  ▀█▀█▀
  {
    'selimacerbas/markdown-preview.nvim',
    dependencies = { 'selimacerbas/live-server.nvim' },
    ft = { 'markdown', 'mmd', 'mermaid' },
    opts = {
      instance_mode = 'multi',
    },
    config = function(this, opts)
      require('markdown_preview').setup(opts)
      Snacks.keymap.set('n', '<leader>P', '<cmd>MarkdownPreview<CR>', { ft = this.ft })
    end,
  },

  -- ▄▄▄▄  ▄▄ ▄▄  ▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄   ▄▄▄▄ ▄▄▄▄▄  ▄▄▄  ▄▄  ▄▄ ▄▄ ▄▄ ▄▄ ▄▄   ▄▄
  -- ██▄█▄ ██ ██ ███▄▄   ██  ██▀██ ██▀▀▀ ██▄▄  ██▀██ ███▄██ ██▄██ ██ ██▀▄▀██
  -- ██ ██ ▀███▀ ▄▄██▀   ██  ██▀██ ▀████ ██▄▄▄ ██▀██ ██ ▀██  ▀█▀  ██ ██   ██
  {
    'mrcjkb/rustaceanvim',
    version = '*',
    lazy = false,
    config = function()
      -- Snacks.keymap.set(
      --   'n',
      --   'K',
      --   function() vim.cmd.RustLsp({ 'hover', 'actions' }) end,
      --   { silent = true, lsp = { name = 'rust-analyzer', method = 'textDocument/hover' } }
      -- )
    end,
  },

  -- ▄▄ ▄▄  ▄▄▄   ▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄▄ ▄▄    ▄▄   ▄▄▄▄▄▄ ▄▄▄   ▄▄▄  ▄▄     ▄▄▄▄
  -- ██▄██ ██▀██ ███▄▄ ██▄█▀ ██▄▄  ██    ██     ██  ██▀██ ██▀██ ██    ███▄▄
  -- ██ ██ ██▀██ ▄▄██▀ ██ ██ ██▄▄▄ ██▄▄▄ ██▄▄▄  ██  ▀███▀ ▀███▀ ██▄▄▄ ▄▄██▀
  {
    'mrcjkb/haskell-tools.nvim',
    version = '*',
    lazy = false,
    config = function()
      local ht = require('haskell-tools')
      Snacks.keymap.set(
        'n',
        '<leader>E',
        ht.lsp.buf_eval_all,
        { noremap = true, silent = true, lsp = { name = 'hls' } }
      )
    end,
  },

  -- ▄▄   ▄▄ ▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄  ▄▄     ▄▄▄▄
  -- ██▀▄▀██ ██▄▄    ██  ██▀██ ██    ███▄▄
  -- ██   ██ ██▄▄▄   ██  ██▀██ ██▄▄▄ ▄▄██▀
  {
    'scalameta/nvim-metals',
    ft = { 'scala', 'sbt' },
    opts = function()
      local conf = require('metals').bare_config()
      conf.on_attach = function()
        -- TODO: add stuff here
      end
      return conf
    end,
    config = function(self, opts)
      local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = self.ft,
        callback = function() require('metals').initialize_or_attach(opts) end,
        group = nvim_metals_group,
      })
    end,
  },
}
