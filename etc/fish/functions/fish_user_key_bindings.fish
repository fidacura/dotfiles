# ~/.config/fish/functions/fish_user_key_bindings.fish

function fish_user_key_bindings
    # set vi mode as default
    fish_vi_key_bindings
    
    # emacs-style bindings for specific actions in insert mode
    bind -M insert \ca beginning-of-line
    bind -M insert \ce end-of-line
    bind -M insert \ck kill-line
    bind -M insert \cu backward-kill-line
    bind -M insert \cw backward-kill-word
    bind -M insert \cd delete-char
    bind -M insert \cb backward-char
    bind -M insert \cf forward-char
    
    # enhanced history search
    bind -M insert \cr history-search-backward
    bind -M insert \cs history-search-forward
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search
    
    # word movement (alt + arrow keys)
    bind -M insert \e\[1\;3D backward-word  # alt+left
    bind -M insert \e\[1\;3C forward-word   # alt+right
    bind -M insert \eb backward-word        # alt+b
    bind -M insert \ef forward-word         # alt+f
    
    # delete word shortcuts
    bind -M insert \e\[3\;3~ kill-word      # alt+delete
    bind -M insert \ed kill-word            # alt+d
    bind -M insert \e\x7f backward-kill-word # alt+backspace
    
    # clipboard integration (if xclip/pbcopy available)
    if command -q pbcopy # macos
        bind -M insert \cy 'commandline -i (pbpaste)'
        bind -M insert \cx 'echo (commandline) | pbcopy; commandline ""'
    else if command -q xclip # linux
        bind -M insert \cy 'commandline -i (xclip -o -selection clipboard)'
        bind -M insert \cx 'echo (commandline) | xclip -selection clipboard; commandline ""'
    end
    
    # directory navigation shortcuts
    bind -M insert \e. 'commandline -i " ../"'  # alt+. for ../
    bind -M insert \eh 'commandline -i " ~/"'   # alt+h for ~/
    
    # git shortcuts
    bind -M insert \eg 'commandline -i "git "'
    bind -M insert \e\cg 'commandline "git status"; commandline -f execute'
    
    # sudo shortcut
    bind -M insert \e\cs 'commandline -i "sudo "'
    
    # clear screen
    bind -M insert \cl 'clear; commandline -f repaint'
    
    # accept autosuggestion
    bind -M insert \e\[C forward-char        # right arrow
    bind -M insert \cf accept-autosuggestion # ctrl+f
    bind -M insert \t accept-autosuggestion  # tab (alternative)
    
    # fish-specific shortcuts
    bind -M insert \e\ch 'commandline -i " | head"'    # alt+h for head
    bind -M insert \e\ct 'commandline -i " | tail"'    # alt+t for tail
    bind -M insert \e\cg 'commandline -i " | grep "'   # alt+ctrl+g for grep
    bind -M insert \e\cl 'commandline -i " | less"'    # alt+l for less
    bind -M insert \e\cw 'commandline -i " | wc -l"'   # alt+ctrl+w for wc
    
    # file operations
    bind -M insert \e\co 'commandline -i "open "'      # alt+o for open
    if command -q nvim
        bind -M insert \e\ce 'commandline -i "nvim "'  # alt+e for nvim
    else
        bind -M insert \e\ce 'commandline -i "$EDITOR "'   # alt+e for editor
    end
    
    # process management
    bind -M insert \e\cp 'commandline -i "ps aux | grep "'
    bind -M insert \e\ck 'commandline -i "kill "'
    
    # network shortcuts
    bind -M insert \e\cp1 'commandline "ping 1.1.1.1"; commandline -f execute'
    bind -M insert \e\cp8 'commandline "ping 8.8.8.8"; commandline -f execute'
    
    # terminal multiplexer
    if command -q tmux
        bind -M insert \et 'commandline -i "tmux "'
        bind -M insert \e\ct 'commandline "tmux attach"; commandline -f execute'
    end
    
    # docker shortcuts (if available)
    if command -q docker
        bind -M insert \e\cd 'commandline -i "docker "'
        bind -M insert \e\cps 'commandline "docker ps"; commandline -f execute'
    end
    
    # custom function bindings
    bind -M insert \e\[1\;5A 'prevd-or-backward-word'  # ctrl+up
    bind -M insert \e\[1\;5B 'nextd-or-forward-word'   # ctrl+down
    bind -M insert \e\[1\;5D 'prevd'                   # ctrl+left (directory history)
    bind -M insert \e\[1\;5C 'nextd'                   # ctrl+right (directory history)
    
    # vi mode specific enhancements
    bind -M visual y 'fish_clipboard_copy'
    bind -M visual x 'fish_clipboard_cut'
    
    # command substitution helper
    bind -M insert \e\$ 'commandline -i "$()"'
    bind -M insert \e\( 'commandline -i "()"'
    bind -M insert \e\[ 'commandline -i "[]"'
    bind -M insert \e\{ 'commandline -i "{}"'
    
    # fzf integration (if available)
    if command -q fzf
        bind -M insert \ct fzf-file-widget
        bind -M insert \cr fzf-history-widget
        bind -M insert \ec fzf-cd-widget
    end
    
    # ranger integration (if available)
    if command -q ranger
        bind -M insert \e\cr 'ranger-cd'
    end
    
    # help and documentation
    bind -M insert \eh 'commandline -i " --help"'
    bind -M insert \e\? 'commandline -i "man "'
end

# helper function for clipboard operations
function fish_clipboard_copy
    if command -q pbcopy
        commandline -s | pbcopy
    else if command -q xclip
        commandline -s | xclip -selection clipboard
    end
end

function fish_clipboard_cut
    fish_clipboard_copy
    commandline -s ''
end

# directory navigation helper for ranger
function ranger-cd
    set -l temp_file (mktemp)
    ranger --choosedir=$temp_file
    set -l chosen_dir (cat $temp_file)
    if test -n "$chosen_dir" -a "$chosen_dir" != (pwd)
        cd "$chosen_dir"
    end
    rm -f $temp_file
    commandline -f repaint
end

# enhanced directory history navigation
function prevd-or-backward-word
    if test (count $dirprev) -gt 0
        prevd
    else
        backward-word
    end
end

function nextd-or-forward-word
    if test (count $dirnext) -gt 0
        nextd
    else
        forward-word
    end
end