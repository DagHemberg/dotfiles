vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('chezmoi-filetype', { clear = true }),
  pattern = '*/chezmoi/*dot_*',
  callback = function(ev)
    local ft = vim.filetype.match({ filename = vim.fn.fnamemodify(ev.file, ':t'):gsub('^dot_', '.') })
    if ft ~= nil then
      vim.bo[ev.buf].filetype = ft
    end
  end,
})

vim.api.nvim_create_augroup('kitty-grouping', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Disable padding on kitty windows when entering Neovim',
  group = 'kitty-grouping',
  callback = function()
    -- vim.fn.system('kitten @ --to $KITTY_LISTEN_ON set-spacing padding=0 &')
    vim.fn.system('kitten @ --to $KITTY_LISTEN_ON set-background-opacity 0.92 &')
    vim.fn.system('kitten @ --to $KITTY_LISTEN_ON set-colors background=#1A1B26 &')
  end,
})

vim.api.nvim_create_autocmd('VimLeave', {
  desc = 'Re-enable padding on kitty windows when exiting Neovim',
  group = 'kitty-grouping',
  callback = function()
    -- vim.fn.system('kitten @ --to $KITTY_LISTEN_ON set-spacing padding=default &')
    vim.fn.system('kitten @ --to $KITTY_LISTEN_ON set-background-opacity 0.72 &')
    vim.fn.system('kitten @ --to $KITTY_LISTEN_ON set-colors background=#0e1415 &')
  end,
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
  desc = 'Disable diagnostic.virtual_text on any line affected by the diagnostic',
  group = vim.api.nvim_create_augroup('diagnostic_virt_text_hide', { clear = true }),
  callback = function(ev)
    local cursor_lnum, _ = unpack(vim.api.nvim_win_get_cursor(0))
    cursor_lnum = cursor_lnum - 1

    -- Always show diagnostics first, then selectively remove
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
