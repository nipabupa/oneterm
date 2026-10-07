---------------------------------
-- 全局配置
---------------------------------
vim.opt.sw            = 4                   -- 设置缩进宽度
vim.opt.ts            = 4                   -- 设置 TAB 宽度
vim.opt.et            = true                -- 展开tab
vim.opt.softtabstop   = 4                   -- 如果后面设置了 expandtab 那么展开 tab 为多少字符
vim.env.CC = "gcc"

local is_windows = package.config:sub(1, 1) == "\\"
----------------------------------
-- 全局自定义快捷键
----------------------------------
local opts = {silent=true, remap=false}
-- 清除高亮
vim.keymap.set('n', '<C-z>', ':noh<cr>', opts)
-- 切换上一个buffer
vim.keymap.set('n', '<S-Tab>', ':bp<cr>', opts)
-- 切换下一个buffer
vim.keymap.set('n', '<Tab>', ':bn<cr>', opts)
-- 关闭buffer
vim.keymap.set('n', '<c-q>', function() vim.cmd.bdelete({bang=true}) end, opts)
-- Home
vim.keymap.set({'n', 'i', 'x', 'c'}, '<c-a>', '<Home>', opts)
-- End
vim.keymap.set({'n', 'i', 'x', 'c'}, '<c-e>', '<End>', opts)
----------------------------------
-- Mini库
----------------------------------
vim.pack.add({
    { src = 'https://gitee.com/nipabupa/mini.nvim', version = 'stable' },
})
--------------------------------
-- 配色方案
--------------------------------
vim.pack.add({
    { src = "https://gitee.com/nipabupa/catppuccin", name = "catppuccin" }
})
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
})
vim.cmd.colorscheme "catppuccin-nvim"
--------------------------------
-- 基础配置
--------------------------------
require('mini.basics').setup({
    options = {
        basic = true,                   -- Basic options ('number', 'ignorecase', and many more)
    	extra_ui = false,               -- Extra UI features ('winblend', 'listchars', 'pumheight', ...)
    	win_borders = 'auto',           -- Presets for window borders ('single', 'double', ...)
    },
    mappings = {
    	basic = true,                   -- Basic mappings (better 'jk', save with Ctrl+S, ...)
    	option_toggle_prefix = [[\]],
    	windows = true,                 -- Window navigation with <C-hjkl>, resize with <C-arrow>
    	move_with_alt = true,           -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
    },
    autocommands = {
        basic = true,                   -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
        relnum_in_visual_mode = false,  -- Set 'relativenumber' only in linewise and blockwise Visual mode
    },
    silent = false,                     -- Whether to disable showing non-error feedback
})
require('mini.extra').setup()
----------------------------------
-- UI
----------------------------------
require('mini.icons').setup()
require('mini.tabline').setup()
require('mini.statusline').setup()
require('mini.bufremove').setup()
-- require('mini.statuscolumn').setup()
require('mini.git').setup()
require('mini.indentscope').setup()
require('mini.notify').setup()
require('mini.cmdline').setup()
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
-- 编辑
----------------------------------
require('mini.ai').setup()
require('mini.align').setup()
require('mini.completion').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.trailspace').setup()
require('mini.bracketed').setup()
require('mini.jump').setup()
require('mini.jump2d').setup()
----------------------------------
-- 文件管理
----------------------------------
require('mini.files').setup()
vim.keymap.set( {'n', 'x', 'o' }, '<leader>e', function()
    local tmp = vim.api.nvim_buf_get_name(0)
    if tmp == nil or tmp == "" then
        MiniFiles.open()
    else
        MiniFiles.open(tmp)
    end
end, { desc="打开文件管理器", silent=true, remap=false })
----------------------------------
-- 快捷键提示
----------------------------------
local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = { 'n', 'x' }, keys = '<Leader>' },
        -- `[` and `]` keys
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },
        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },
        -- `g` key
        { mode = { 'n', 'x' }, keys = 'g' },
        -- Marks
        { mode = { 'n', 'x' }, keys = "'" },
        { mode = { 'n', 'x' }, keys = '`' },
        -- Registers
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },
        -- Window commands
        { mode = 'n', keys = '<C-w>' },
        -- `z` key
        { mode = { 'n', 'x' }, keys = 'z' },
    },
    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})
--------------------------------
-- 搜索
--------------------------------
require('mini.pick').setup()
vim.keymap.set({ "n", "x", "o" }, '<leader>l', function() MiniPick.builtin.resume() end, { desc="上一次查询结果", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>f', function() MiniPick.builtin.files() end, { desc="文件查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>b', function() MiniPick.builtin.buffers() end, { desc="Buffer查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>g', function()
    vim.ui.input({prompt = "󰈞 ", default = vim.fn.expand("<cword>")}, function (word)
        if word ~= nil then
            MiniPick.builtin.grep({pattern = word})
        end
    end);
end, { desc="字符串查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>G', function() MiniPick.builtin.grep_live() end, { desc="字符串实时查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>sd', function() MiniExtra.pickers.lsp({scope = 'document_symbol'}) end, { desc="LSP文件符号查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>sw', function() MiniExtra.pickers.lsp({scope = 'workspace_symbol'}) end, { desc="LSP全局符号查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>d', function() MiniExtra.pickers.diagnostic() end, { desc="LSP问题查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>c', function() MiniExtra.pickers.commands() end, { desc="命令查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>k', function() MiniExtra.pickers.keymaps() end, { desc="快捷键查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>h', function() MiniExtra.pickers.history() end, { desc="历史命令查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>p', function() MiniExtra.pickers.hipatterns() end, { desc="特殊高亮查找", silent=true, remap=false })
vim.keymap.set({ "n", "x", "o" }, '<leader>r', function() MiniExtra.pickers.registers() end, { desc="寄存器查找", silent=true, remap=false })
--------------------------------
-- treesitter配置
--------------------------------
vim.pack.add{
    { src = 'https://gitee.com/nipabupa/nvim-treesitter' },
}
--------------------------------
-- LSP配置
--------------------------------
vim.pack.add{
    { src = 'https://gitee.com/nipabupa/nvim-lspconfig' },
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
--  特殊快捷键
----------------------------------
local map_multistep = require('mini.keymap').map_multistep
map_multistep('i', '<Tab>',   { 'pmenu_next' })
map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
map_multistep('i', '<BS>',    { 'minipairs_bs' })

local map_combo = require('mini.keymap').map_combo
local mode = { 'i', 'c', 'x', 's' }
map_combo(mode, 'jk', '<BS><BS><Esc>')
map_combo(mode, 'kj', '<BS><BS><Esc>')
map_combo('t', 'jk', '<BS><BS><C-\\><C-n>')
map_combo('t', 'kj', '<BS><BS><C-\\><C-n>')
----------------------------------
-- LSP提示
----------------------------------
vim.pack.add{
    { src = 'https://gitee.com/nipabupa/tiny-inline-diagnostic.nvim' },
}
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
