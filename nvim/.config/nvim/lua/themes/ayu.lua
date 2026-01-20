return {
  'Shatur/neovim-ayu',
  priority = 1000,
  config = function()
    require('ayu').setup({
      overrides = {
        -- rust
        ['Delimiter'] = { fg = '#646B73' },
        ['Type'] = { fg = '#399be6' },
        ['MatchParen'] = { fg = "#FF8F40", bold = true, underline = false },
        ['@lsp.type.parameter'] = { fg = '#9dbbef' },
        ['@character.rust'] = { link = 'String' },
        ['@variable'] = { fg = '#9dbbef' },
        ['@property'] = { fg = '#9dbbef' },
        ['@lsp.typemod.variable.mutable.rust'] = { fg = '#9AC2A9' },
        ['@lsp.type.struct.rust'] = { link = 'Type' },
        ['@lsp.type.builtinType.rust'] = { link = 'Type' },
        ['@lsp.mod.constant.rust'] = { link = '@lsp' },
        ['@lsp.typemod.const.constant.rust'] = { fg = '#f07178' },
        ['@lsp.type.namespace.rust'] = { fg = '#59C2FF' },
        ['@lsp.type.selfTypeKeyword.rust'] = { link = 'Statement' },
        ['@lsp.type.selfKeyword.rust'] = { link = 'Statement' },
      },
    })
  end,
}
