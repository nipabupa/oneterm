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
