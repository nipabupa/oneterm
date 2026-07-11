local M = {}

M.treesitter = {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {},
    opts = {},
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
        -- c & cpp
        vim.lsp.enable('clangd')
        -- json
        vim.lsp.enable('jsonls')
        -- nushell
        vim.lsp.enable('nushell')
        -- rust
        vim.lsp.enable('rust-analyzer')
        -- qml
        vim.lsp.enable('qmlls')
        -- qml
        vim.lsp.enable('gdscript')
    end
}

M.diagnostic = {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require('tiny-inline-diagnostic').setup({
            preset = "amongus",
            transparent_bg = true,
            add_messages = {
                display_count = true,
            },
            multilines = {
                enabled = true,
            },
        })
        vim.diagnostic.config({
            virtual_text = false,
            signs = false,
            underline = true,
            update_in_insert = false,
            severity_sort = true
        })
    end
}

return M
