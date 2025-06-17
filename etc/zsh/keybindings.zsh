# ~/.config/zsh/keybindings.zsh

# use vi mode as base
bindkey -v

# enhanced history search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' up-history
bindkey '^N' down-history

# line editing shortcuts
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^U' kill-whole-line
bindkey '^W' backward-kill-word
bindkey '^?' backward-delete-char

# clipboard integration
bindkey '^Y' yank-from-system-clipboard
bindkey '\ey' yank-from-system-clipboard
bindkey '\ek' kill-line-to-system-clipboard

# word movement
bindkey '\eb' backward-word
bindkey '\ef' forward-word

# magic space for history expansion
bindkey ' ' magic-space