local wezterm = require 'wezterm'
local config = {}
local home = os.getenv 'HOME'
local is_windows = false
local is_linux = false
local is_macos = false

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    is_windows = true
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    is_linux = true
else
    is_macos = true
end

local function generate_path()
    local new_path = ''
    if is_macos then
        -- macports does not have codelldb, install it manually
        local codelldb = home .. '/.local/share/codelldb/extension/adapter/:'
        local macports = '/opt/local/bin/:/opt/local/sbin/:'
        new_path = new_path .. codelldb .. macports
    end
    local uv = home .. '/.local/bin/:'
    return new_path .. uv .. os.getenv 'PATH'
end

-- common variables
config.set_environment_variables = {
    ONETERM = home .. '/oneterm',
    PATH = generate_path(),
}

-- nushell
config.default_prog = { 'nu' }

-- theme
config.color_scheme = 'Catppuccin Frappe'
-- 字体与emoji
config.font = wezterm.font_with_fallback { 'JetBrains Mono', 'Noto Color Emoji' }
-- 根据屏幕分辨率设置，过大过小会导致下方留白
config.font_size = 25
-- 根据屏幕分辨率设置，过大过小会导致下方留白
config.line_height = 1.2
-- Window
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
-- 无边框TITLE | RESIZE
config.window_decorations = "NONE"
-- 透明度
config.window_background_opacity = 0.9

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
        key = 'UpArrow',
        mods = 'CTRL',
        action = wezterm.action.AdjustPaneSize { "Up", 1 },
    }, {
        key = 'DownArrow',
        mods = 'CTRL',
        action = wezterm.action.AdjustPaneSize { "Down", 1 },
    }, {
        key = 'LeftArrow',
        mods = 'CTRL',
        action = wezterm.action.AdjustPaneSize { "Left", 1 },
    }, {
        key = 'RightArrow',
        mods = 'CTRL',
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
