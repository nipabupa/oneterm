function config_alacritty {
    if (Test-Path "$env:APPDATA\\alacritty") {
        Remove-Item -Path "$env:APPDATA\\alacritty" -Force -Recurse 
    }
    Copy-Item -Path alacritty -Destination "$env:APPDATA\\" -Force -Recurse
}

function config_starship {
    if (Test-Path "~\\.config\\starship.toml") {
        Remove-Item -Path "~\\.config\\starship.toml" -Force
    }
    if (-not(Test-Path "~\\.config")) {
        mkdir "~\\.config"
    }
    Copy-Item -Path .\\starship\\starship.toml -Destination "~\\.config\\" -Force
}

function config_neovim {
    if (Test-Path "~\\AppData\\Local\\nvim") {
        Remove-Item -Path "~\\AppData\\Local\\nvim" -Force -Recurse 
    }
    Copy-Item -Path nvim -Destination "~\\AppData\\Local\\" -Force -Recurse
}

function config_powershell {
    if (Test-Path "$PROFILE") {
        Remove-Item -Path "$PROFILE" -Force
    }
    Copy-Item -Path .\\powershell\\powershell.ps1 -Destination "$PROFILE" -Force
}

function config_yazi {
    if (Test-Path "$env:APPDATA\\yazi") {
        Remove-Item -Path "$env:APPDATA\\yazi" -Force -Recurse 
    }
    mkdir "$env:APPDATA\\yazi\\config"
    Copy-Item -Path .\\yazi\\yazi.toml -Destination "$env:APPDATA\\yazi\\config\\" -Force
}


Write-Host "0. all"
Write-Host "1. alacritty"
Write-Host "2. starship"
Write-Host "3. yazi"
Write-Host "4. neovim"
Write-Host "5. powershell"
$userInput = Read-Host "请输入编号"

switch($userInput) {
    "0" { config_alacritty; config_starship; config_powershell; config_neovim; config_yazi }
    "1" { config_alacritty }
    "2" { config_starship }
    "3" { config_yazi }
    "4" { config_neovim }
    "5" { config_powershell }
}

