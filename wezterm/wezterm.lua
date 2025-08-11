local wezterm = require 'wezterm'
local config = {}

local is_windows = false
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    is_windows = true
end

-- Base
config.color_scheme = 'OneDark (base16)'
-- config.font = wezterm.font 'DejaVuSansM Nerd Font Mono'
config.font_size = 18

-- Window
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.window_background_opacity = 0.95


config.keys = {
    {
        key = '[',
        mods = 'ALT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    }, {
        key = ']',
        mods = 'ALT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    }, {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { "Up", 1 },
    }, {
        key = 'j',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { "Down", 1 },
    }, {
        key = 'h',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { "Left", 1 },
    }, {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { "Right", 1 },
    }, {
        key = 'k',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Up',
    }, {
        key = 'j',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Down',
    }, {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Left',
    }, {
        key = 'l',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Right',
    }
}

return config
