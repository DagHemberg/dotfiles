return {
  'monaqa/dial.nvim',
  -- event = 'VeryLazy',
  keys = {
    { '<C-a>', '<Plug>(dial-increment)', desc = 'Increment value', noremap = true },
    { '<C-x>', '<Plug>(dial-decrement)', desc = 'Decrement value', noremap = true },
    { 'g<C-a>', '<Plug>(dial-g-increment)', desc = 'Increment value (additive)', remap = true },
    { 'g<C-x>', '<Plug>(dial-g-decrement)', desc = 'Decrement value (additive)', remap = true },
    { '<C-a>', '<Plug>(dial-increment)', mode = 'v', desc = 'Increment value', noremap = true },
    { '<C-x>', '<Plug>(dial-decrement)', mode = 'v', desc = 'Decrement value', noremap = true },
    { 'g<C-a>', '<Plug>(dial-g-increment)', mode = 'v', desc = 'Increment value (additive)', remap = true },
    { 'g<C-x>', '<Plug>(dial-g-decrement)', mode = 'v', desc = 'Decrement value (additive)', remap = true },
  },
  config = function()
    local augend = require('dial.augend')
    local config = require('dial.config')
    local const = augend.constant.new
    local date = augend.date.new

    local defualts = {
      -- numbers
      augend.integer.alias.decimal_int,
      augend.integer.alias.hex,
      augend.integer.alias.octal,
      augend.integer.alias.binary,
      augend.semver.alias.semver,
      augend.hexcolor.new({ case = 'prefer_upper' }),

      -- time and date
      date({
        pattern = '%Y-%m-%d',
        default_kind = 'day',
        clamp = true,
        end_sensitive = true,
        only_valid = true,
      }),
      date({
        pattern = '%d/%m-%Y',
        default_kind = 'day',
        clamp = true,
        end_sensitive = true,
        only_valid = true,
      }),
      date({ pattern = '%H:%M', default_kind = 'min' }),
      date({ pattern = '%H:%M:%S', default_kind = 'sec' }),

      -- consts
      const({ elements = { 'true', 'false' }, preserve_case = true }),
      const({ elements = { 'yes', 'no' }, preserve_case = true }),
      const({ elements = { 'on', 'off' }, preserve_case = true }),
      const({ elements = { 'and', 'or' }, preserve_case = true }),
      const({ elements = { '&&', '||' } }),
      const({ elements = { '<', '<=', '>', '>=' } }),
    }

    config.augends:register_group({
      default = { table.unpack(defualts) },
    })

    config.augends:on_filetype({
      markdown = {
        table.unpack(defualts),
        augend.misc.alias.markdown_header,
        const({ elements = { '[ ]', '[x]' }, word = false }),
      },
      python = {
        table.unpack(defualts),
        const({ elements = { 'def', 'async def' } }),
      },
      rust = {
        table.unpack(defualts),
        const({ elements = { 'pub', 'pub(crate)' } }),
        const({ elements = { 'fn', 'async fn' } }),
        const({ elements = { 'struct', 'trait', 'enum' } }),
      },
      java = {
        table.unpack(defualts),
        const({ elements = { 'public', 'protected', 'private' } }),
        const({ elements = { 'class', 'interface', 'enum' } }),
      },
      scala = {
        table.unpack(defualts),
        const({ elements = { 'protected', 'private' } }),
        const({ elements = { 'opaque', 'transparent' } }),
        const({ elements = { 'given', 'implicit' } }),
        const({ elements = { 'def', 'var', 'val', 'lazy val' }, word = false }),
        const({
          elements = { 'class', 'case class', 'trait', 'enum', 'object', 'case object' },
          word = false,
          match_before_cursor = true,
        }),
      },
      javascript = {
        table.unpack(defualts),
        const({ elements = { 'let', 'const', 'var' } }),
        const({ elements = { 'function', 'async function' }, match_before_cursor = true }),
      },
      typescript = {
        table.unpack(defualts),
        const({ elements = { 'let', 'const', 'var' } }),
        const({ elements = { 'public', 'private', 'protected' } }),
        const({ elements = { 'function', 'async function' }, word = false }),
      },
      go = {
        table.unpack(defualts),
        const({ elements = { 'var', 'const' } }),
        const({ elements = { ':=', '=' }, word = false }),
      },
      css = {
        table.unpack(defualts),
        const({ elements = { 'px', 'em', 'rem', '%' }, word = false }),
        const({
          elements = {
            'display: block',
            'display: inline',
            'display: inline-block',
            'display: flex',
            'display: grid',
            'display: none',
          },
          word = true,
        }),
        const({
          elements = {
            'position: static',
            'position: relative',
            'position: absolute',
            'position: fixed',
            'position: sticky',
          },
          word = false,
        }),
      },
      c = {
        table.unpack(defualts),
        const({ elements = { 'signed', 'unsigned' } }),
      },
      cpp = {
        table.unpack(defualts),
        const({ elements = { 'signed', 'unsigned' } }),
        const({ elements = { 'const', 'constexpr' } }),
        const({ elements = { 'class', 'struct' } }),
        const({ elements = { 'public:', 'protected:', 'private:' } }),
      },
    })

    require('which-key').add({})
  end,
}
