-- ░█▀▄░█░█░█░░░█▀▀░█▀▀
-- ░█▀▄░█░█░█░░░█▀▀░▀▀█
-- ░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀

local vars = require('hyprland.vars')

-- ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀
-- ░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█
-- ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀

hl.window_rule({
  name = 'suppress_maximize',
  match = { class = '.*' },
  suppress_event = 'maximize',
})

hl.window_rule({
  name = 'obsidian-blur',
  match = { class = '(obsidian)' },
  opacity = '1 1 0.9',
})

hl.window_rule({
  name = 'kitty-opacity',
  match = { class = '(kitty)', focus = false },
  opacity = '0.9',
})

hl.window_rule({
  name = 'screensharing',
  match = { class = '^(xwaylandvideobridge)$' },
  opacity = '0.0 override',
  no_anim = true,
  no_initial_focus = true,
  max_size = { 1, 1 },
  no_blur = true,
})

hl.window_rule({
  name = 'naut-preview-float',
  match = { class = '^(org.gnome.NautilusPreviewer)$' },
  float = true,
})

hl.window_rule({
  name = 'satty-no-anim',
  match = { class = '^(com.gabm.satty)$' },
  no_anim = true,
})

-- ░█░█░█▀█░█▀▄░█░█░█▀▀░█▀█░█▀█░█▀▀░█▀▀░█▀▀
-- ░█▄█░█░█░█▀▄░█▀▄░▀▀█░█▀▀░█▀█░█░░░█▀▀░▀▀█
-- ░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀▀▀

hl.workspace_rule({
  workspace = 'special:action',
  on_created_empty = '[fullscreen] kitty',
})

hl.workspace_rule({
  workspace = 'special:scratch',
  on_created_empty = '[fullscreen] flatpak run md.obsidian.Obsidian',
})

hl.workspace_rule({
  workspace = 'special:info',
  on_created_empty = '[fullscreen] ' .. vars.calendar,
})

-- ░█░░░█▀█░█░█░█▀▀░█▀▄░█▀▀
-- ░█░░░█▀█░░█░░█▀▀░█▀▄░▀▀█
-- ░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀

hl.layer_rule({
  name = 'vicinae',
  match = { namespace = 'vicinae' },
  ignore_alpha = 0.1,
})
