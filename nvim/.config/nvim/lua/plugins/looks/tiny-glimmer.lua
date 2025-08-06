return {
  'rachartier/tiny-glimmer.nvim',
  event = 'BufRead',
  priority = 10,
  opts = {
    -- transparency_color = '#1A1B26',
    -- transparency_color = '#0E1415',
    animations = {
      fade = {
        max_duration = 400,
        min_duration = 400,
        to_color = '#1A1B26',
        from_color = '#283457',
      },
    },
    support = {
      substitute = {
        enabled = true,
      },
    },
    overwrite = {
      yank = { default_animation = 'fade' },
      paste = { default_animation = 'fade' },
      undo = { enabled = true, default_animation = { name = 'fade', settings = { from_color = '#442328' } } },
      redo = { enabled = true, default_animation = { name = 'fade', settings = { from_color = '#0e6252' } } },
    },
  },
}
