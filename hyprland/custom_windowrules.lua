-- test结尾的相关测试程序默认浮动显示
hl.window_rule({ match = { class = "^(.*test)$" }, float = true, monitor = PRIMARY_MONITOR, center = true, fullscreen_state = 0 })
