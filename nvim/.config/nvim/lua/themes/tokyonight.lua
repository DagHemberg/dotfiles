return {
  'folke/tokyonight.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    style = 'night',
    transparent = false,
    on_highlights = function(hl, c)
      -- hl.DiffAdd = { bg = '#3D4B39' }
      -- hl.DiffChange = { bg = '#685531' }
      -- hl.DiffDelete = { bg = '#712D2D' }

      hl.GitSignsAdd = { fg = '#1ABC9C' }
      hl.GitSignsChange = { fg = '#E0AF68' }
      hl.GitSignsDelete = { fg = '#DB4B4B' }

      hl.GitSignsStagedAdd = { fg = '#1ABC9C' }
      hl.GitSignsStagedChange = { fg = '#E0AF68' }
      hl.GitSignsStagedChangedelete = { fg = '#E0AF68' }
      hl.GitSignsStagedDelete = { fg = '#DB4B4B' }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
