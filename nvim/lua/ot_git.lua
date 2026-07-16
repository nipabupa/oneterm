local M = {}


-- git改动显示
M.gitsigns = {
    'lewis6991/gitsigns.nvim',
    opts = {},
    event = "VeryLazy",
    config = function()
        local gitsigns = require('gitsigns')
        vim.keymap.set('n', '<leader>vp', function() gitsigns.preview_hunk_inline() end, {silent=true, remap=false, desc="Git改动预览"})
        vim.keymap.set('n', '<leader>vb', function() gitsigns.blame_line() end, {silent=true, remap=false, desc="Git blame"})
        vim.keymap.set('n', '<leader>vd', function() gitsigns.diffthis() end, {silent=true, remap=false, desc="Git diff"})
        vim.keymap.set('n', '<leader>vg', function() MiniExtra.pickers.git_hunks() end, {silent=true, remap=false, desc="Git Hunk"})
    end
}

return M
