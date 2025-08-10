#!/bin/bash

config_alacritty() {
    # alacritty配置
    if [ -d "~/.config/alacritty" ]; then
        rm -rf ~/.config/alacritty
    fi
    cp -r ./alacritty ~/.config/
}

config_shartship() {
    # startship配置
    if [ -f "~/.config/starship.toml" ]; then
        rm ~/.config/starship.toml
    fi
    cp ./starship/starship.toml ~/.config/
}

config_yazi() {
    # 删除yazi配置
    if [ -d "~/.config/yazi" ]; then
        rm -rf ~/.config/yazi
    fi
    cp -r ./yazi ~/.config/
}

config_nvim() {
    # 删除nvim配置
    if [ -d "~/.config/nvim" ]; then
        rm -rf "~/.config/nvim"
    fi
    cp -r ./nvim ~/.config/
}

config_bash() {
    # 删除nvim配置
    if [ -d "~/.bashrc" ]; then
        rm -rf "~/.bashrc"
    fi
    cp ./bash/bashrc ~/.bashrc
    . ~/.bashrc
}


echo "请选择配置项: "
select choice in "alacritty" "starship" "yazi" "neovim" "bash" "all" "exit"; do
    case $choice in
        "alacritty")
            echo "配置alacritty"
            config_alacritty
            break
            ;;
        "starship")
            echo "配置starship"
            config_shartship
            break
            ;;
        "yazi")
            echo "配置yazi"
            config_yazi
            break
            ;;
        "neovim")
            echo "配置neovim"
            config_nvim
            break
            ;;
        "bash")
            echo "配置bash"
            config_bash
            break
            ;;
        "all")
            echo "全选"
            config_alacritty
            config_bash
            config_shartship
            config_yazi
            config_nvim
            break
            ;;
        "exit")
            echo "退出中..."
            exit 0
            ;;
    esac
done
