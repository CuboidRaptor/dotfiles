local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- use zsh
-- config.default_prog = { "zsh" }
config.default_prog = { "tmux", "new", "-As0" }

config.initial_rows = 32
config.initial_cols = 120

config.switch_to_last_active_tab_when_closing_tab = true

config.color_scheme = "GruvboxDarkHard"

config.font = wezterm.font_with_fallback {
    "Cascadia Code NF",
    "monospace",
}
config.font_size = 12

local act = wezterm.action
config.keys = {
    { key = "q", mods = "CTRL|SHIFT", action = act.QuitApplication },
    { key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },
}

-- I just use tmux instead
config.enable_tab_bar = false

-- ignore missing glyphs because they only appear very occasionally in journalctl
-- and I will notice if they're a problem anyways
config.warn_about_missing_glyphs = false

-- tmux typ shi
config.window_close_confirmation = "NeverPrompt"

return config
