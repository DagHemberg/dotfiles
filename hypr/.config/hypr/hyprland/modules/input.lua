-- ░▀█▀░█▀█░█▀█░█░█░▀█▀░░░▄▀░░░░█▀▀░█▀▀░█▀▀░▀█▀░█░█░█▀▄░█▀▀░█▀▀
-- ░░█░░█░█░█▀▀░█░█░░█░░░░▄█▀░░░█░█░█▀▀░▀▀█░░█░░█░█░█▀▄░█▀▀░▀▀█
-- ░▀▀▀░▀░▀░▀░░░▀▀▀░░▀░░░░░▀▀░░░▀▀▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀

hl.config({
  input = {
    kb_layout = 'se',
    kb_variant = '',
    kb_model = '',
    kb_options = '',
    kb_rules = '',

    follow_mouse = 1,

    repeat_rate = 45,
    repeat_delay = 450,

    accel_profile = 'adaptive',
    sensitivity = 0, -- -1.0 to 1.0, 0 means no modification

    touchpad = {
      scroll_factor = 0.2,
      natural_scroll = true,
    },
  },

  gestures = {
    workspace_swipe_forever = true,
    workspace_swipe_min_speed_to_force = 5,
    workspace_swipe_distance = 650,
  },
})

-- 4-finger horizontal swipe switches workspaces
hl.gesture({ fingers = 4, direction = 'horizontal', action = 'workspace' })
-- hl.gesture({ fingers = 4, direction = "vertical", action = "special", workspace_name = "action" })
-- hl.gesture({ fingers = 3, direction = "swipe",    action = "move" })
-- hl.gesture({ fingers = 3, direction = "pinch",    action = "fullscreen" })

-- Per-device config
hl.device({
  name = 'epic-mouse-v1',
  sensitivity = -0.5,
})
