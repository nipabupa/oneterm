local search = {}


search.fzflua = {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        winopts = {
            height = 0.8,
            width = 0.9,
            preview = {
                hidden = true,
            },
        },
        keymap = {
            builtin = {
                ["?"] = "toggle-help",
                ["<C-p>"] = "toggle-preview",
            }
        },
        fzf_opts = {
            ["--style"] = "minimal"
        },
        files = {
            cwd_prompt = false,
        },
    },
    keys = {
        -- 文件搜索
        {'<leader>ff', function() require('fzf-lua').files() end, desc="查询文件"},
        {'<leader>fw', function() require('fzf-lua').grep_cword() end, desc="查询当前字符串"},
        {'<leader>fs', function() require('fzf-lua').grep() end, desc="查询字符串"},
        {'<leader>fs', function() require('fzf-lua').grep_visual() end, desc="查询选择的字符串", mode='v'},
        {'<leader>fb', function() require('fzf-lua').buffers() end, desc="查询buffer"},
        {'<leader>fo', function() require('fzf-lua').oldfiles() end, desc="查询历史打开的文件"},
        {'<leader>fr', function() require('fzf-lua').registers() end, desc="查询寄存器"},
        {'<leader>fk', function() require('fzf-lua').keymaps() end, desc="查询快捷键"},
        {'<leader>fm', function() require('fzf-lua').marks() end, desc="查询mark"},
        {'<leader>fc', function() require('fzf-lua').commands() end, desc="查询命令"},
        {'<leader>fe', function() require('fzf-lua').resume() end, desc="重复上一次"},
        -- 符号查询
        {'<leader>sd', function() require('fzf-lua').lsp_document_symbols() end, desc="查询当前文档符号"},
        {'<leader>sg', function() require('fzf-lua').lsp_live_workspace_symbols() end, desc="查询工作区符号"},
        {'<leader>st', function() require('fzf-lua').treesitter() end, desc="查询treesitter符号"},
        -- 问题查询
        {'<leader>dd', function() require('fzf-lua').diagnostics_document() end, desc="查询当前文档问题"},
        {'<leader>dw', function() require('fzf-lua').diagnostics_workspace() end, desc="查询工作区问题"},
        -- lsp查询
        {'<leader>lr', function() require('fzf-lua').lsp_references() end, desc="查询所有引用"},
        {'<leader>li', function() require('fzf-lua').lsp_implementations() end, desc="查询所有实现"},
        {'<leader>lf', function() require('fzf-lua').lsp_finder() end, desc="查询所有LSP信息"},
    }
}


search.flash = {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "<c-c>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}


search.marks = {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
        bookmark_0 = { sign = '󰎣' },
        bookmark_1 = { sign = '󰎦' },
        bookmark_2 = { sign = '󰎩' },
        bookmark_3 = { sign = '󰎬' },
        bookmark_4 = { sign = '󰎮' },
        bookmark_6 = { sign = '󰎰' },
        bookmark_6 = { sign = '󰎵' },
        bookmark_7 = { sign = '󰎸' },
        bookmark_8 = { sign = '󰎻' },
        bookmark_9 = { sign = '󰎾' },
        mappings = {
            toggle = false,
            set_next = false,
            next = 'mj',
            prev = 'mk',
            preview = 'mp',
            next_bookmark = 'ml',
            prev_bookmark = 'mh',
            annotate = 'mi'
        }
    },
}

return search
