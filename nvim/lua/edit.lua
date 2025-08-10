local edit = {}


-- 自动括号补全
edit.autopairs = {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
}


edit.surround = {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {}
}


-- 换行支持
edit.indentblankline = {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        scope = {
            enabled = false
        },
    },
}


-- 注释
edit.comment = {
    'numToStr/Comment.nvim',
    event = "InsertEnter",
    opts = {}
}


return edit
