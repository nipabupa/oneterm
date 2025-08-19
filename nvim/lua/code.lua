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


code.luasnip = {
    "L3MON4D3/LuaSnip",
    version = "v2.3",
    event = "InsertEnter",
    -- install jsregexp (optional!).
    -- build = "make install_jsregexp",
    config = function()
        require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })
    end
}


code.lspconfig = {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    config = function()
        -- 配置lsp显示UI
        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                text = { 
                    [vim.diagnostic.severity.ERROR] = '',
                    [vim.diagnostic.severity.WARN] = '',
                    [vim.diagnostic.severity.INFO] = '',
                    [vim.diagnostic.severity.HINT] = '',
                }
            },
            underline = true,
            update_in_insert = false,
            severity_sort = false
        })
        vim.lsp.enable('pyright')
        vim.lsp.enable('clangd')
    end
}


code.nvimcmp = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        'neovim/nvim-lspconfig',
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local kind_icons = {
            Text = '󰦨',
            Method = '',
            Function = '󰊕',
            Constructor = '',
            Field = '',
            Variable = '',
            Class = '',
            Interface = '',
            Module = '',
            Property = '',
            Unit = '',
            Value = '',
            Enum = '',
            Snippet = "",
            Keyword = '',
            Color = '',
            File = '',
            Folder = '',
            EnumMember = '',
            Constant = '',
            Struct = '',
            Event = "",
            Operator = "",
            TypeParameter = ""
        }
        cmp.setup({
            snippet = {
                -- 配置代码块引擎
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            }),
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-c>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({ select = true, })  -- select = false 只选择不输出
                        end
                    else
                        fallback()
                    end
                end),
                -- snip下一个空位
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                -- snip上一个空位
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            formatting = {
                format = function(entry, vim_item)
                    -- Kind icons
                    vim_item.kind = kind_icons[vim_item.kind]
                    -- 图标 + 字符串
                    -- string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                    vim_item.menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[LaTeX]",
                    })[entry.source.name]
                    return vim_item
                end
            },
        })
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })
        -- gray
        vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
        -- blue
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
        -- light blue
        vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
        vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
        -- pink
        vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
        vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
        -- front
        vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
        vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
        vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })
    end
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
            options = {
                detached = function()
                    return not utils.is_windows
                end
            }
        }
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    if utils.is_windows then
                        return vim.fn.getcwd() .. '\\build\\debug.exe'
                    else
                        return vim.fn.getcwd() .. '/build/debug'
                    end
                end,
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
