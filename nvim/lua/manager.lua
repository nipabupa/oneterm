local ui = require('ui')
local code = require('code')
local edit = require('edit')
local search = require('search')
local git = require('git')


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://gitee.com/nipabupa/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        ui.colorscheme,
        ui.startup,
        ui.bufferline,
        ui.lualine,
        ui.neotree,
        ui.notice,
        edit.autopairs,
        edit.surround,
        edit.indentblankline,
        edit.comment,
        code.treesistter,
        code.lspconfig,
        code.luasnip,
        code.nvimcmp,
        code.linter,
        code.dap,
        code.dapui,
        search.fzflua,
        search.flash,
        search.marks,
        git.gitsigns,
        git.neogit,
    },
    checker = { enabled = false },
})

