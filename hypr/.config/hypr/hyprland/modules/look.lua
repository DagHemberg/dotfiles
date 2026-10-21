-- ░█░░░█▀█░█▀█░█░█░░░▄▀░░░░█▀▀░█▀▀░█▀▀░█░░
-- ░█░░░█░█░█░█░█▀▄░░░▄█▀░░░█▀▀░█▀▀░█▀▀░█░░
-- ░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░░▀▀░░░▀░░░▀▀▀░▀▀▀░▀▀▀

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 0,

    col = {
      active_border = { colors = { 'rgba(33ccffe0)', 'rgba(00ff99e0)' }, angle = 45 },
      inactive_border = 'rgba(0D111700)',
    },

    layout = 'dwindle',
    allow_tearing = false,
  },

  decoration = {
    rounding = 10,
    dim_special = 0.2,

    blur = {
      enabled = true,
      size = 7,
      passes = 3,
      noise = 0.07,
      vibrancy_darkness = 0.5,
    },

    shadow = {
      enabled = true,
      range = 45,
      render_power = 2,
      color = 'rgba(00000040)',
      color_inactive = 'rgba(00000025)',
      offset = { 0, 15 },
      scale = 0.99,
    },
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    preserve_split = true,
  },
})

-- ░█▀█░█▀█░▀█▀░█▄█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀
-- ░█▀█░█░█░░█░░█░█░█▀█░░█░░░█░░█░█░█░█░▀▀█
-- ░▀░▀░▀░▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀

hl.curve('myBezier', { type = 'bezier', points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })

hl.animation({ leaf = 'windows', enabled = true, speed = 4, bezier = 'myBezier' })
hl.animation({ leaf = 'windowsIn', enabled = true, speed = 4, bezier = 'myBezier', style = 'slide' })
hl.animation({ leaf = 'windowsOut', enabled = true, speed = 4, bezier = 'myBezier', style = 'slide' })
hl.animation({ leaf = 'border', enabled = true, speed = 10, bezier = 'default' })
hl.animation({ leaf = 'borderangle', enabled = true, speed = 8, bezier = 'default' })
hl.animation({ leaf = 'fade', enabled = true, speed = 4, bezier = 'default' })
hl.animation({ leaf = 'workspaces', enabled = true, speed = 3, bezier = 'default', style = 'slide' })
hl.animation({ leaf = 'specialWorkspace', enabled = true, speed = 2, bezier = 'default', style = 'slidefadevert -50%' })
