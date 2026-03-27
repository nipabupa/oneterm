local M = {}


M.treesitter = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        vim.api.nvim_create_autocmd('FileType', {
          pattern = { 'lua', 'python' },
          callback = function() vim.treesitter.start() end,
        })
    end
}


M.lspconfig = {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    config = function()
        vim.lsp.enable('ty')
        vim.lsp.enable('clangd')
    end
}


M.diagnostic = {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require('tiny-inline-diagnostic').setup({
            preset = "simple",
        })
        vim.diagnostic.config({
            virtual_text = false,
            signs = {
                text = { 
                    [vim.diagnostic.severity.ERROR] = ' ',
                    [vim.diagnostic.severity.WARN] = ' ',
                    [vim.diagnostic.severity.INFO] = ' ',
                    [vim.diagnostic.severity.HINT] = '',
                }
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true
        })
    end
}


M.blink = {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
        cmdline = { 
            enabled = true,
            keymap = {
                preset = 'none',
                ['<Tab>'] = { 'show_and_insert', 'select_next' },
                ['<S-Tab>'] = { 'show_and_insert', 'select_prev' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
            },
            completion = { menu = { auto_show = true } },
        },
        keymap = { 
            preset = 'none',
            ['<CR>'] = { 'select_and_accept', 'fallback' },
            ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
            ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
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
