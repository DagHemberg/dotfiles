return {
  -- ▄▄▄▄▄▄ ▄▄▄▄  ▄▄▄▄▄ ▄▄▄▄▄  ▄▄▄▄ ▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄
  --   ██   ██▄█▄ ██▄▄  ██▄▄  ███▄▄ ██   ██     ██   ██▄▄  ██▄█▄
  --   ██   ██ ██ ██▄▄▄ ██▄▄▄ ▄▄██▀ ██   ██     ██   ██▄▄▄ ██ ██
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        callback = function(event)
          -- make sure nvim-treesitter is loaded
          local nvim_treesitter = require('nvim-treesitter')
          local parsers = require('nvim-treesitter.parsers')
          if not parsers[event.match] or not nvim_treesitter.install then
            return
          end

          local ft = vim.bo[event.buf].ft
          local lang = vim.treesitter.language.get_lang(ft)
          nvim_treesitter.install({ lang }):await(function(err)
            if err then
              vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
              return
            end

            pcall(vim.treesitter.start, event.buf)
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          end)
        end,
      })
    end,
  },

  -- ▄▄▄▄▄▄ ▄▄▄▄  ▄▄▄▄▄ ▄▄▄▄▄  ▄▄▄▄   ▄▄
  --   ██   ██▄█▄ ██▄▄  ██▄▄  ███▄▄   ██
  --   ██   ██ ██ ██▄▄▄ ██▄▄▄ ▄▄██▀ ▄▄█▀
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      {
        'L',
        function()
          require('treesj').toggle({
            split = { recursive = false },
          })
        end,
        desc = 'Toggle line split',
        mode = { 'n', 'x' },
      },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 10000,
    },
  },
}
