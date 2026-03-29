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

-- 缩进支持
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

M.extra = {
    'nvim-mini/mini.extra',
    version = '*',
    event = "VeryLazy",
    opts = {},
}

-- 特殊字符高亮
M.highlight = {
    'nvim-mini/mini.hipatterns',
    version = '*',
    event = "VeryLazy",
    opts = {},
}

-- ai增强
M.ai = {
    'nvim-mini/mini.ai',
    version = '*',
    event = "VeryLazy",
    opts = {},
}

return M
