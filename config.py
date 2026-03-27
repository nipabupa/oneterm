import sys
import os


def config_for_neovim():
    pass


def config_for_starship():
    pass


def config_for_wezterm():
    pass


def config_for_niri():
    pass


def config_for_glazewm():
    pass


def config_for_yazi():
    pass


def config_for_fish():
    pass


def config_for_powershell():
    pass


def main():
    print("1. fish shell")
    print("2. powershell")
    print("3. starship 终端提示符")
    print("4. yazi 文件管理器")
    print("5. ghostty")
    print("6. neovim")
    try:
        id = int(input("id>"))
    except Exception:
        print("输入错误，请输入指定编号")
        sys.exit(1)


if __name__ == "__main__":
    main()
