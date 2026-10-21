-- ░█▀█░█░█░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█▀▄░▀█▀
-- ░█▀█░█░█░░█░░█░█░▀▀█░░█░░█▀█░█▀▄░░█░
-- ░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░░▀░░▀░▀░▀░▀░░▀░

local vars = require('hyprland.vars')

hl.on('hyprland.start', function()
  --  Utils
  hl.exec_cmd('systemctl --user start hyprland-session.target')
  hl.exec_cmd('blueman-applet')
  hl.exec_cmd('systemctl --user start hyprpolkitagent')
  hl.exec_cmd('hypridle')
  hl.exec_cmd('vicinae server --replace')

  --  Scripts
  -- hl.exec_cmd("sudo /usr/bin/systemctl restart ydotool.service") -- TODO: FIX
  hl.exec_cmd('fusuma')
  hl.exec_cmd(vars.scripts .. '/launch-waybar')
  hl.exec_cmd(vars.scripts .. '/float-bitwarden')

  --  Programs
  hl.exec_cmd('flatpak run dev.vencord.Vesktop', { workspace = '1 silent' })
  hl.exec_cmd('firefox', { workspace = '2' })
  -- hl.exec_cmd("code --ozone-platform=wayland",  { workspace = "3 silent" })
  -- hl.exec_cmd("spotify --ozone-platform=wayland", { workspace = "10 silent" })
end)
