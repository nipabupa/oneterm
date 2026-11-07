local function file_exists(path)
    local stat = vim.uv.fs_stat(path)
    return stat ~= nil and stat.type == "file"
end

local function check_treeistter_node(bufnr)
    -- 检查节点
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then
        return  nil -- 该 buffer 没有对应 parser
    end
    pcall(parser.parse, parser)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local ok2, node = pcall(vim.treesitter.get_node, {
        bufnr = bufnr,
        pos = { cursor[1] - 1, cursor[2] },
    })
    if not ok2 or not node or node:has_error() then
        return  nil -- 鼠标处没有对应的标识符
    end
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

local function get_function_str(root, bufnr)
    -- 判断父节点有没有类
    local pare = root:parent()
    while pare ~= nil do
        if pare:type() == 'class_specifier' then
            break
        end
        pare = pare:parent()
    end
    -- 计算类字符串
    local class_str = ''
    if pare ~= nil then
        class_str = vim.treesitter.get_node_text(pare:field('name')[1], bufnr)
    end
    local res = ''
    -- 获取返回类型拼接类字符串
    res = res .. vim.treesitter.get_node_text(root:field("type")[1], bufnr)
    if class_str then
        res = res .. ' ' .. class_str .. '::'
    end
    -- 获取声明节点
    local declarator_node = root:field("declarator")[1]
    local name_node = declarator_node:field("declarator")[1]
    local parameters_node = declarator_node:field("parameters")[1]
    res = res .. vim.treesitter.get_node_text(name_node, bufnr) .. '('
    for i, item in ipairs(parameters_node:named_children()) do
        if item:type() == 'optional_parameter_declaration' then
            -- 丢弃最后一个默认值节点
            local count = item:named_child_count()
            for j, t in ipairs(item:named_children()) do
                if j < count then
                    res = res .. vim.treesitter.get_node_text(t, bufnr)
                    if j < count - 1 then
                        res = res .. ' '
                    end
                end
            end
        else
            res = res .. vim.treesitter.get_node_text(item, bufnr)
        end
        if i < parameters_node:named_child_count() then
            res = res .. ', '
        end
    end
    res = res .. ') { }'
    return res
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "c", "h" },
    callback = function(args)
        ------------------------------------------
        -- 在 .cpp 和 .h 之间切换
        ------------------------------------------
        vim.keymap.set("n", "<leader><leader>n", function()
            local ft = vim.bo.filetype
            local path = vim.api.nvim_buf_get_name(0)
            if ft == 'cpp' then
                local t = ''
                if path:sub(-1) == 'h' then
                    t = path:sub(1, -2) .. 'cpp'
                else
                    t = path:sub(1, -4) .. 'h'
                end
                if file_exists(t) then
                    vim.cmd.edit(t)
                end
            end
        end, { buffer = args.buf, silent = true, remap = false, desc = '头文件与源文件切换'})
        ------------------------------------------
        -- 打开离当前文件最近的CMakeLists.txt
        ------------------------------------------
        vim.keymap.set("n", "<leader><leader>c", function()
            local cwd = vim.uv.cwd()
            -- 如果是同一目录的话直接打开
            -- 如果当前文件目录没有，逐级向上查找，直到当前启动目录
            local path = vim.api.nvim_buf_get_name(0)
            local parent = vim.fs.dirname(path)
            while parent:find(cwd, 1, true) == 1 do
                local curpath = vim.fs.joinpath(parent, "CMakeLists.txt")
                if file_exists(curpath) then
                    vim.cmd.edit(curpath)
                    return
                end
                parent = vim.fs.dirname(parent)
            end
        end, { buffer = args.buf, silent = true, remap = false, desc = '打开当前项目CMakeLists'})
        ------------------------------------------
        -- CMake构建
        ------------------------------------------
        vim.keymap.set("n", "<leader><leader>b", function()
            vim.system({"cmake", "--build", "build"}, {stdout=false, stderr=false}, function(result)
                if result.code == 0 then
                    vim.notify("CMake构建完成!")
                else
                    vim.notify("CMake构建失败!")
                end
            end)
        end, { buffer = args.buf, silent = true, remap = false, desc = 'CMake构建项目'})
        ------------------------------------------
        -- CMake运行
        ------------------------------------------
        vim.keymap.set("n", "<leader><leader>r", function()
            vim.ui.input({prompt = " "}, function(word)
                if word ~= nil then
                    vim.system({"./build/" .. word}, {stdout=false, stderr=false}, function(result)
                        if result.code == 0 then
                            vim.notify("执行完成!")
                        else
                            vim.notify("执行失败!")
                        end
                    end)
                end
            end);
        end, { buffer = args.buf, silent = true, remap = false, desc = '打开当前项目CMakeLists'})
        ------------------------------------------
        -- 根据函数定义生成对应函数体
        ------------------------------------------
        vim.keymap.set("n", "<leader><leader>f", function()
            local bufnr = vim.api.nvim_get_current_buf()
            local root = check_treeistter_node(bufnr)
            if root == nil then
                return
            end
            local res = get_function_str(root, bufnr)
            -- 复制到寄存器中
            vim.fn.setreg('"', res)
        end, { buffer = args.buf, silent = true, remap = false, desc = '生成函数体'})
    end,
})
