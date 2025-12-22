-- This module adds bindings similar to tmux with some changes

local wezterm = require("wezterm")

local module = {}

local function convert_pane_to_tab(win, pane)
    local tab, window = pane:move_to_new_tab()
    tab:activate()
end

function module.apply_to_config(config)
    local act = wezterm.action
    config.keys = {
        -- Send leader to terminal when pressed twice
        { key = config.leader.key, mods = "LEADER|" .. config.leader.mods, action = act.SendKey(config.leader)},
        { key = "-", mods = "LEADER", action = act.SplitVertical({ domain="CurrentPaneDomain" }) },
            -- non-standard
        { key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain="CurrentPaneDomain" }) },
            -- non-standard
        { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
        { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
        { key = "LeftArrow", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
        { key = "DownArrow", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
        { key = "UpArrow", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
        { key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
        { key = "LeftArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },
        { key = "DownArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Down", 5 }) },
        { key = "UpArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Up", 5 }) },
        { key = "RightArrow", mods = "LEADER|CTRL", action = act.AdjustPaneSize({ "Right", 5 }) },
        { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
        { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
        { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
        { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
        { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
        { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
        { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
        { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
        { key = "9", mods = "LEADER", action = act.ActivateTab(8) },
        { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
        { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
        { key = 'LeftArrow', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(-1) }, -- non-standard
        { key = 'RightArrow', mods = 'LEADER|SHIFT', action = act.MoveTabRelative(1) }, -- non-standard
        { key = "&", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm=true }) },
        { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm=true }) },
        { key = "n", mods = "SHIFT|CTRL", action = "ToggleFullScreen" },
        { key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom 'Clipboard' },
        { key = "c", mods = "SHIFT|CTRL", action = act.CopyTo 'Clipboard' },
        { key = "+", mods = "SHIFT|CTRL", action = "IncreaseFontSize" },
        { key = "-", mods = "SHIFT|CTRL", action = "DecreaseFontSize" },
        { key = "0", mods = "SHIFT|CTRL", action = "ResetFontSize" },
        { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
        { key = '!', mods = 'LEADER|SHIFT', action = wezterm.action_callback(convert_pane_to_tab) },
    }
end

return module
