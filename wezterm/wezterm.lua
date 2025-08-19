local wezterm = require 'wezterm'
local config = {}

local is_windows = true
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    is_windows = false
end

-- shell
if is_windows then
    config.default_prog = { 'pwsh.exe' }
end

-- Base
config.color_scheme = 'OneDark (base16)'
-- 根据屏幕分辨率设置，过大过小会导致下方留白
config.font_size = 17.5
-- 根据屏幕分辨率设置，过大过小会导致下方留白
config.line_height = 1.00

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

config.set_environment_variables = {
    CPP_EXTENSION_DEBUG_BIN = '',
}
if is_windows then
    config.set_environment_variables = {
        YAZI_FILE_ONE = 'D:\\env\\Git\\usr\\bin\\file.exe'
    }
end

return config
