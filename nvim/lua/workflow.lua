local is_windows = package.config:sub(1, 1) == "\\"
----------------------------------
-- Snippet
----------------------------------
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
    snippets = {
        gen_loader.from_file(is_windows and '~/AppData/Local/nvim/snippets/global.json' or '~/.config/nvim/snippets/global.json'),
        gen_loader.from_lang(),
    }
})
----------------------------------
-- git
----------------------------------
require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = ' ', change = ' ', delete = ' ' },
    priority = 199,
  },
})
vim.keymap.set( {'n', 'x', 'o' }, '<leader>p', function()
    MiniDiff.toggle_overlay(0)
end, { desc="git改动预览", silent=true, remap=false })
--------------------------------
-- treesitter配置
--------------------------------
vim.pack.add{
    -- { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'git@gitee.com:nipabupa/nvim-treesitter' },
}
--------------------------------
-- LSP配置
--------------------------------
vim.pack.add{
    -- { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'git@gitee.com:nipabupa/nvim-lspconfig' },
}

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
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
                },
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
-- qml
vim.lsp.enable('qmlls')

----------------------------------
-- 行内diagnostic配置
----------------------------------
vim.diagnostic.config({
    float = {
        -- 或者使用字符数组自定义: { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
        border = "rounded",
        header = "",          -- 移除默认的 "Diagnostics" 标题，节省空间
        source = "if_many",   -- 仅在多个源时显示来源
        -- prefix = " ",      -- 消息前的前缀
    },
})
vim.keymap.set("n", "<C-x>", function()
    vim.diagnostic.open_float()
end, { silent = true, remap = false, desc = '显示当前diagnostic'})
