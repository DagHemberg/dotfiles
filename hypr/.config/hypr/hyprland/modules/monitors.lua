-- ░█▄█░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀▄░█▀▀
-- ░█░█░█░█░█░█░░█░░░█░░█░█░█▀▄░▀▀█
-- ░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀

-- Ported from hyprmoncfg-monitors.conf.

hl.monitor({
  output = 'desc:BOE 0x0AC1',
  mode = '2560x1600@120.00',
  position = '0x0',
  scale = 1.6,
  sdr_min_luminance = 0.2,
  sdr_max_luminance = 80,
})

hl.monitor({
  output = 'desc:Microstep Optix G24C 0x00000001',
  mode = '1920x1080@120.00',
  position = '-180x-1080',
  scale = 1,
  sdr_min_luminance = 0.2,
  sdr_max_luminance = 80,
})
