# yazi
$env:YAZI_FILE_ONE = "$env:ENV_HOME\\git\\usr\\bin\\file.exe"

###########################
# starship
###########################
Invoke-Expression (&starship init powershell)

###########################
# 别名
###########################
Set-Alias -Name vi -Value "$env:ENV_HOME\\nvim-win64\\bin\\nvim.exe"
Set-Alias -Name vim -Value "$env:ENV_HOME\\nvim-win64\\bin\\nvim.exe"

if(Get-Alias -Name ls -ErrorAction SilentlyContinue) {
    Remove-Alias ls
}

###########################
# 自定义指令
###########################
function ls {
    param( [string]$name = "." )
    eza --icons $name
}
function ll {
    param( [string]$name = "." )
    eza -l -a --icons $name
}
# fzf搜索文件并使用nvim打开
function vif {
    vim $(fd --type f --exclude "venv" --exclude "__pycache__" | fzf --layout=reverse --preview 'bat --color=always {}' --preview-window '~3')
}

# fzf搜索目录并进入该路径
function cdf {
    cd $(fd --type d --exclude "venv" --exclude "__pycache__" | fzf --layout=reverse)
}

# fzf搜索文件并使用windows默认程序打开
function stf {
    start $(fd --type f --exclude "venv" --exclude "__pycache__" | fzf --layout=reverse)
}
# 编辑配置文件
function vip {
    vim $PROFILE
}
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}
# 启动python虚拟环境
function venv {
    if (Test-Path 'venv') {
        ./venv/Scripts/Activate.ps1
    } elseif (Test-Path '.venv') {
        ./.venv/Scripts/Activate.ps1
    }
}
