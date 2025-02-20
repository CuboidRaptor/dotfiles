local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- actually use regular bash cuh
config.default_prog = { "bash" }

config.initial_rows = 34
config.initial_cols = 130

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
    left = "10px",
    right = "10px",
    top = "10px",
    bottom = "10px",
}

-- copy/paste with mouse go brrrrrr
local act = wezterm.action
config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wezterm.action_callback(function(window, pane)
        local has_selection = window:get_selection_text_for_pane(pane) ~= ""
        if has_selection then
            window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
            window:perform_action(act.ClearSelection, pane)
        else
            window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
        end
        end),
    },
}

config.keys = {
    { key = "q", mods = "CTRL|SHIFT", action = wezterm.action.QuitApplication },
    { key = "{", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
    { key = "}", mods = "SHIFT|ALT", action = act.MoveTabRelative(1) },
    { key = "Tab", mods = "CTRL", action = act.DisableDefaultAssignment }, -- unbind a buncha keys so I can use them in neovim
    { key = "Tab", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment }
}

-- Open new wezterms in existing instances if possible
config.prefer_to_spawn_tabs = true

config.enable_scroll_bar = true

return config
