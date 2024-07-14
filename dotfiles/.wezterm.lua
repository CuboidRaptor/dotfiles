local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- actually use regular bash cuh
config.default_prog = { "bash" }

local set_environment_variables = {
  PATH = wezterm.home_dir .. '/.cargo/bin:' .. os.getenv('PATH')
}

config.initial_rows = 25
config.initial_cols = 90

config.switch_to_last_active_tab_when_closing_tab = true

config.default_cursor_style = "BlinkingBar"
config.colors = {
    foreground = "#69b8f5",
    background = "#2a113d",
    cursor_border = "#69b8f5",
    selection_fg = "#69acf5",
    selection_bg = "#b930a5"
}
config.window_frame = {
    font = wezterm.font { family = "Kollektif", weight = "Medium" },
    font_size = 12.0,
    active_titlebar_bg = "#220e31",
    inactive_titlebar_bg = "#220e31"
}
config.window_background_gradient = {
    colors = { "#2a113d", "#311875" },
    orientation = { Linear = { angle = -45.0 } }
}

config.font = wezterm.font_with_fallback {
    "CaskaydiaMono Nerd Font Mono",
    "Consolas",
    "DengXian"
}
config.font_size = 11

config.window_padding = {
    left = "20px",
    right = "20px",
    top = "20px",
    bottom = "20px",
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
    {
        key = "v",
        mods = "CTRL",
        action = act.PasteFrom "Clipboard"
    },
    {
        key = "w",
        mods = "CTRL",
        action = wezterm.action.CloseCurrentTab { confirm = false }
    },
    {
        key = "t",
        mods = "CTRL",
        action = act.SpawnTab { DomainName = "unix" }
    }
}

return config
