local function fmt_diagnostic(diagnostic)
  local diagnostic_message = {
    [vim.diagnostic.severity.ERROR] = diagnostic.message,
    [vim.diagnostic.severity.WARN] = diagnostic.message,
    [vim.diagnostic.severity.INFO] = diagnostic.message,
    [vim.diagnostic.severity.HINT] = diagnostic.message,
  }
  return diagnostic_message[diagnostic.severity]
end

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌵 ',
    },
  },
  virtual_lines = {
    current_line = true,
    format = fmt_diagnostic,
  },
  update_in_insert = false,
  virtual_text = {
    source = 'if_many',
    spacing = 4,
    format = fmt_diagnostic,
  },
})
