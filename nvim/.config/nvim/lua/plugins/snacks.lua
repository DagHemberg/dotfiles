return {
  --  ▄▄▄▄ ▄▄  ▄▄  ▄▄▄   ▄▄▄▄ ▄▄ ▄▄  ▄▄▄▄
  -- ███▄▄ ███▄██ ██▀██ ██▀▀▀ ██▄█▀ ███▄▄
  -- ▄▄██▀ ██ ▀██ ██▀██ ▀████ ██ ██ ▄▄██▀

  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,

  -- ▄▄ ▄▄ ▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄  ▄▄ ▄▄  ▄▄ ▄▄▄▄   ▄▄▄▄
  -- ██▄█▀ ██▄▄  ▀███▀ ██▄██ ██ ███▄██ ██▀██ ███▄▄
  -- ██ ██ ██▄▄▄   █   ██▄█▀ ██ ██ ▀██ ████▀ ▄▄██▀

  keys = {

    -- Pickers
    -- stylua: ignore start
    { '<leader><space>', function() Snacks.picker.smart({ title = 'Search' }) end, desc = 'Search files' },
    { '<leader>h', function() Snacks.picker.help() end, desc = 'help' },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = 'builtin pickers' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'keymaps' },
    { '<leader>su', function() Snacks.picker.undo() end, desc = 'undo tree' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'grep' },
    { '<leader>sg', function() Snacks.picker.grep_word({ live = true }) end, mode = { 'v' } },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = 'resume previous' },
    { '<leader>sf', function() Snacks.picker.files() end, desc = 'files' },
    { '<leader>sc', function() Snacks.picker.lazy() end, desc = 'lazy packages' },
    { '<leader>sC', function() Snacks.picker.files({ cwd = '~/.config/nvim/', title = 'Neovim config files' }) end, desc = 'nvim config files' },
    { '<leader>sd', function() Snacks.picker.files({ cwd = '~/.dots/', title = '.dotfiles', hidden = true }) end, desc = 'dotfiles' },
    { '<leader>si', function() Snacks.picker.icons() end, desc = 'icons' },
    {
      '<leader>sp',
      function()
        Snacks.picker.projects({
          projects = require('util.projects').projects(),
          recent = false,
          dev = { '/var/empty' },
          confirm = function(_, item) require('util.projects').open(item.file) end,
        })
      end,
      desc = 'projects',
    },
    -- stylua: ignore end

    -- Explorer
    {
      '<leader>e',
      function()
        local overseer_window = package.loaded['overseer.window']
        if overseer_window and overseer_window.is_open() then overseer_window.close() end
        Snacks.explorer()
      end,
      desc = 'Toggle explorer',
    },

    -- LazyGit
    { '<leader>lg', function() Snacks.lazygit.open() end, desc = 'Open LazyGit' },

    -- Term
    { '<C-ö>', function() Snacks.terminal.toggle() end, desc = 'Toggle terminal', mode = { 'n', 't' } },
    -- { '<Esc>', '<C-\\><C-n>', mode = { 't' } }

    -- Words
    { ']ä', function() Snacks.words.jump(vim.v.count1, true) end, mode = { 'n', 't' } },
    { '[ö', function() Snacks.words.jump(-vim.v.count1, true) end, mode = { 'n', 't' } },

    -- Gitbrowse
    { '<leader>gg', function() Snacks.gitbrowse.open({ what = 'repo' }) end, desc = 'Open remote repo' },
  },

  config = function(_, opts)
    require('snacks').setup(opts)

    -- toggle binds have are set with :map('keybind') instead of
    -- Snacks.keymap.set so i have to put them here :(
    local inlay_hints = {
      name = 'inlay hints',
      get = vim.lsp.inlay_hint.is_enabled,
      set = vim.lsp.inlay_hint.enable,
    }

    -- local deleted_diff = {
    --   name = 'deleted diff',
    --   get = ,
    --   set = require('gitsigns').preview_hunk_inline(),
    -- }

    Snacks.toggle.option('wrap'):map('<leader>tw')
    Snacks.toggle.new(inlay_hints):map('<leader>th')
  end,

  ---@type snacks.Config
  opts = {
    -- ▄▄▄▄  ▄▄  ▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄▄ ▄▄▄▄
    -- ██▄█▀ ██ ██▀▀▀ ██▄█▀ ██▄▄  ██▄█▄
    -- ██    ██ ▀████ ██ ██ ██▄▄▄ ██ ██

    explorer = { replace_netrw = true },
    picker = {
      ui_select = true,
      icons = {
        diagnostics = { Hint = '󰌵 ' },
        -- ui = { selected = ' ' },
      },
      sources = {
        lsp_workspace_symbols = {
          live = false,
        },
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { '.git', '.session.vim', '.DS_Store' },
          layout = {
            layout = {
              position = 'left',
              width = 40,
              min_width = 40,
              height = 0,
              border = 'none',
              box = 'vertical',
              { win = 'list', title = '{title}' },
              { win = 'preview', height = 0.4, border = 'top' },
              { win = 'input', height = 2, border = 'top' },
            },
          },
        },
      },
    },

    -- ▄▄▄▄   ▄▄▄   ▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄   ▄▄▄   ▄▄▄  ▄▄▄▄  ▄▄▄▄
    -- ██▀██ ██▀██ ███▄▄ ██▄██ ██▄██ ██▀██ ██▀██ ██▄█▄ ██▀██
    -- ████▀ ██▀██ ▄▄██▀ ██ ██ ██▄█▀ ▀███▀ ██▀██ ██ ██ ████▀

    dashboard = {
      preset = {
        header = [[
              ▀▀
████▄ ▄█▀█▄ ▄███▄ ██ ██ ██ ███▄███▄ 
██ ██ ██▄█▀ ██ ██ ██▄██ ██ ██ ██ ██ 
██ ██ ▀█▄▄▄ ▀███▀  ▀█▀  ██ ██ ██ ██ ]],
        keys = {
          { icon = ' ', key = 'n', desc = 'New file', action = ':ene | startinsert' },
          { key = 'i', action = ':ene | startinsert', hidden = true },
          { key = 'a', action = ':ene | startinsert', hidden = true },
          {
            icon = ' ',
            key = 'p',
            desc = 'Projects',
            action = function()
              Snacks.picker.projects({
                projects = require('util.projects').projects(),
                recent = false,
                dev = { '/var/empty' },
                confirm = function(_, item) require('util.projects').open(item.file) end,
              })
            end,
          },
          { icon = ' ', key = 'f', desc = 'Files', action = function() Snacks.picker.recent() end },
          -- { icon = ' ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          -- { icon = ' ', key = 'M', desc = 'Mason', action = ':Mason' },
          -- { icon = ' ', key = 'lg', desc = 'Git', action = '<leader>lg' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':q' },
        },
      },
      sections = {
        { section = 'header', padding = 2 },
        function()
          local projects = require('util.projects')
          local target = projects.target()
          if not target then return end

          local same = 'Restore session'
          local diff = 'Reopen latest project (' .. string.match(target, '([^/]+)$') .. ')'
          local desc = projects.cwd() == target and same or diff
          return {
            icon = ' ',
            desc = desc,
            action = function() projects.open(target) end,
            padding = 2,
            key = 'r',
          }
        end,
        { section = 'keys', padding = 2, gap = 1 },
        {
          section = 'projects',
          icon = ' ',
          title = 'Recent projects',
          padding = 1,
          limit = 10,
          dirs = function() return require('util.projects').projects() end,
          ---@diagnostic disable-next-line: param-type-mismatch
          action = function(dir) require('util.projects').open(dir) end,
          indent = 1,
        },
        { section = 'startup', padding = 1 },
      },
    },

    -- ▄▄ ▄▄  ▄▄ ▄▄▄▄  ▄▄ ▄▄ ▄▄▄▄▄▄
    -- ██ ███▄██ ██▄█▀ ██ ██   ██
    -- ██ ██ ▀██ ██    ▀███▀   ██

    input = {
      relative = 'cursor',
      row = -3,
      col = 0,
    },

    -- ▄▄ ▄▄   ▄▄  ▄▄▄   ▄▄▄▄ ▄▄▄▄▄
    -- ██ ██▀▄▀██ ██▀██ ██ ▄▄ ██▄▄
    -- ██ ██   ██ ██▀██ ▀███▀ ██▄▄▄

    image = {
      doc = { enabled = false },
      math = { enabled = false },
    },

    --  ▄▄▄▄ ▄▄▄▄▄▄ ▄▄ ▄▄ ▄▄    ▄▄▄▄▄  ▄▄▄▄
    -- ███▄▄   ██   ▀███▀ ██    ██▄▄  ███▄▄
    -- ▄▄██▀   ██     █   ██▄▄▄ ██▄▄▄ ▄▄██▀

    styles = {
      terminal = {
        keys = {
          term_normal = {
            '<esc>',
            function() vim.cmd('stopinsert') end,
            mode = 't',
            expr = true,
          },
        },
      },
      lazygit = {
        keys = { term_normal = false },
      },
    },

    -- ▄▄   ▄▄ ▄▄  ▄▄▄▄  ▄▄▄▄
    -- ██▀▄▀██ ██ ███▄▄ ██▀▀▀
    -- ██   ██ ██ ▄▄██▀ ▀████

    lazygit = {},
    statuscolumn = {},
    keymap = {},
    term = {},
    toggle = {},
    words = { debounce = 0 },
  },
}
