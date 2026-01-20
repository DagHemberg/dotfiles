-- Must be done first!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap('n', 'ä', ']', { noremap = false })
vim.api.nvim_set_keymap('n', 'ö', '[', { noremap = false })
vim.api.nvim_set_keymap('o', 'ä', ']', { noremap = false })
vim.api.nvim_set_keymap('o', 'ö', '[', { noremap = false })

require('config.lazy')
require('config.autocmds')
require('config.usercmds')
require('config.diagnostic')
require('config.options')

vim.cmd.colorscheme('tokyonight')
-- vim.cmd.colorscheme('ayu')

-- TODO:
--  [x] snacks.picker
--    [x] (and figure out todo list)
--  [x] a few new textobjs
--  [x] dap
--    [x] like actually figure it out
--  [x] lualine
--    [x] fix lualine not covering confirmation
--  [x] minor blink config (border mostly, maybe keybinds)
--    [x] autocomplete in commandline same as blink
--  [x] investigate mason autoinstall (again)
--  [x] insert mode keymaps?
--  [x] file organization
--  [x] tiny-code-action
--  [-] colorscheme customization
--    [ ] autocmd for switching on filetype
--  [ ] ctrl+space -> hover, goto def -> K
--  [ ] more leader keys
--  [ ] proper lazyloading?

-- vim: ts=2 sts=2 sw=2 et
