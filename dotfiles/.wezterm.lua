local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- actually use regular bash cuh
config.default_prog = { "bash" }

config.initial_rows = 32
config.initial_cols = 120

config.switch_to_last_active_tab_when_closing_tab = true

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font_with_fallback {
    "Monaspace Neon Frozen",
    "monospace",
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

-- I just use tmux instead
config.enable_tab_bar = false

-- ignore missing glyphs because they only appear very occasionally in journalctl
-- and I will notice if they're a problem anyways
config.warn_about_missing_glyphs = false

return config
