return {
  'neovim/nvim-lspconfig',
  config = function(opts)
    -- Enable LSP features for all servers
    vim.lsp.config('*', {
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })

    -- TODO: clean up, structure better
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local snacks = require('snacks')
        require('which-key').add({
          { '<leader>r', ':IncRename ', desc = 'rename' },
          { '<leader>a', require('tiny-code-action').code_action, desc = 'Perform code action', mode = { 'n', 'x' } },
          { '<Leader>gd', snacks.picker.lsp_definitions, desc = 'Go to definition' },
          { '<Leader>gD', snacks.picker.lsp_declarations, desc = 'Go to declaration' },
          { '<leader>gr', snacks.picker.lsp_references, desc = 'Go to references' },
          { '<leader>li', snacks.picker.lsp_implementations, desc = 'View implentations' },
          { '<leader>ld', snacks.picker.lsp_symbols, desc = 'Open document symbols' },
          { '<leader>lw', snacks.picker.lsp_workspace_symbols, desc = 'Open workspace symbols' },
          { '<leader>lt', snacks.picker.lsp_type_definitions, desc = 'Go to type definition' },
          { '<leader>lc', vim.lsp.codelens.run, desc = 'Run codelens' }
        })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local hl_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
            end,
          })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          local toggle = require('toggle')
          vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          toggle.register(
            'h',
            -- Disables or enables inlay hints for the current buffer.
            toggle.option.NotifyOnSetOption(toggle.option.OnOffOption({
              name = 'inlay hints',
              get_state = function()
                return vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
              end,
              set_state = function(new_value)
                vim.lsp.inlay_hint.enable(new_value, { bufnr = event.buf })
              end,
            })),
            { buffer = event.buf }
          )
        end
      end,
    })
  end,
}
