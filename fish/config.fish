if status is-interactive
# Commands to run in interactive sessions can go here
end

starship init fish | source
zoxide init fish | source

# some more ls aliases
alias ll='eza --icons -l'
alias la='eza --icons -a'
alias ls='eza --icons'
alias vim='nvim'
alias vi='nvim'

# yazi指令
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
