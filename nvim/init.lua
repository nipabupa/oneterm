--------------------------------------------------------------
-- 全局配置
--------------------------------------------------------------
vim.opt.number        = true                -- 设置行号
vim.opt.sw            = 4                   -- 设置缩进宽度
vim.opt.ts            = 4                   -- 设置 TAB 宽度
vim.opt.et            = true                -- 展开tab
vim.opt.softtabstop   = 4                   -- 如果后面设置了 expandtab 那么展开 tab 为多少字符
vim.opt.laststatus    = 2                   -- 总是显示状态栏
vim.opt.signcolumn    = 'yes:1'             -- 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
vim.opt.showtabline   = 2                   -- 总是显示标签栏
vim.opt.list          = true                -- 设置显示制表符等隐藏字符
vim.opt.listchars:append("eol:↴")           -- 显示换行
vim.opt.showcmd       = true                -- 右下角显示命令
vim.opt.splitright    = true                -- 水平切割窗口时，默认在右边显示新窗口
vim.opt.cursorline    = true                -- 高亮当前行
vim.opt.background    = 'dark'              -- 设置黑色背景
vim.opt.termguicolors = true                -- 允许 256 色
vim.opt.bs            = 'eol,start,indent'  -- 设置 Backspace 键模式
vim.opt.autoindent    = true                -- 自动缩进
vim.opt.winaltkeys    = 'no'                -- Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
vim.opt.wrap          = false               -- 关闭自动换行
vim.opt.ttimeout      = true                -- 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
vim.opt.ttimeoutlen   = 50                  -- 功能键超时检测 50 毫秒
vim.opt.ruler         = true                -- 显示光标位置
vim.opt.ignorecase    = true                -- 搜索时忽略大小写
vim.opt.smartcase     = true                -- 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写>字母
vim.opt.incsearch     = true                -- 查找输入时动态增量显示查找结果
vim.opt.encoding      = 'utf-8'             -- 内部工作编码
vim.opt.fileencodings = 'utf-8,gbk,gbk2312' -- 文件默认编码
vim.opt.showmatch     = true                -- 显示匹配的括号
vim.opt.matchtime     = 5                   -- 显示括号匹配的时间
vim.opt.display       = 'lastline'          -- 显示最后一行
vim.opt.wildmenu      = true                -- 允许下方显示目录
vim.opt.lazyredraw    = false               -- 延迟绘制（提升性能）
vim.opt.formatoptions = 'tcqmM'
vim.opt.ffs           = 'unix,dos,mac'      -- 文件换行符，默认使用 unix 换行符
vim.opt.backup        = false               -- 不允许备份
vim.opt.writebackup   = false               -- 不允许保存时备份
vim.opt.swapfile      = false               -- 禁用交换文件
vim.opt.undofile      = false               -- 禁用undo文件
vim.opt.clipboard     = 'unnamedplus'       -- 使用系统剪切板
vim.opt.hidden        = true                -- buf隐藏（终端）
vim.opt.completeopt   = 'menuone,noselect'  -- compe


--------------------------------------------------------------
-- 全局键盘映射
--------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opts = {silent=true, remap=false}
vim.keymap.set({'n', 'x'}, ' ', '', opts)
-- 保存
vim.keymap.set('n', '<C-s>', ':w<cr>', opts)
-- 清除高亮
vim.keymap.set('n', '<leader>c', ':noh<cr>', opts)
-- 切换上一个buffer
vim.keymap.set('n', '<S-Tab>', ':bp<cr>', opts)
-- 切换下一个buffer
vim.keymap.set('n', '<Tab>', ':bn<cr>', opts)
-- 切换上一个tab
vim.keymap.set('n', '[', ':tabp<cr>', opts)
-- 切换下一个tab
vim.keymap.set('n', ']', ':tabn<cr>', opts)
-- Windows
vim.keymap.set('n', '<A-h>', ':wincmd h<cr>', opts)
vim.keymap.set('n', '<A-j>', ':wincmd j<cr>', opts)
vim.keymap.set('n', '<A-k>', ':wincmd k<cr>', opts)
vim.keymap.set('n', '<A-l>', ':wincmd l<cr>', opts)
vim.keymap.set('n', '<c-q>', function()
    local ft = vim.bo.filetype
    if (ft ~= 'neo-tree') then
        vim.cmd.only()
    end
    vim.cmd.bdelete({bang=true})
end, opts)
vim.keymap.set('n', '<leader>q', ':exit<cr>', opts)
-- 方向
vim.keymap.set({'n', 'i', 'x', 'c'}, '<c-h>', '<left>', opts)
vim.keymap.set({'n', 'i', 'x', 'c'}, '<c-j>', '<down>', opts)
vim.keymap.set({'n', 'i', 'x', 'c'}, '<c-k>', '<up>', opts)
vim.keymap.set({'n', 'i', 'x', 'c'}, '<c-l>', '<right>', opts)
-- ESC
vim.keymap.set({'n', 'i', 'x', 'c'}, '<c-;>', '<esc>', opts)
-- Home
vim.keymap.set({'n', 'i', 'c'}, '<c-a>', '<Home>', opts)
-- End
vim.keymap.set({'n', 'i', 'c'}, '<c-e>', '<End>', opts)

--------------------------------------------------------------
-- 插件
--------------------------------------------------------------
require('manager')
