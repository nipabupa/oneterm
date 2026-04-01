local ui = require('ot_ui')
local edit = require('ot_edit')
local workflow = require('ot_workflow')
local lsp = require('ot_lsp')
local git = require('ot_git')
local dap = require('ot_dap')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
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
        ui.icons,
        ui.colorscheme,
        ui.startup,
        ui.bufferline,
        ui.lualine,
        ui.notice,
        ui.whichkey,
        edit.pairs,
        edit.surround,
        edit.indent,
        edit.comment,
        edit.highlight,
        edit.ai,
        edit.extra,
        workflow.files,
        workflow.pick,
        workflow.flash,
        lsp.treesitter,
        lsp.lspconfig,
        lsp.diagnostic,
        lsp.blink,
        git.gitsigns,
        git.neogit,
        dap.dap,
        dap.dapview,
    },
    checker = { enabled = false },
})

