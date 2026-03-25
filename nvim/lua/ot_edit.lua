local M = {}


-- 自动括号补全
M.pairs = {
    'nvim-mini/mini.pairs',
    version = '*',
    event = "InsertEnter",
    opts = {},
}


M.surround = {
    'nvim-mini/mini.surround',
    version = '*',
    event = "VeryLazy",
    opts = {},
}


-- 换行支持
M.indent = {
    'nvim-mini/mini.indentscope',
    version = '*',
    opts = {},
}


-- 注释
M.comment = {
    'nvim-mini/mini.comment',
    version = '*',
    event = "InsertEnter",
    opts = {},
}


return M
