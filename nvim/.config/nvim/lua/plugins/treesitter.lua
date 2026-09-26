return {
  -- ▄▄▄▄▄▄ ▄▄▄▄  ▄▄▄▄▄ ▄▄▄▄▄  ▄▄▄▄ ▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄
  --   ██   ██▄█▄ ██▄▄  ██▄▄  ███▄▄ ██   ██     ██   ██▄▄  ██▄█▄
  --   ██   ██ ██ ██▄▄▄ ██▄▄▄ ▄▄██▀ ██   ██     ██   ██▄▄▄ ██ ██
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'VeryLazy', 'BufReadPre', 'BufNewFile' }, -- buf events required for custom parsers
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      local custom_grammars = {
        cypher = {
          tier = 2,
          install_info = {
            url = 'https://github.com/taekwombo/tree-sitter-cypher',
            revision = '8f156a9ef57843a4f37650b9237de09364e5a5ff',
            queries = 'queries',
          },
        },
        jastadd_ast = {
          tier = 2,
          extensions = { 'ast' },
          install_info = {
            url = 'https://github.com/daghemberg/tree-sitter-jastadd',
            location = 'ast',
            queries = 'ast/queries',
          },
        },
        jastadd = {
          tier = 2,
          extensions = { 'jrag', 'jadd' },
          install_info = {
            url = 'https://github.com/daghemberg/tree-sitter-jastadd',
            location = 'jastadd',
            queries = 'jastadd/queries',
          },
        },
      }

      -- add custom parsers
      local function inject_parsers()
        local parsers = require('nvim-treesitter.parsers')
        for lang, spec in pairs(custom_grammars) do
          parsers[lang] = spec
          vim.treesitter.language.register(lang, lang)
          for _, ext in ipairs(spec.extensions or {}) do
            vim.filetype.add({ extension = { [ext] = lang } })
          end
        end
      end

      inject_parsers()
      vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate', callback = inject_parsers })

      -- sane formatoptions defaults for custom grammars
      vim.api.nvim_create_autocmd('FileType', {
        pattern = vim.tbl_keys(custom_grammars),
        callback = function()
          vim.opt_local.formatoptions:remove('t')
          vim.opt_local.formatoptions:append('croql')
        end,
      })

      -- auto-install languages based on filetype
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(event)
          -- make sure nvim-treesitter is loaded
          local treesitter = require('nvim-treesitter')
          local parsers = require('nvim-treesitter.parsers')
          local ft = vim.bo[event.buf].ft
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang or not parsers[lang] or not treesitter.install then return end

          treesitter.install({ lang }):await(function(err)
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
        function() require('treesj').toggle({ split = { recursive = false } }) end,
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
