local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

--config.color_schemes = {
--  ['kanagawa'] = {
--    foreground = "#dcd7ba",
--    background = "#1f1f28",
--
--    cursor_bg = "#c8c093",
--    cursor_fg = "#000000",
--    cursor_border = "#c8c093",
--
--    selection_fg = "#c8c093",
--    selection_bg = "#2d4f67",
--
--    scrollbar_thumb = "#16161d",
--    split = "#16161d",
--
--    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
--    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
--    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
--  }
--}

config.window_padding = {
  left = "1cell",
  right = "1cell",
  top = "0.5cell",
}

config.color_scheme = 'kanagawa_dragon'
config.force_reverse_video_cursor = true
config.font = wezterm.font('Iosevka Slab')
config.font_size = 18

config.send_composed_key_when_left_alt_is_pressed = true
config.use_dead_keys = true

config.native_macos_fullscreen_mode = true

config.enable_tab_bar = false

-- keybindings

config.disable_default_key_bindings = true

local act = wezterm.action
config.keys = {
  {
    key = 'c',
    mods = 'CMD',
    action = act.CopyTo 'Clipboard'
  },
  {
    key = 'v',
    mods = 'CMD',
    action = act.PasteFrom 'Clipboard'
  }
}

return config
