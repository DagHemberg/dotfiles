return {
  'saghen/blink.pairs',
  build = 'cargo build --release',
  event = 'InsertEnter',
  opts = {
    highlights = { enabled = false },
  }
}
