local ui = {}


-- 主题
ui.colorscheme = {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
        require('onedark').setup {
            style = 'cool'
        }
        -- Enable theme
        require('onedark').load()
    end
}


-- 启动界面
ui.startup = {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
};


-- bufferline
ui.bufferline = {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup({
            options = {
                max_name_length = 10,
                max_prefix_length = 10,
                tab_size = 10,
                diagnostics = false,
                color_icons = true,
                separator_style = 'slant',
                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'Files',
                        text_align = 'center',
                        hightlight = 'Directory',
                        separator = true
                    }
                },
            },
        })
        vim.keymap.set('n', "<leader>bp", "<cmd>BufferLineTogglePin<cr>", {remap=false, desc='固定Buffer'})
        vim.keymap.set('n', "<leader>b1", "<cmd>BufferLineGoToBuffer 1<cr>", {remap=false, desc='跳转Buffer 1'})
        vim.keymap.set('n', "<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", {remap=false, desc='跳转Buffer 2'})
        vim.keymap.set('n', "<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", {remap=false, desc='跳转Buffer 3'})
        vim.keymap.set('n', "<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", {remap=false, desc='跳转Buffer 4'})
        vim.keymap.set('n', "<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", {remap=false, desc='跳转Buffer 5'})
        vim.keymap.set('n', "<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>", {remap=false, desc='跳转Buffer 6'})
        vim.keymap.set('n', "<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>", {remap=false, desc='跳转Buffer 6'})
        vim.keymap.set('n', "<leader>bc", "<cmd>BufferLineCloseOthers<cr>", {remap=false, desc='关闭其他buffer'})
    end
}


-- lualine
ui.lualine = {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = "",
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = { 
                    'neo-tree',
                    'dapui_watches',
                    'dapui_stacks',
                    'dapui_breakpoints',
                    'dapui_scopes',
                    'dap-repl',
                },
                winbar = {},
            },
        },
        sections = {
            lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
            lualine_b = { 'filename', 'branch' },
            lualine_c = { 'diagnostics' },
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {
              { 'location', separator = { right = '' }, left_padding = 2 },
            },
        },
        inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
    }
}



-- neotree
ui.neotree = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        enable_diagnostics = false,
        window = {
            width = 25
        }
    },
    keys = {
        {"<leader>nn", "<cmd>Neotree filesystem left toggle<cr>", remap=false, desc='打开文件系统'},
        {"<leader>nb", "<cmd>Neotree buffers float toggle<cr>", remap=false, desc='打开当前buffer列表'},
        {"<leader>ng", "<cmd>Neotree git_status float toggle<cr>", remap=false, desc='打开当前git改动列表'},
        {"<leader>nf", "<cmd>Neotree filesystem reveal left<cr>", remap=false, desc='定位到当前文件'},
    }
}


ui.notice = {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
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
        { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Whick Key?", },
    },
}

return ui
