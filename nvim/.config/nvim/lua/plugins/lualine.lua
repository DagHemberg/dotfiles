return {
  -- ▄▄    ▄▄ ▄▄  ▄▄▄  ▄▄    ▄▄ ▄▄  ▄▄ ▄▄▄▄▄
  -- ██    ██ ██ ██▀██ ██    ██ ███▄██ ██▄▄
  -- ██▄▄▄ ▀███▀ ██▀██ ██▄▄▄ ██ ██ ▀██ ██▄▄▄

  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'bwpge/lualine-pretty-path',
  },
  config = function()
    local mode_map = {
      ['NORMAL'] = '',
      ['O-PENDING'] = '',
      ['INSERT'] = '',
      ['VISUAL'] = '󰈈',
      ['V-BLOCK'] = '󰩭',
      ['V-LINE'] = '󱪶',
      ['REPLACE'] = '󰼭',
      ['COMMAND'] = '',
      ['TERMINAL'] = '',
      ['SELECT'] = '',
    }

    local mason_updates = function()
      if not package.loaded['mason-registry'] then
        return ''
      end
      local registry = require('mason-registry')
      local installed_packages = registry.get_installed_package_names()
      local packages_outdated = 0

      for _, pkg_name in ipairs(installed_packages) do
        local pkg = registry.get_package(pkg_name)
        if pkg then
          local ok_installed, installed_version = pcall(pkg.get_installed_version, pkg)
          local ok_latest, latest_version = pcall(pkg.get_latest_version, pkg)
          if ok_installed and ok_latest and installed_version ~= latest_version then
            packages_outdated = packages_outdated + 1
          end
        end
      end

      return packages_outdated > 0 and tostring(packages_outdated) or ''
    end

    local opts = {
      options = {
        globalstatus = true,
        section_separators = { left = '▌', right = '▐' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        --  ▄▄▄
        -- ██▀██
        -- ██▀██

        lualine_a = {
          {
            'mode',
            fmt = function(s) return mode_map[s] or s end,
          },
        },

        -- ▄▄▄▄
        -- ██▄██
        -- ██▄█▀

        lualine_b = {
          {
            function() return vim.uv.cwd() end,
            fmt = function(s) return string.match(s, '([^/]+)$') end,
            cond = function() return vim.o.columns > 50 end,
          },
        },

        --  ▄▄▄▄
        -- ██▀▀▀
        -- ▀████

        lualine_c = {
          {
            function() return package.loaded['NeoComposer.ui'] and require('NeoComposer.ui').status_recording() or '' end,
          },
          { 'pretty_path', unnamed = '', directories = { enable = true, max_depth = 5 } },
          { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' } },
        },

        -- ▄▄ ▄▄
        -- ▀█▄█▀
        -- ██ ██

        lualine_x = {
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = 'MatchParen',
          },
          {
            mason_updates,
            icon = '󰢻',
            color = 'MatchParen',
          },
          {
            'diff',
            colored = true,
            symbols = { added = '󰐖 ', modified = '󰏬 ', removed = '󰍵 ' },
            cond = function() return vim.o.columns > 75 end,
          },
          {
            'overseer',
            unique = true,
          },
          {
            'lsp_status',
            symbols = {
              spinner = '',
              done = '',
            },
            cond = function() return vim.o.columns > 94 end,
          },
          {
            'overseer',
            unique = true,
          },
          {
            'lsp_status',
            symbols = {
              spinner = '',
              done = '',
            },
            show_name = false,
            cond = function() return vim.o.columns > 70 and vim.o.columns < 95 end,
          },
          { 'location', cond = function() return vim.o.columns > 55 end },
          { 'filetype', cond = function() return vim.o.columns > 65 end },
        },

        -- ▄▄ ▄▄
        -- ▀███▀
        --   █

        lualine_y = {
          {
            function() return '  ' .. require('dap').status() end,
            cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
            color = function() return { fg = require('snacks').util.color('Debug') } end,
          },
          {
            'branch',
            icon = { align = 'right' },
            cond = function() return vim.o.columns > 60 end,
          },
        },

        -- ▄▄▄▄▄
        --   ▄█▀
        -- ▄██▄▄

        lualine_z = {
          {
            'branch',
            icon = { align = 'right' },
            fmt = function(str) return string.len(str) ~= 0 and '' or '' end,
            cond = function() return vim.o.columns > 35 end,
          },
        },
      },
    }

    require('lualine').setup(opts)
  end,
}
