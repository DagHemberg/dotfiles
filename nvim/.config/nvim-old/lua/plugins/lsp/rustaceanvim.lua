return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  lazy = false,
  config = function ()
    -- vim.api.nvim_add_autocmd('FileType', {
    --   desc = 'Rustaceanvim keybinds',
    --   group = vim.api.nvim_create_augroup('rustaceanvim-keybinds', { clear = true }),
    --   callback = function ()
    --
    --   end
    -- })
  end
}
