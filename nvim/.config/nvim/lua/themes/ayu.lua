return {
  'Shatur/neovim-ayu',
  priority = 1000,
  config = function()
    require('ayu').setup({
      overrides = {
        -- rust
        ['Delimiter'] = { fg = '#646B73' },
        ['@lsp.type.parameter'] = { fg = '#9dbbef' },
        ['@variable'] = { fg = '#9dbbef' },
        ['@property'] = { fg = '#9dbbef' },
        ['@lsp.typemod.variable.mutable.rust'] = { fg = '#9AC2A9' },
        ['@lsp.type.struct.rust'] = { fg = '#399be6' },
        ['Type'] = { fg = '#399be6' },
        ['@lsp.mod.constant.rust'] = { link = '@lsp' },
        ['@lsp.typemod.const.constant.rust'] = { fg = '#f07178' },
        ['@lsp.type.namespace.rust'] = { fg = '#59C2FF' },
        ['@lsp.type.selfTypeKeyword.rust'] = { link = 'Statement' },
      },
    })
  end,
}
