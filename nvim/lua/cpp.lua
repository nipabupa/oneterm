local function file_exists(path)
    local stat = vim.uv.fs_stat(path)
    return stat ~= nil and stat.type == "file"
end

local function check_treeistter_node()
    local bufnr = vim.api.nvim_get_current_buf()
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then
        return  false -- 该 buffer 没有对应 parser
    end
    pcall(parser.parse, parser)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local ok2, node = pcall(vim.treesitter.get_node, {
        bufnr = bufnr,
        pos = { cursor[1] - 1, cursor[2] },
    })
    if not ok2 or not node or node:has_error() then
        return  false -- 鼠标处没有对应的标识符
    end
    return true
end

local function check_function_node(node)
    -- 找到声明的父节点
    local pare = node:parent()
    while pare ~= nil do
        if pare:type() == 'declaration' or pare:type() == 'field_declaration' then
            break
        end
        pare = pare:parent()
    end
    if pare == nil then
        return nil
    end
    -- 判断这个是不是函数声明
    local declarator_node = pare:field('declarator')[1]
    if declarator_node == nil or declarator_node:type() ~= 'function_declarator' then
        return nil
    end
    return pare
end

local function get_function_str(root)
    -- 返回类型
    local type_node = root:field('type')[1]
    local type_str = vim.treesitter.get_node_text(type_node, bufnr)
    -- 存储类型
    local storage_class_node = root:child(1)
    local storage_class_str = ''
    if storage_class_node ~= type_node then
        storage_class_str = vim.treesitter.get_node_text(storage_class_str, bufnr)
    end
    -- 函数名
    local function_node = declarator:field('declarator')[1]
    print(vim.treesitter.get_node_text(type_node, bufnr))
    -- 参数列表
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "c", "h" },
    callback = function(args)
        ------------------------------------------
        -- 打开离当前文件最近的CMakeLists.txt
        ------------------------------------------
        vim.keymap.set("n", "<F3>", function()
            -- 如果是同一目录的话直接打开
            -- 如果当前文件目录没有，逐级向上查找，直到当前启动目录
        end, { buffer = args.buf, silent = true, remap = false, desc = '打开当前项目CMakeLists'})
        ------------------------------------------
        -- 在 .cpp 和 .h 之间切换
        ------------------------------------------
        vim.keymap.set("n", "<F4>", function()
            local alt = vim.fn.expand("%:e") == "cpp"
                and vim.fn.expand("%:r") .. ".h"
                or  vim.fn.expand("%:r") .. ".cpp"
            if file_exists(alt) then
                vim.cmd("e " .. alt)
            end
        end, { buffer = args.buf, silent = true, remap = false, desc = '头文件与源文件切换'})
        ------------------------------------------
        -- 根据函数定义生成对应函数体
        ------------------------------------------
        vim.keymap.set("n", "<leader>af", function()
            if not check_treeistter_node() then
                return
            end

            local root = check_function_node()
            if not root then
                return
            end

            local res = get_function_str(root)

            -- 复制到寄存器中
            vim.fn.setreg('a', res)
        end, { buffer = args.buf, silent = true, remap = false, desc = '生成函数体'})
    end,
})
