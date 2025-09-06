return {
  'nvim-lualine/lualine.nvim',
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
      ['V-BLOCK'] = '󱗽',
      ['V-LINE'] = '',
      ['REPLACE'] = '󰼭',
      ['COMMAND'] = '',
      ['TERMINAL'] = '',
      ['SELECT'] = '',
    }

    local trouble = require('trouble')
    local symbols = trouble.statusline({
      mode = 'lsp_document_symbols',
      groups = {},
      title = false,
      filter = { range = false },
      format = '{kind_icon}{symbol.name:Normal}',
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = 'lualine_c_normal',
    })

    local mason_updates = function()
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
        -- theme = 'ayu',
        -- section_separators = { left = '▌', right = '▐' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(s)
              return mode_map[s] or s
            end,
          },
        },
        lualine_b = {
          {
            function()
              return vim.uv.cwd()
            end,
            fmt = function(s)
              return string.match(s, '([^/]+)$')
            end,
          },
        },
        lualine_c = {
          { require('NeoComposer.ui').status_recording },
          { 'pretty_path', unnamed = '', directories = { enable = true, max_depth = 5 } },
          { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' } },
          { symbols.get, cond = symbols.has },
        },
        lualine_x = {
          -- { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
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
          },
          {
            'lsp_status',
            -- icon = '󰒍',
            -- icon = ' ',
            -- icon = '',
            symbols = {
              spinner = '',
              done = '',
            },
          },
          { 'location' },
          { 'filetype' },
        },
        lualine_y = {
          -- stylua: ignore
          {
            function() return '  ' .. require('dap').status() end,
            cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
            color = function() return { fg = require('snacks').util.color('Debug') } end,
          },
          {
            'branch',
            icon = { align = 'right' }
          }
        },
        lualine_z = {
          {
            'branch',
            icon = { align = 'right' },
            fmt = function (str)
              return string.len(str) ~= 0 and '' or ''
            end,
          },
        },
      },
    }

    require('lualine').setup(opts)
  end,
}
