local M = {}

M.files = {
    'nvim-mini/mini.files',
    version = '*',
    event = "VeryLazy",
    opts = {},
    keys = {
        { "<leader>e", mode = { "n", "x", "o" }, function() MiniFiles.open() end, desc = "文件树" },
    }
}

M.pick = {
    'nvim-mini/mini.pick',
    version = '*',
    event = "VeryLazy",
    opts = {},
    keys = {
        { "<leader>f", mode = { "n", "x", "o" }, function() MiniPick.builtin.files() end, desc = "文件查找" },
        { "<leader>bb", mode = { "n", "x", "o" }, function() MiniPick.builtin.buffers() end, desc = "Buffer查找" },
        { "<leader>g", mode = { "n", "x", "o" }, function() MiniPick.builtin.grep() end, desc = "字符串查找" },
        { "<leader>G", mode = { "n", "x", "o" }, function() MiniPick.builtin.live_grep() end, desc = "字符串实时查找" },
    }
}


M.flash = {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "<c-c>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}

return M
