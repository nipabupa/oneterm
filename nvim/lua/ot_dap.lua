local M = {}

local is_windows = os.getenv('OS') == 'Windows_NT'

local function config_for_c_cpp_rust()
    -- MSVC 使用vscode-cpptoosl
    -- GNU 使用codelldb
    local dap = require('dap')
    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = 'OpenDebugAD7',
        options = {
            detached = not is_windows,
        }
    }
    dap.adapters.codelldb = {
        type = 'executable',
        command = 'codelldb',
        detached = not is_windows,
    }
    dap.configurations.cpp = {
        {
            name = "LaunchDebugLLDB",
            type = "codelldb",
            request = "launch",
            -- 指定调试debug
            program = is_windows and vim.fn.getcwd() .. '\\build\\debug.exe' or vim.fn.getcwd() .. '/build/debug',
            cwd = '${workspaceFolder}',
            stopOnEntry = false
        }, {
            name = "LaunchCustomLLDB",
            type = "codelldb",
            request = "launch",
            -- 自定义调试
            program = function()
                if is_windows then
                    return vim.fn.getcwd() .. '\\' .. vim.fn.input(" ")
                else
                    return vim.fn.getcwd() .. '/' .. vim.fn.input(" ")
                end
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false
        }, {
            name = "LaunchDebugCPPTools",
            type = "cppdbg",
            request = "launch",
            -- 指定调试debug
            program = is_windows and vim.fn.getcwd() .. '\\build\\debug.exe' or vim.fn.getcwd() .. '/build/debug',
            cwd = '${workspaceFolder}',
            stopAtEntry = false,
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description = 'enable pretty printing',
                    ignoreFailures = false
                },
            },
        }, {
            name = "LaunchCustomCPPTools",
            type = "cppdbg",
            request = "launch",
            -- 自定义调试
            program = function()
                if is_windows then
                    return vim.fn.getcwd() .. '\\' .. vim.fn.input(" ")
                else
                    return vim.fn.getcwd() .. '/' .. vim.fn.input(" ")
                end
            end,
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
    dap.configurations.rust = dap.configurations.cpp
end


M.dap = {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    dependencies = {
        { 'mfussenegger/nvim-dap-python', event = "VeryLazy" }
    },
    config = function()
        vim.fn.sign_define('DapBreakpoint', {text='', texthl='ErrorMsg', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='ErrorMsg', linehl='', numhl=''})
        vim.fn.sign_define('DapLogPoint', {text='', texthl='', linehl='ErrorMsg', numhl=''})
        vim.fn.sign_define('DapStopped', {text='', texthl='Substitute', linehl='', numhl=''})
        -- Python
        if is_windows then
            require('dap-python').setup('pythonw')
        else
            require('dap-python').setup('python')
        end
        config_for_c_cpp_rust()
    end,
    keys = {
        {'<F3>', function() require('dap').toggle_breakpoint(vim.fn.input("Condition: "), vim.fn.input("Hit Number: ")) end},
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
    event = "VeryLazy",
    version = "1.*",
    opts = {
        winbar = {
            default_section = "scopes",
            show_keymap_hints = false,
        },
        windows = {
            size = 0.35,
            position = "right",
            terminal = {
                size = 0.2,
                position = "above",
                -- List of debug adapters for which the terminal should be ALWAYS hidden
                hide = {},
            },
        },
        auto_toggle = true,
    },
    keys = {
        {'<F1>', function() require('dap-view').toggle() end, desc='打开关闭调试器'},
    }
}

return M
