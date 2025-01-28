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
config.font_size = 11

config.window_padding = {
    left = "15px",
    right = "15px",
    top = "15px",
    bottom = "15px",
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

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
  	window:gui_window():focus()
  	window:gui_window():focus()
  	window:gui_window():focus()
end)

-- Open new wezterms in existing instances if possible
prefer_to_spawn_tabs = true

return config
