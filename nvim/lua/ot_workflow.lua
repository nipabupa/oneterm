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
    opts = {
        mappings = {
            move_down  = '<C-j>',
            move_up    = '<C-k>',
        }
    },
    keys = {
        { "<leader>l", mode = { "n", "x", "o" }, function() MiniPick.builtin.resume() end, desc = "上一次查询" },
        { "<leader>f", mode = { "n", "x", "o" }, function() MiniPick.builtin.files() end, desc = "文件查找" },
        { "<leader>b", mode = { "n", "x", "o" }, function() MiniPick.builtin.buffers() end, desc = "Buffer查找" },
        { "<leader>g", mode = { "n", "x", "o" }, function()
            vim.ui.input({prompt = "Grep", default = vim.fn.expand("<cword>")}, function (word)
                if word ~= nil then
                    MiniPick.builtin.grep({pattern = word})
                end
            end);
        end, desc = "字符串查找" },
        { "<leader>G", mode = { "n", "x", "o" }, function() MiniPick.builtin.grep_live() end, desc = "字符串实时查找" },
        { "<leader>sd", mode = { "n", "x", "o" }, function() MiniExtra.pickers.lsp({scope = 'document_symbol'}) end, desc = "LSP文件符号查找" },
        { "<leader>sw", mode = { "n", "x", "o" }, function() MiniExtra.pickers.lsp({scope = 'workspace_symbol'}) end, desc = "LSP全局符号查找" },
        { "<leader>d", mode = { "n", "x", "o" }, function() MiniExtra.pickers.diagnostic() end, desc = "lsp问题查找" },
        { "<leader>c", mode = { "n", "x", "o" }, function() MiniExtra.pickers.commands() end, desc = "命令查找" },
        { "<leader>k", mode = { "n", "x", "o" }, function() MiniExtra.pickers.keymaps() end, desc = "快捷键查找" },
        { "<leader>h", mode = { "n", "x", "o" }, function() MiniExtra.pickers.history() end, desc = "历史命令查找" },
        { "<leader>p", mode = { "n", "x", "o" }, function() MiniExtra.pickers.hipatterns() end, desc = "特殊高亮查找" },
        { "<leader>r", mode = { "n", "x", "o" }, function() MiniExtra.pickers.registers() end, desc = "寄存器查找" },
    }
}

M.flash = {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "ss", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "<c-c>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}

M.blink = {
    'saghen/blink.cmp',
    version = '1.*',
    event = "VeryLazy",
    opts = {
        cmdline = {
            enabled = true,
            keymap = {
                preset = 'none',
                ['<Tab>'] = { 'accept', 'select_next' },
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-c>'] = { 'cancel', 'fallback' },
            },
        },
        keymap = {
            preset = 'none',
            ['<CR>'] = { 'select_and_accept', 'fallback' },
            ['<Tab>'] = { 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
            ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-c>'] = { 'cancel', 'fallback' },
            ['<C-p>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        appearance = {
            kind_icons = {
                Text = '󰭷 ',
                Method = ' ',
                Function = '󰊕 ',
                Constructor = '󰒓 ',
                Field = '󰜢 ',
                Variable = '󰆦 ',
                Property = '󰖷 ',
                Class = ' ',
                Interface = ' ',
                Struct = ' ',
                Module = '󰅩 ',
                Unit = ' ',
                Value = ' ',
                Enum = ' ',
                EnumMember = ' ',
                Keyword = '󰌆 ',
                Constant = ' ',
                Snippet = ' ',
                Color = '󰏘 ',
                File = '󰈔 ',
                Reference = '󰬲 ',
                Folder = '󰉋 ',
                Event = '󱐋 ',
                Operator = '󰪚 ',
                TypeParameter = '󰬛 ',
            },
        },
        signature = {
            enabled = true,
        }
    },
    opts_extend = { "sources.default" }
}

return M
