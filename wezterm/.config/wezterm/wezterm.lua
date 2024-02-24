-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Batman'

-- Set background to same color as neovim
config.colors = {}
config.colors.background = '#000000'

config.font = wezterm.font_with_fallback {
    'Fira Mono',
    'Ubuntu Mono',
}
config.font_size = 14

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

config.window_decorations = "RESIZE"

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- config.freetype_load_target = "HorizontalLcd"

-- and finally, return the configuration to wezterm
return config
