local M = {}


-- git改动显示
M.gitsigns = {
    'lewis6991/gitsigns.nvim',
    opts = {},
    config = function()
        local gitsigns = require('gitsigns')
        local opts = {silent=true, remap=false}
        vim.keymap.set('n', '<leader>vp', function() gitsigns.preview_hunk_inline() end, {silent=true, remap=false, desc="Git改动预览"})
        vim.keymap.set('n', '<leader>vb', function() gitsigns.blame_line() end, {silent=true, remap=false, desc="Git blame"})
        vim.keymap.set('n', '<leader>vd', function() gitsigns.diffthis() end, {silent=true, remap=false, desc="Git diff"})
    end
}


-- 交互式git
M.neogit = {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-mini/mini.pick",
    },
    opts = {
        signs = {
            hunk = { "", "" },
            item = { "", "" },
            section = { "", "" },
        },
        graph_style = 'unicode',
        integrations = {
            diffview = true,
            fzf_lua = true,
        },
        status = {
            mode_padding = 1,
            mode_text = {
                M = "",
                N = "",
                A = "",
                D = "󰆴",
                C = "",
                U = "",
                R = "",
                DD = "",
                AU = "",
                UD = "",
                UA = "",
                DU = "",
                AA = "",
                UU = "",
                ["?"] = "",
            },
        },
    },
    cmd = "Neogit",
    keys = {
        {'<f2>', '<cmd>Neogit<cr>', desc='打开Git'}
    }
}


return M
