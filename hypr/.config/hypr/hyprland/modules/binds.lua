-- ░█░█░█▀▀░█░█░█▀▄░▀█▀░█▀█░█▀▄░█▀▀
-- ░█▀▄░█▀▀░░█░░█▀▄░░█░░█░█░█░█░▀▀█
-- ░▀░▀░▀▀▀░░▀░░▀▀░░▀▀▀░▀░▀░▀▀░░▀▀▀

local vars = require('hyprland.vars')
local win = vars.win

local bind = hl.bind
local dsp = hl.dsp

-- ░█░░░█▀█░█░█░█▀█░█▀▀░█░█
-- ░█░░░█▀█░█░█░█░█░█░░░█▀█
-- ░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀

bind(win .. ' + T', dsp.exec_cmd(vars.terminal))
bind(win .. ' + E', dsp.exec_cmd(vars.fileManager))

-- bind(win .. " + SHIFT + P", dsp.exec_cmd(vars.menu))
-- bind(win .. " + Super_L",   dsp.exec_cmd(vars.menu), { release = true })
bind('ALT + Space', dsp.exec_cmd(vars.menu))
bind('CTRL + ALT + Delete', dsp.exec_cmd('kitty btop'))

bind(win .. ' + period', dsp.exec_cmd('vicinae vicinae://extensions/vicinae/core/search-emojis'))

bind('SHIFT + ALT + 4', dsp.exec_cmd(vars.screenshot))
bind(win .. ' + M', dsp.exec_cmd('hyprpicker -a'))

-- ░█▀▀░█░█░█▀█░█▀▄░▀█▀░█▀▀░█░█░▀█▀░█▀▀
-- ░▀▀█░█▀█░█░█░█▀▄░░█░░█░░░█░█░░█░░▀▀█
-- ░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░░▀░░▀▀▀

--    Layout
bind(win .. ' + Return', dsp.window.fullscreen())
bind(win .. ' + V', dsp.window.float())
bind(win .. ' + C', dsp.window.center())
bind(win .. ' + J', dsp.layout('togglesplit'))
bind(win .. ' + P', dsp.window.pseudo())

--    Alt-tab
bind('ALT + Tab', function()
  hl.dispatch(dsp.window.cycle_next())
  hl.dispatch(dsp.window.bring_to_top())
end)
bind('ALT + SHIFT + Tab', dsp.window.cycle_next({ next = false }))

bind(win .. ' + Tab', dsp.focus({ workspace = 'previous' }))

--    Other
bind('ALT + Q', dsp.window.close())
bind(win .. ' + Delete', dsp.exit())
bind(win .. ' + L', dsp.exec_cmd('hyprlock'))
bind(win .. ' + Escape', dsp.exec_cmd('killall -SIGUSR1 waybar'))

-- ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀
-- ░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█
-- ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀

-- Switch focus
bind(win .. ' + left', dsp.focus({ direction = 'left' }))
bind(win .. ' + right', dsp.focus({ direction = 'right' }))
bind(win .. ' + up', dsp.focus({ direction = 'up' }))
bind(win .. ' + down', dsp.focus({ direction = 'down' }))

-- Move window (floating)
bind(win .. ' + SHIFT + left', dsp.window.move({ x = -70, y = 0, relative = true }))
bind(win .. ' + SHIFT + right', dsp.window.move({ x = 70, y = 0, relative = true }))
bind(win .. ' + SHIFT + up', dsp.window.move({ x = 0, y = -70, relative = true }))
bind(win .. ' + SHIFT + down', dsp.window.move({ x = 0, y = 70, relative = true }))

-- Move window (tiling)
bind(win .. ' + CTRL + left', dsp.window.move({ direction = 'left' }))
bind(win .. ' + CTRL + right', dsp.window.move({ direction = 'right' }))
bind(win .. ' + CTRL + up', dsp.window.move({ direction = 'up' }))
bind(win .. ' + CTRL + down', dsp.window.move({ direction = 'down' }))

-- Resize window (the Lua resize dispatcher takes pixels, so convert the
-- old percentage deltas against the active window's current size).
local function resize_active(fx, fy)
  local w = hl.get_active_window()
  if not w then return end
  local sz = w.size
  if type(sz) ~= 'table' then return end
  hl.dispatch(dsp.window.resize({
    x = math.floor((sz.x or 0) * fx),
    y = math.floor((sz.y or 0) * fy),
    relative = true,
  }))
end

bind(win .. ' + ALT + left', function() resize_active(-0.10, 0) end)
bind(win .. ' + ALT + right', function() resize_active(0.10, 0) end)
bind(win .. ' + ALT + up', function() resize_active(0, -0.10) end)
bind(win .. ' + ALT + down', function() resize_active(0, 0.10) end)

-- Move window to workspace
bind(win .. ' + CTRL + SHIFT + left', dsp.window.move({ workspace = '-1' }))
bind(win .. ' + CTRL + SHIFT + right', dsp.window.move({ workspace = '+1' }))
bind(win .. ' + CTRL + SHIFT + up', dsp.window.move({ workspace = 'special:action' }))
bind(win .. ' + CTRL + SHIFT + down', dsp.window.move({ workspace = '+0' }))
bind(win .. ' + CTRL + SHIFT + o', dsp.window.move({ workspace = 'special:scratch' }))

-- ░█░█░█▀█░█▀▄░█░█░█▀▀░█▀█░█▀█░█▀▀░█▀▀░█▀▀
-- ░█▄█░█░█░█▀▄░█▀▄░▀▀█░█▀▀░█▀█░█░░░█▀▀░▀▀█
-- ░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀▀▀

-- Special workspaces (scratchpads)
bind(win .. ' + CTRL + N', dsp.workspace.toggle_special('action'))
bind(win .. ' + CTRL + O', dsp.workspace.toggle_special('scratch'))
bind(win .. ' + CTRL + K', dsp.workspace.toggle_special('info'))

bind(win .. ' + SHIFT + O', dsp.window.move({ workspace = 'special:scratch' }))
bind(win .. ' + SHIFT + K', dsp.window.move({ workspace = 'special:info' }))

-- Switch workspaces with win + [0-9], move window with win + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  bind(win .. ' + ' .. key, dsp.focus({ workspace = i }))
  bind(win .. ' + SHIFT + ' .. key, dsp.window.move({ workspace = i }))
end

bind(win .. ' + home', dsp.focus({ workspace = '-1' }))
bind(win .. ' + end', dsp.focus({ workspace = '+1' }))

bind(win .. ' + CTRL + Tab', dsp.focus({ workspace = '+1' }))
bind(win .. ' + SHIFT + CTRL + Tab', dsp.focus({ workspace = '-1' }))

hl.config({
  binds = {
    allow_workspace_cycles = true,
  },
})

-- ░█▄█░█▀█░█░█░█▀▀░█▀▀
-- ░█░█░█░█░█░█░▀▀█░█▀▀
-- ░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀

bind(win .. ' + mouse:272', dsp.window.drag(), { mouse = true })
bind(win .. ' + SHIFT + mouse:272', dsp.window.resize(), { mouse = true })
bind(win .. ' + ALT + mouse:272', dsp.window.resize(), { mouse = true })

-- ░█▄█░█▀▀░█▀▄░▀█▀░█▀█░░░█░█░█▀▀░█░█░█▀▀
-- ░█░█░█▀▀░█░█░░█░░█▀█░░░█▀▄░█▀▀░░█░░▀▀█
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀░▀░░░▀░▀░▀▀▀░░▀░░▀▀▀

bind(
  'XF86AudioRaiseVolume',
  dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'),
  { locked = true, repeating = true }
)
bind(
  'XF86AudioLowerVolume',
  dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'),
  { locked = true, repeating = true }
)
bind('XF86AudioMute', dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'), { locked = true })

bind('XF86AudioPlay', dsp.exec_cmd('playerctl play-pause'), { locked = true })
bind('XF86AudioPrev', dsp.exec_cmd('playerctl previous'), { locked = true })
bind('XF86AudioNext', dsp.exec_cmd('playerctl next'), { locked = true })
