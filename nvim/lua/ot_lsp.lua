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
        vim.lsp.config('lua_ls', {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath('config')
                        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                    then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT',
                        path = {
                            'lua/?.lua',
                            'lua/?/init.lua',
                        },
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        -- library = {
                          -- vim.env.VIMRUNTIME,
                          -- Depending on the usage, you might want to add additional paths
                          -- here.
                          -- '${3rd}/luv/library',
                          -- '${3rd}/busted/library',
                        -- },
                        -- Or pull in all of 'runtimepath'.
                        -- NOTE: this is a lot slower and will cause issues when working on
                        -- your own configuration.
                        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                        library = vim.api.nvim_get_runtime_file('', true),
                    },
                })
            end,
            settings = {
                Lua = {},
            },
        })
        -- lua
        vim.lsp.enable('lua_ls')
        -- python
        vim.lsp.enable('ty')
        -- cpp
        vim.lsp.enable('clangd')
        -- rust
        vim.lsp.enable('rust-analyzer')
        -- qml
        vim.lsp.enable('qmlls')
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
