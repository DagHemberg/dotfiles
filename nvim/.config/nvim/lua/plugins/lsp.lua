return {
  -- ▄▄     ▄▄▄▄ ▄▄▄▄   ▄▄▄▄  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄ ▄▄  ▄▄▄▄
  -- ██    ███▄▄ ██▄█▀ ██▀▀▀ ██▀██ ███▄██ ██▄▄  ██ ██ ▄▄
  -- ██▄▄▄ ▄▄██▀ ██    ▀████ ▀███▀ ██ ▀██ ██    ██ ▀███▀
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    config = function()
      vim.lsp.config('*', {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      -- Lua
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            ['hint.arrayIndex'] = 'Disable',
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

      vim.lsp.config('tinymist', {
        settings = {
          formatterMode = 'typstyle',
        },
      })

      --

      vim.lsp.inlay_hint.enable(true)

      local set = Snacks.keymap.set
      local pick = Snacks.picker

      -- defaults
      set('n', '<leader>ld', pick.lsp_symbols)
      set('n', '<leader>r', ':IncRename ', { desc = 'rename' })
      set('n', '<Leader>gd', pick.lsp_definitions, { desc = 'Go to definition' })
      set('n', '<Leader>gD', pick.lsp_declarations, { desc = 'Go to declaration' })
      set('n', '<leader>gr', pick.lsp_references, { desc = 'Go to references' })
      set('n', '<leader>li', pick.lsp_implementations, { desc = 'View implentations' })
      set('n', '<leader>lw', pick.lsp_workspace_symbols, { desc = 'Open workspace symbols' })
      set('n', '<leader>lt', pick.lsp_type_definitions, { desc = 'Go to type definition' })
      set('n', '<leader>lc', vim.lsp.codelens.run, { desc = 'Run codelens' })
      -- TODO: Snacks.keymap.set('n', '<leader>a', require('tiny-code-action').code_action, desc = 'Perform code action', mode = { 'n', { 'x' } })

      -- tinymist
      local lsp_tm = { lsp = { name = 'tinymist' } }
      set('n', '<leader>pp', '<cmd>LspTinymistPinMain<CR>', lsp_tm)
    end,
  },

  -- ▄▄   ▄▄  ▄▄▄   ▄▄▄▄  ▄▄▄  ▄▄  ▄▄
  -- ██▀▄▀██ ██▀██ ███▄▄ ██▀██ ███▄██
  -- ██   ██ ██▀██ ▄▄██▀ ▀███▀ ██ ▀██
  {
    'mason-org/mason.nvim',
    opts = {},
    keys = {
      { '<leader>xm', '<cmd>Mason<cr>' },
    },
  },
  {
    -- auto-enable tools installed from mason
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { 'mason-org/mason.nvim' },
      { 'neovim/nvim-lspconfig' },
    },
    opts = {},
  },

  --  ▄▄▄▄  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄  ▄▄▄  ▄▄▄▄  ▄▄   ▄▄
  -- ██▀▀▀ ██▀██ ███▄██ ██▄▄  ██▀██ ██▄█▄ ██▀▄▀██
  -- ▀████ ▀███▀ ██ ▀██ ██    ▀███▀ ██ ██ ██   ██
  {
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
        typst = { lsp_format = 'prefer' },
      },
    },
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
        ['tinymist'] = 'tinymist',
      },
    },
    config = function(self, opts)
      require('typst-preview').setup(opts)
      Snacks.keymap.set('n', '<leader>P', '<cmd>TypstPreview<CR>')
    end,
  },

  -- ▄▄▄▄  ▄▄ ▄▄  ▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄   ▄▄▄▄ ▄▄▄▄▄  ▄▄▄  ▄▄  ▄▄ ▄▄ ▄▄ ▄▄ ▄▄   ▄▄
  -- ██▄█▄ ██ ██ ███▄▄   ██  ██▀██ ██▀▀▀ ██▄▄  ██▀██ ███▄██ ██▄██ ██ ██▀▄▀██
  -- ██ ██ ▀███▀ ▄▄██▀   ██  ██▀██ ▀████ ██▄▄▄ ██▀██ ██ ▀██  ▀█▀  ██ ██   ██
  {
    'mrcjkb/rustaceanvim',
    version = '^8',
    lazy = false,
    config = function()
      Snacks.keymap.set('n', 'K', function()
        vim.cmd.RustLsp({ 'hover', 'actions' })
      end, { silent = true, lsp = { name = 'rust-analyzer', method = 'textDocument/hover' } })
    end,
    -- TODO: Rust
  },

  -- ▄▄ ▄▄  ▄▄▄   ▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄▄ ▄▄    ▄▄   ▄▄▄▄▄▄ ▄▄▄   ▄▄▄  ▄▄     ▄▄▄▄
  -- ██▄██ ██▀██ ███▄▄ ██▄█▀ ██▄▄  ██    ██     ██  ██▀██ ██▀██ ██    ███▄▄
  -- ██ ██ ██▀██ ▄▄██▀ ██ ██ ██▄▄▄ ██▄▄▄ ██▄▄▄  ██  ▀███▀ ▀███▀ ██▄▄▄ ▄▄██▀
  {
    -- TODO: Haskell
    'mrcjkb/haskell-tools.nvim',
    version = '^7',
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
        callback = function()
          require('metals').initialize_or_attach(opts)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
