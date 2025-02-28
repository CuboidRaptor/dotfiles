local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- actually use regular bash cuh
config.default_prog = { "bash" }

config.initial_rows = 32
config.initial_cols = 128

config.switch_to_last_active_tab_when_closing_tab = true

local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main

config.colors = theme.colors();
config.window_frame = theme.window_frame();

config.font = wezterm.font_with_fallback {
    "Cascadia Code NF",
    "Consolas",
    "DengXian"
}
config.font_size = 12

config.window_padding = {
    left = "15px",
    right = "15px",
    top = "15px",
    bottom = "15px",
}

local act = wezterm.action
config.keys = {
    { key = "q", mods = "CTRL|SHIFT", action = act.QuitApplication },
    { key = "Tab", mods = "CTRL", action = act.DisableDefaultAssignment },
    { key = "Tab", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
    { key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },
}

-- Open new wezterms in existing instances if possible
config.prefer_to_spawn_tabs = true

config.enable_scroll_bar = true

-- I just use tmux instead
config.enable_tab_bar = false

return config
