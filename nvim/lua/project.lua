local function file_exists(path)
    local stat = vim.uv.fs_stat(path)
    return stat ~= nil and stat.type == "file"
end

-- F4切换C/C+源文件与头文件
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "c" },
    callback = function(args)
        local opts = { buffer = args.buf }

        -- 在 .cpp 和 .h 之间切换
        vim.keymap.set("n", "<F4>", function()
            local alt = vim.fn.expand("%:e") == "cpp"
                and vim.fn.expand("%:r") .. ".h"
                or  vim.fn.expand("%:r") .. ".cpp"
            if file_exists then
                vim.cmd("e " .. alt)
            end
        end, opts)
    end,
})
