import sys
import os
import shutil


home_env = os.environ.get('HOME')
if home_env is None or not os.path.isdir(home_env):
    print("无HOME环境变量")
    sys.exit(1)
home = str(home_env)


def config_for_neovim(is_windows: bool):
    print("配置Neovim")
    if is_windows:
        config_dir = os.path.join(home, "AppData\\Local\\nvim")
    else:
        config_dir = os.path.join(home, ".config/nvim")
    if os.path.isdir(config_dir):
        shutil.rmtree(config_dir)
    shutil.copytree("nvim", config_dir)


def config_for_starship(is_windows: bool):
    print("配置Starship")
    if is_windows:
        config_file = os.path.join(home, ".config\\starship.toml")
    else:
        config_file = os.path.join(home, ".config/starship.toml")
    if os.path.isfile(config_file):
        shutil.rmtree(config_file)
    shutil.copytree("starship/starship.toml", config_file)


def config_for_wezterm(is_windows: bool):
    print("配置wezterm")
    if is_windows:
        config_dir = os.path.join(home, ".config\\wezterm")
    else:
        config_dir = os.path.join(home, ".config/wezterm")
    if os.path.isdir(config_dir):
        shutil.rmtree(config_dir)
    shutil.copytree("wezterm", config_dir)


def config_for_ghostty():
    print("配置ghostty")
    config_dir = os.path.join(home, ".config/ghostty")
    if os.path.isdir(config_dir):
        shutil.rmtree(config_dir)
    shutil.copytree("ghostty", config_dir)


def config_for_niri():
    print("配置niri")
    config_dir = os.path.join(home, ".config/niri")
    if os.path.isdir(config_dir):
        shutil.rmtree(config_dir)
    shutil.copytree("niri", config_dir)


def config_for_glazewm():
    print("配置glazewm")
    config_dir = os.path.join(home, ".config/.glzr/glazewm")
    if os.path.isdir(config_dir):
        shutil.rmtree(config_dir)
    shutil.copytree("niri", config_dir)


def config_for_yazi(is_windows: bool):
    print("配置yazi")
    if is_windows:
        config_dir = os.path.join(home, ".config\\yazi")
    else:
        config_dir = os.path.join(home, ".config/yazi")
    if os.path.isdir(config_dir):
        shutil.rmtree(config_dir)
    shutil.copytree("yazi", config_dir)


def config_for_fish():
    print("配置Fish")
    config_dir = os.path.join(home, ".config/fish")
    if os.path.isdir(config_dir):
        shutil.rmtree(config_dir)
    shutil.copytree("fish", config_dir)


def config_for_powershell():
    print("配置powershell")
    config_file = os.environ.get('PROFILE')
    if config_file is not None:
        if os.path.isfile(config_file):
            shutil.rmtree(config_file)
        shutil.copytree("starship/starship.toml", config_file)
    else:
        print("无环境变量$PROFILE")


def main():
    if sys.platform == 'linux':
        is_windows = False
    else:
        is_windows = True

    print("1. fish shell")
    print("2. powershell")
    print("3. ghostty")
    print("4. wezterm")
    print("5. starship 终端提示符")
    print("6. yazi 文件管理器")
    print("7. neovim")
    print("8. niri")
    print("9. glazewm")
    try:
        id = int(input("id>"))
    except Exception:
        print("输入错误，请输入指定编号")
        sys.exit(1)
    match id:
        case 1:
            if is_windows:
                print("fish不支持windows")
            else:
                config_for_fish()
        case 2:
            if not is_windows:
                print("powershell不支持linux")
            else:
                config_for_powershell()
        case 3:
            if is_windows:
                print("ghostty不支持windows")
            else:
                config_for_ghostty()
        case 4:
            config_for_wezterm(is_windows)
        case 5:
            config_for_starship(is_windows)
        case 6:
            config_for_yazi(is_windows)
        case 7:
            config_for_neovim(is_windows)
        case 8:
            if is_windows:
                print("niri不支持windows")
            else:
                config_for_niri()
        case 9:
            if not is_windows:
                print("glazewm不支持linux")
            else:
                config_for_glazewm()


if __name__ == "__main__":
    main()
