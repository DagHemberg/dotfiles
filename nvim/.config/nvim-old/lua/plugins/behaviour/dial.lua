return {
  'monaqa/dial.nvim',
  keys = {
    { '<C-a>', '<Plug>(dial-increment)', mode = { 'n', 'v' }, desc = 'Increment value', noremap = true },
    { '<C-x>', '<Plug>(dial-decrement)', mode = { 'n', 'v' }, desc = 'Decrement value', noremap = true },
    { 'g<C-a>', '<Plug>(dial-g-increment)', mode = { 'n', 'v' }, desc = 'Increment value (additive)', remap = true },
    { 'g<C-x>', '<Plug>(dial-g-decrement)', mode = { 'n', 'v' }, desc = 'Decrement value (additive)', remap = true },
  },
  config = function()
    local augend = require('dial.augend')
    local config = require('dial.config')
    local const = augend.constant.new
    local date = augend.date.new

    local defaults = {
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
      const({ elements = { '&&', '||' }, word = false }),
      -- const({ elements = { '<', '<=', '>', '>=' }, word = false, match_before_cursor = true }),
    }

    config.augends:register_group({
      default = { table.unpack(defaults) },
    })

    config.augends:on_filetype({
      markdown = {
        augend.misc.alias.markdown_header,
        const({ elements = { '[ ]', '[x]' }, word = false }),
        table.unpack(defaults),
      },
      python = {
        const({ elements = { 'def', 'async def' } }),
        table.unpack(defaults),
      },
      rust = {
        const({ elements = { 'pub', 'pub(crate)' } }),
        const({ elements = { 'fn', 'async fn' } }),
        const({ elements = { 'struct', 'trait', 'enum' } }),
        table.unpack(defaults),
      },
      java = {
        const({ elements = { 'public', 'protected', 'private' } }),
        const({ elements = { 'class', 'interface', 'enum' } }),
        table.unpack(defaults),
      },
      scala = {
        const({ elements = { 'protected', 'private' } }),
        const({ elements = { 'opaque', 'transparent' } }),
        const({ elements = { 'given', 'implicit' } }),
        const({ elements = { 'def', 'var', 'val', 'lazy val' }, word = false }),
        const({
          elements = { 'class', 'case class', 'trait', 'enum', 'object', 'case object' },
          word = false,
          match_before_cursor = true,
        }),
        table.unpack(defaults),
      },
      javascript = {
        const({ elements = { 'let', 'const', 'var' } }),
        const({ elements = { 'function', 'async function' }, match_before_cursor = true }),
        table.unpack(defaults),
      },
      typescript = {
        const({ elements = { 'let', 'const', 'var' } }),
        const({ elements = { 'public', 'private', 'protected' } }),
        const({ elements = { 'function', 'async function' }, word = false }),
        table.unpack(defaults),
      },
      go = {
        const({ elements = { 'var', 'const' } }),
        const({ elements = { ':=', '=' }, word = false }),
        table.unpack(defaults),
      },
      css = {
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
          word = false,
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
        table.unpack(defaults),
      },
      c = {
        const({ elements = { 'signed', 'unsigned' } }),
        table.unpack(defaults),
      },
      cpp = {
        const({ elements = { 'signed', 'unsigned' } }),
        const({ elements = { 'const', 'constexpr' } }),
        const({ elements = { 'class', 'struct' } }),
        const({ elements = { 'public:', 'protected:', 'private:' } }),
        table.unpack(defaults),
      },
    })
  end,
}
