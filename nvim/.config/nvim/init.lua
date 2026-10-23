-- Font: ANSI compact @ https://patorjk.com/software/taag/

-- ▄▄ ▄▄  ▄▄ ▄▄ ▄▄▄▄▄▄
-- ██ ███▄██ ██   ██
-- ██ ██ ▀██ ██   ██

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'x', 'o' }, 'ö', '[', { remap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'ä', ']', { remap = true })

-- typo-resistant write/quit
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Q', 'q', {})

-- ▄▄     ▄▄▄  ▄▄▄▄▄ ▄▄ ▄▄
-- ██    ██▀██   ▄█▀ ▀███▀
-- ██▄▄▄ ██▀██ ▄██▄▄   █

vim.pack.add({ 'https://github.com/folke/lazy.nvim' })

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
    { import = 'plugins' },
    { import = 'themes' },
  },
})

--  ▄▄▄  ▄▄▄▄ ▄▄▄▄▄▄ ▄▄  ▄▄▄  ▄▄  ▄▄  ▄▄▄▄
-- ██▀██ ██▄█▀  ██   ██ ██▀██ ███▄██ ███▄▄
-- ▀███▀ ██     ██   ██ ▀███▀ ██ ▀██ ▄▄██▀

vim.cmd('language en_US.UTF-8')

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.wrap = false
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- Enable per-directory config
vim.o.exrc = true

-- ...and re-run it on :cd, since built-in 'exrc' only fires once at startup.
require('util.exrc')

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Disable keymap timeouts
vim.opt.timeout = false

-- Tabs -> 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.fillchars = { eob = ' ' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'nosplit'

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Raise a dialog asking if you wish to save changes before quitting
vim.opt.confirm = true

-- Only show certain elements if cursor is on the same line
vim.opt.conceallevel = 2

-- Don't break in the middle of words
vim.opt.linebreak = true

-- Enable nerd font icons (use if installed)
vim.g.have_nerd_font = true

vim.cmd.colorscheme('tokyonight')

-- ▄▄▄▄  ▄▄  ▄▄▄   ▄▄▄▄ ▄▄  ▄▄  ▄▄▄   ▄▄▄▄ ▄▄▄▄▄▄ ▄▄  ▄▄▄▄  ▄▄▄▄
-- ██▀██ ██ ██▀██ ██ ▄▄ ███▄██ ██▀██ ███▄▄   ██   ██ ██▀▀▀ ███▄▄
-- ████▀ ██ ██▀██ ▀███▀ ██ ▀██ ▀███▀ ▄▄██▀   ██   ██ ▀████ ▄▄██▀

local function fmt_diagnostic(d) return d.message end
local sev = vim.diagnostic.severity

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  signs = {
    text = {
      [sev.ERROR] = ' ',
      [sev.WARN] = ' ',
      [sev.INFO] = ' ',
      [sev.HINT] = '󰌵 ',
    },
  },
  virtual_lines = {
    current_line = true,
    format = fmt_diagnostic,
  },
  update_in_insert = true,
  virtual_text = {
    source = 'if_many',
    spacing = 4,
    format = fmt_diagnostic,
  },
})

-- TODO: make less cursed
vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
  desc = 'Disable diagnostic.virtual_text on any line affected by the diagnostic',
  group = vim.api.nvim_create_augroup('diagnostic_virt_text_hide', { clear = true }),
  callback = function(ev)
    if vim.list_contains({ 'lazy', 'mason' }, vim.bo[ev.buf].filetype) then return end -- handled by lazy_window_diagnostics
    local cursor_lnum, _ = unpack(vim.api.nvim_win_get_cursor(0))
    cursor_lnum = cursor_lnum - 1

    vim.diagnostic.show(nil, ev.buf)
    for _, diagnostic in ipairs(vim.diagnostic.get(ev.buf)) do
      local start_line = diagnostic.lnum
      local end_line = diagnostic.end_lnum or start_line
      if cursor_lnum >= start_line and cursor_lnum <= end_line then
        for _, namespace in pairs(vim.diagnostic.get_namespaces()) do
          local ns_id = namespace.user_data.virt_text_ns
          if ns_id then
            local extmarks = vim.api.nvim_buf_get_extmarks(ev.buf, ns_id, { start_line, 0 }, { end_line, -1 }, {})
            for _, extmark in pairs(extmarks) do
              vim.api.nvim_buf_del_extmark(ev.buf, ns_id, extmark[1])
            end
          end
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lazy', 'mason' },
  group = vim.api.nvim_create_augroup('lazy_window_diagnostics', { clear = true }),
  callback = function(ev)
    -- lazy reuses its buffer, so apply window opts every time it's displayed
    vim.api.nvim_create_autocmd('BufWinEnter', {
      buffer = ev.buf,
      callback = function()
        local win = vim.api.nvim_get_current_win()
        vim.wo[win].statuscolumn = ''
        vim.wo[win].signcolumn = 'no'
      end,
    })
  end,
})

-- ▄▄ ▄▄ ▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄  ▄▄ ▄▄  ▄▄ ▄▄▄▄   ▄▄▄▄
-- ██▄█▀ ██▄▄  ▀███▀ ██▄██ ██ ███▄██ ██▀██ ███▄▄
-- ██ ██ ██▄▄▄   █   ██▄█▀ ██ ██ ▀██ ████▀ ▄▄██▀

-- most keybinds are plugin-specific and live in their respective config files; the rest are here
local set = Snacks.keymap.set

-- move focus
set({ 'n', 'v' }, '<C-h>', function() vim.cmd.wincmd('h') end)
set({ 'n', 'v' }, '<C-j>', function() vim.cmd.wincmd('j') end)
set({ 'n', 'v' }, '<C-k>', function() vim.cmd.wincmd('k') end)
set({ 'n', 'v' }, '<C-l>', function() vim.cmd.wincmd('l') end)

set('n', '<leader>L', '<cmd>Lazy<CR>')

set('n', '<leader>w', '<C-w>')
set('n', '-', '<C-w>-', { desc = 'Increase height' })
set('n', '+', '<C-w>+', { desc = 'Decrease height' })
set('n', '<C-->', '<C-w><', { desc = 'Increase width' })
set('n', '<C-+>', '<C-w>>', { desc = 'Decrease width' })

set('i', '<C-a>', '<Esc>I')
set('i', '<C-e>', '<Esc>A')
set('i', '<C-BS>', '<C-w>')

set('n', 'q:', ':')
set('n', '<Esc>', function() vim.cmd('nohlsearch') end, { nowait = true })
set('n', 'q', '<cmd>q<CR>', { ft = 'help', nowait = true })
set({ 'n', 'v' }, '<leader>D', function() vim.diagnostic.open_float() end)

-- set('n', '<C-i>', '<C-i>')
-- set('n', '<tab>', 'gt')

local smart = function(normal, wrapped)
  return function() return vim.wo.wrap and wrapped or normal end
end

set({ 'n', 'v' }, 'j', smart('j', 'gj'), { expr = true })
set({ 'n', 'v' }, 'k', smart('k', 'gk'), { expr = true })
set({ 'n', 'v' }, '0', smart('0', 'g0'), { expr = true })
set({ 'n', 'v' }, '$', smart('$', 'g$'), { expr = true })

set('n', ']t', '<cmd>tabnext<CR>')
set('n', '[t', '<cmd>tabprevious<CR>')

set('n', '<leader>RR', '<cmd>restart<CR>')

--  ▄▄▄ ▄▄▄▄▄▄ ▄▄ ▄▄ ▄▄▄▄▄ ▄▄▄▄
-- ██▀██  ██   ██▄██ ██▄▄  ██▄█▄
-- ▀███▀  ██   ██ ██ ██▄▄▄ ██ ██

vim.o.guifont = 'JetBrains Mono,Symbols Nerd Font'

vim.treesitter.language.register('xml', 'svg')

vim.api.nvim_create_augroup('kitty-grouping', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = 'kitty-grouping',
  callback = function() vim.fn.system('kitten @ --to $KITTY_LISTEN_ON set-spacing padding=0 &') end,
})
vim.api.nvim_create_autocmd('VimLeave', {
  group = 'kitty-grouping',
  callback = function() vim.fn.system('kitten @ --to $KITTY_LISTEN_ON set-spacing padding=default &') end,
})

-- :restart fix - having a terminal buffer in a session means filetype doesn't get detected
if vim.v.startreason == 'restart' then
  vim.api.nvim_create_autocmd('UIEnter', {
    once = true,
    callback = function()
      vim.defer_fn(function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if
            vim.api.nvim_buf_is_loaded(buf)
            and vim.bo[buf].buftype == ''
            and vim.bo[buf].filetype == ''
            and vim.api.nvim_buf_get_name(buf) ~= ''
          then
            local ft = vim.filetype.match({ buf = buf })
            if ft then vim.bo[buf].filetype = ft end -- fires FileType
          end
        end
      end, 50)
    end,
  })
end
