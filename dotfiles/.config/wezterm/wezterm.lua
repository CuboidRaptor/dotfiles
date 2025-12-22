local wezterm = require("wezterm")
local wezterm_tmux = require("wezterm_tmux")
local config = wezterm.config_builder()

config.default_prog = { "zsh" }

config.prefer_to_spawn_tabs = true

config.initial_rows = 32
config.initial_cols = 120

config.switch_to_last_active_tab_when_closing_tab = true

config.color_scheme = "GruvboxDarkHard"

config.font = wezterm.font_with_fallback {
    "Cascadia Code NF",
    "monospace",
}
config.font_size = 12

config.leader = { key=" ", mods="CTRL", timeout_milliseconds=2000 }
wezterm_tmux.apply_to_config(config)

local act = wezterm.action
config.keys = {
    { key = "q", mods = "CTRL|SHIFT", action = act.QuitApplication },
    { key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },
    table.unpack(config.keys) -- module wezterm_tmux changes config.keys so we add those changes
}

-- ignore missing glyphs because they only appear very occasionally in journalctl
-- and I will notice if they're a problem anyways
config.warn_about_missing_glyphs = false

return config
