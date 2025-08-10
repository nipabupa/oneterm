local git = {}


-- git改动显示
git.gitsigns = {
    'lewis6991/gitsigns.nvim',
    opts = {},
    config = function()
        local gitsigns = require('gitsigns')
        local opts = {silent=true, remap=false}
        vim.keymap.set('n', '<leader>gp', function() gitsigns.preview_hunk_inline() end, opts)
        vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line() end, opts)
        vim.keymap.set('n', '<leader>gd', function() gitsigns.diffthis() end, opts)
    end
}


-- 交互式git
git.neogit = {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "ibhagwan/fzf-lua",
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

    keys = {
        {'<f2>', '<cmd>Neogit<cr>', desc='打开Git'}
    }
}


return git
