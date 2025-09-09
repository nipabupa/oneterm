local code = {}
local utils = require('utils')


code.treesistter = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "lua", "python" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}


code.lspconfig = {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    config = function()
        vim.lsp.enable('pyright')
        vim.lsp.enable('clangd')
    end
}


code.diagnostic = {
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


code.blink = {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
        cmdline = { 
            enabled = true,
            keymap = {
                preset = 'none',
                ['<CR>'] = { 'select_accept_and_enter', 'fallback' },
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
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
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


code.linter = {
    'mfussenegger/nvim-lint',
    event = "VeryLazy",
    config = function()
        require('lint').linters_by_ft = {
            python = {'flake8'},
        }
        -- path/to/file:line:col: code message
        local pattern = '[^:]+:(%d+):(%d+):(%w+):(.+)'
        local groups = { 'lnum', 'col', 'code', 'message' }
        require('lint').linters.flake8 = {
            cmd = 'flake8',
            stdin = true,
            args = {
                '--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s',
                '--no-show-source',
                '--max-line-length=200',
                '--stdin-display-name',
                function() return vim.api.nvim_buf_get_name(0) end,
                '-',
            },
            ignore_exitcode = true,
            parser = require('lint.parser').from_pattern(pattern, groups, nil, {
                ['source'] = 'flake8',
                ['severity'] = vim.diagnostic.severity.WARN,
            }),
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}


code.dap = {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    dependencies = {
        'mfussenegger/nvim-dap-python',
    },
    config = function()
        vim.fn.sign_define('DapBreakpoint', {text='', texthl='ErrorMsg', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='ErrorMsg', linehl='', numhl=''})
        vim.fn.sign_define('DapLogPoint', {text='', texthl='', linehl='ErrorMsg', numhl=''})
        vim.fn.sign_define('DapStopped', {text='', texthl='Substitute', linehl='', numhl=''})
        -- Python
        require('dap-python').setup('python')
        -- C
        local dap = require('dap')
        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = os.getenv('CPP_EXTENSION_DEBUG_BIN'),
            options = not utils.is_windows,
        }
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = utils.is_windows and vim.fn.getcwd() .. '\\build\\debug.exe' or vim.fn.getcwd() .. '/build/debug',
                cwd = '${workspaceFolder}',
                stopAtEntry = false,
            }
        }
        dap.configurations.c = dap.configurations.cpp
    end,
    keys = {
        {'<F3>', function() require('dap').toggle_breakpoint({condition = vim.fn.input('Condition: ')}) end, desc='设置断点'},
        {'<F4>', function() require('dap').toggle_breakpoint() end, desc='设置断点'},
        {'<F5>', function() require('dap').continue() end, desc='启动继续'},
        {'<F12>', function() require('dap').terminate() end, desc='终止'},
        {'<F6>', function() require('dap').step_over() end, desc='下一行'},
        {'<F7>', function() require('dap').step_into() end, desc='进入'},
        {'<F8>', function() require('dap').step_out() end, desc='跳出'},
    }
}


code.dapui = {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup({
            layouts = { {
                elements = { 
                    { id = "scopes", size = 1 }
                },
                position = "right",
                size = 40
              }, {
                elements = { 
                    { id = "watches", size = 0.5 },
                    { id = "console", size = 0.5 }
                },
                position = "bottom",
                size = 10
            } },
        })
        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end
    end,
    keys = {
        {'<leader>dc', function() require('dapui').close() end, desc='关闭调试UI'},
        {'<leader>dw', function() require('dapui').float_element('watches', {
            width = 80, height = 20, enter = true, position = 'center'
        }) end, desc='打开调试UI-监控'},
        {'<leader>dr', function() require('dapui').float_element('repl', {
            width = 80, height = 20, enter = true, position = 'center'
        }) end, desc='打开调试UI-REPL'},
        {'<leader>ds', function() require('dapui').float_element('stacks', {
            width = 80, height = 20, enter = true, position = 'center'
        }) end, desc='打开调试UI-堆栈'},
        {'<leader>db', function() require('dapui').float_element('breakpoints', {
            width = 80, height = 20, enter = true, position = 'center'
        }) end, desc='打开调试UI-断点'},
    }
}


return code
