# config.nu
#
# Installed by:
# version = "0.112.2"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# nvim
$env.config.buffer_editor = "nvim"
# oneterm
$env.ONETERM = $env.HOME | append "/oneterm" | str join 
# env.PATH
$env.PATH = $env.PATH | append ($env.HOME | path join ".local" "bin" | str join)

if ($nu.os-info | get name) == 'windows' {
    $env.config.shell_integration.osc133 = false;
}

alias vi = nvim
alias vim = nvim
alias viw = nvim ~/.config/wezterm/wezterm.lua

def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    ^yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != $env.PWD and ($cwd | path exists) {
        cd $cwd
    }
    rm -fp $tmp
}

def vif [] {
    let file = (fd --type f --exclude "venv" --exclude "__pycache__" --exclude "build" | fzf --layout=reverse --preview 'bat --color=always {}' --preview-window '~3')
    if ($file | path exists) {
        nvim $file
    }
}

def cr [] {
    if ("build.ninja" | path exists) {
        ^ninja
    } else if ("Makefile" | path exists) {
        if ($nu.os-info | get name) == 'windows' {
            ^mingw32-make
        } else {
            ^make
        }
    } else {
        print "no config file"
        return 1
    }
}

def tm [name] {
    match $name { 
        'cmake' => { 
            cp ($env.ONETERM | path join "template" "CMakeLists.txt") .
        },
        'clang-tidy' => {
            cp ($env.ONETERM | path join "template" ".clang-tidy") .
        },
        'editorconfig' => {
            cp ($env.ONETERM | path join "template" ".editorconfig") .
        },
        'compile-flags' => {
            cp ($env.ONETERM | path join "template" "compile_flags.txt") .
        }
        _ => {
            print "Unknown template name"
        }
    }
}


if $nu.is-interactive {
}
