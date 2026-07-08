local ui = {}

ui.icons = {
    "nvim-mini/mini.icons",
    opts = {},
}

-- 主题
ui.colorscheme = {
    "catppuccin/nvim",
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato",  -- latte, frappe, macchiato, mocha
            transparent_background = true
        })
        vim.cmd.colorscheme "catppuccin-nvim"
    end
}

-- 启动界面
ui.startup = {
    "goolord/alpha-nvim",
    config = function ()
        local startify = require("alpha.themes.startify")
        -- available: devicons, mini, default is mini
        -- if provider not loaded and enabled is true, it will try to use another provider
        startify.file_icons.provider = "mini"
        require("alpha").setup(startify.config)
    end
};

-- bufferline
ui.tabline = {
    'nvim-mini/mini.tabline',
    version = '*',
    opts = {}
}

-- lualine
ui.lualine = {
    "nvim-lualine/lualine.nvim",
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            globalstatus = true,
            component_separators = '|',
            always_show_tabline = false,
            section_separators = { left = '', right = ' ' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
        },
        sections = {
            lualine_a = { { 'mode', separator = { left = '', right = '' } } },
            lualine_b = { { 'branch', icon = '' } },
            lualine_c = { { 'filename',
                symbols = {
                    modified = '',
                    readonly = ' ',
                    unnamed = ' ',
                    newfile = ' ',
                }
            }, 'lsp_status', 'diagnostics' },
            lualine_x = {'encoding', 'fileformat'},
            lualine_y = {'filetype', 'progress'},
            lualine_z = {
              { 'location', separator = { left = '', right = '' }, left_padding = 2 },
            },
        },
        inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
    }
}


ui.notice = {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim"
    },
    event = "VeryLazy",
    opts = {
        messages = {
            enabled = true, -- enables the Noice messages UI
            view = "mini", -- default view for messages
            view_error = "mini", -- view for errors
            view_warn = "mini", -- view for warnings
            view_history = "messages", -- view for :messages
            view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        lsp = {
            hover = { enabled = false },
            signature = { enabled = false },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                -- override the default lsp markdown formatter with Noice
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                -- override the lsp markdown formatter with Noice
                ["vim.lsp.util.stylize_markdown"] = true,
                -- override cmp documentation with Noice (needs the other options to work)
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
    },
}

ui.whichkey = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = 'helix',
        triggers = {}
    },
    keys = {
        { "<leader>?", function() require("which-key").show({ global = true }) end, desc = "Whick Key?", },
    },
}

return ui
