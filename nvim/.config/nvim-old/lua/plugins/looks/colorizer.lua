return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufRead',
  opts = {
    user_default_options = {
      names = false,
      mode = 'virtualtext',
      virtualtext = '󱓻',
      virtualtext_inline = 'before',
      css_fn = true,
      RRGGBBAA = true,
    },
  },
}
