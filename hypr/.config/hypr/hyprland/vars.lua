-- ░█░█░█▀█░█▀▄░▀█▀░█▀█░█▀▄░█░░░█▀▀░█▀▀
-- ░▀▄▀░█▀█░█▀▄░░█░░█▀█░█▀▄░█░░░█▀▀░▀▀█
-- ░░▀░░▀░▀░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀▀▀░▀▀▀

-- `require` runs each module once and returns its value, so this table is
-- shared by every module that needs it.

local M = {}

-- Modifier
M.win = 'SUPER'

-- Programs
M.terminal = 'kitty'
M.editor = 'code'
M.fileManager = 'nautilus'
M.menu = 'vicinae toggle'

-- Other
M.screenshot = 'grim - | satty -f -'
M.sspath = '/home/dag/images/screenshots'

-- special:info launcher (was $calendar in rules.conf)
M.calendar =
  [[/usr/bin/firefox --new-window --name='Notion Calendar' --no-remote -P "FTWA" 'https://calendar.notion.so']]

-- $XDG_CONFIG_HOME/hypr/scripts (was $scripts in startup.conf)
M.scripts = (os.getenv('XDG_CONFIG_HOME') or (os.getenv('HOME') .. '/.config')) .. '/hypr/scripts'

return M
