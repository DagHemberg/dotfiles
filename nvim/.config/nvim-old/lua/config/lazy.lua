local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  checker = {
    enabled = true,
    notify = false,
  },
  profiling = {
    loader = true,
    require = true,
  },
  spec = {
    { import = 'plugins.behaviour' },
    { import = 'plugins.looks' },
    { import = 'plugins.misc' },
    { import = 'plugins.lsp' },
    { import = 'themes' },
  },
})

require('which-key').add({
  { '<leader>xl', '<cmd>Lazy<CR>', desc = 'Open lazy' },
})
