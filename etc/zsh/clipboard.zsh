# ~/.config/zsh/clipboard.zsh

# clipboard utility functions based on platform
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macos clipboard integration
    set-system-clipboard() { pbcopy }
    get-system-clipboard() { pbpaste }
    set-system-selection() { pbcopy }
    get-system-selection() { pbpaste }
else
    # linux clipboard integration
    if command -v xclip >/dev/null 2>&1; then
        set-system-clipboard() { xclip -selection clipboard -in }
        get-system-clipboard() { xclip -selection clipboard -out }
        set-system-selection() { xclip -selection primary -in }
        get-system-selection() { xclip -selection primary -out }
    elif command -v xsel >/dev/null 2>&1; then
        set-system-clipboard() { xsel --clipboard --input }
        get-system-clipboard() { xsel --clipboard --output }
        set-system-selection() { xsel --primary --input }
        get-system-selection() { xsel --primary --output }
    else
        # fallback to internal buffer
        set-system-clipboard() { CUTBUFFER=$(cat) }
        get-system-clipboard() { echo $CUTBUFFER }
        set-system-selection() { CUTBUFFER=$(cat) }
        get-system-selection() { echo $CUTBUFFER }
    fi
fi

# zle widgets for clipboard integration
zle -N kill-line-to-system-clipboard
kill-line-to-system-clipboard() {
    zle kill-line
    print -rn -- "$CUTBUFFER" | set-system-clipboard
}

zle -N yank-from-system-clipboard
yank-from-system-clipboard() {
    CUTBUFFER=$(get-system-clipboard)
    zle yank
}

zle -N kill-line-to-x-selection
kill-line-to-x-selection() {
    zle kill-line
    print -rn -- "$CUTBUFFER" | set-system-selection
}

zle -N yank-from-x-selection
yank-from-x-selection() {
    CUTBUFFER=$(get-system-selection)
    zle yank
}