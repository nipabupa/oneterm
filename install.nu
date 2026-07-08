use std/log
let os = $nu.os-info | get name


def install_wezterm [] {
    let dir = ($env.HOME | path join ".config" "wezterm")
    if ($dir | path exists) {
        log info "Delete old wezterm config"
        rm -rf $dir
    }
    log info "Copy wezterm config"
    cp -r "./wezterm" $dir
}

def install_starship [] {
    # init
    let filepath = ($nu.user-autoload-dirs | first | path join "starship.nu")
    starship init nu | save -f $filepath
    if $env.LAST_EXIT_CODE != 0 {
        log error "Starship init failed"
        return 1
    }
    # config
    let toml = ($env.HOME | path join ".config" "sharship.toml")
    if ($toml | path exists) {
        log info "Delete old starship config"
        rm $toml
    }
    log info "Copy starship config"
    cp "./starship/starship.toml" $toml
}

def install_yazi [] {
    let dir = ($env.HOME | path join ".config" "yazi")
    # config
    if ($dir | path exists) {
        log info "Delete old yazi config"
        rm -rf $dir
    }
    log info "Copy yazi config"
    cp -r "./yazi" $dir
}

def install_neovim [] {
    mut dir = ""
    if $os == "windows" {
        $dir = ($env.HOME | path join "AppData" "Local" "nvim")
    } else {
        $dir = ($env.HOME | path join ".config" "nvim")
    }
    if ($dir | path exists) {
        log info "Delete old neovim config"
        rm -rf $dir
    }
    log info "Copy neovim config"
    cp -r ./nvim $dir
}

def install_zoxide [] {
    # init
    let filepath = ($nu.user-autoload-dirs | path join "zoxide.nu")
    zoxide init nushell | save -f $filepath
}

def install_nushell [] {
    let filepath = ($nu.default-config-dir | path join "config.nu")
    if ($filepath | path exists) {
        log info "Delete old nushell config"
        rm $filepath
    }
    log info "Copy nushell config"
    cp "./nushell/config.nu" $filepath
}

let id = (input "Input Item[wezterm, starship, yazi, neovim, zoxide, nushell]: ") | str trim

match $id { 
    'wezterm' => { install_wezterm },
    'starship' => { install_starship },
    'yazi' => { install_yazi },
    'neovim' => { install_neovim },
    'zoxide' => { install_zoxide },
    'nushell' => { install_nushell },
    _ => {
        print "Unknown item"
    }
}
