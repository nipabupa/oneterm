local M = {}

M.dap = {
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
            options = {
                detached = not utils.is_windows,
            },
        }
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = utils.is_windows and vim.fn.getcwd() .. '\\build\\debug.exe' or vim.fn.getcwd() .. '/build/debug',
                cwd = '${workspaceFolder}',
                stopAtEntry = false,
                setupCommands = {  
                    { 
                        text = '-enable-pretty-printing',
                        description =  'enable pretty printing',
                        ignoreFailures = false 
                    },
                },
            }
        }
        dap.configurations.c = dap.configurations.cpp
    end,
    keys = {
        {'<F3>', function() require('dap').toggle_breakpoint({condition = vim.fn.input('Condition: ')}) end, desc='设置断点'},
        {'<F4>', function() require('dap').toggle_breakpoint() end, desc='设置断点'},
        {'<F5>', function() require('dap').continue() end, desc='启动继续'},
        {'<F8>', function() require('dap').terminate() end, desc='终止'},
        {'<F9>', function() require('dap').step_over() end, desc='下一行'},
        {'<F10>', function() require('dap').step_into() end, desc='进入'},
        {'<F11>', function() require('dap').step_out() end, desc='跳出'},
        {'<F11>', function() require('dap').step_out() end, desc='跳出'},
        {'<F12>', function() require('dap').run_to_cursor() end, desc='运行至光标'},
    }
}

M.dapview = {
    "igorlfs/nvim-dap-view",
    lazy = false,
    version = "1.*",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
    keys = {
        {'<F1>', function() require('dap-view').toggle() end, desc='打开关闭调试器'},
    }
}

return M
