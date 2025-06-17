# ~/.config/fish/functions/fish_prompt.fish

function fish_prompt
    # capture the last command status
    set -l last_status $status
    
    # colors definition
    set -l normal (set_color normal)
    set -l blue (set_color blue)
    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l white (set_color white)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l bold_blue (set_color --bold blue)
    set -l bold_white (set_color --bold white)
    
    # first line; user, host, directory, and timestamp
    echo
    printf '%s┌─[%s' $bold_blue $normal
    printf '%s%s%s@%s%s%s' $cyan (whoami) $normal $yellow (hostname -s) $bold_blue
    printf ']%s - %s[%s' $normal $bold_blue $normal
    printf '%s%s%s' $bold_white (prompt_pwd) $bold_blue
    printf ']%s - %s[%s' $normal $bold_blue $normal
    printf '%s%s%s' $white (date '+%a %b %d, %H:%M') $bold_blue
    printf ']%s' $normal
    echo
    
    # second lin; prompt symbol with git status
    printf '%s└─[%s$%s] <%s' $bold_blue $white $bold_blue $normal
    
    # git information if in git repository
    if git rev-parse --git-dir >/dev/null 2>&1
        set -l git_branch (git symbolic-ref --short HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
        set -l git_dirty
        
        # check for dirty working directory
        if not git diff-index --quiet HEAD 2>/dev/null
            set git_dirty "*"
        end
        
        printf '%s[%s%s%s]%s' $bold_blue $git_branch $git_dirty $bold_blue $normal
    end
    
    printf '%s>%s ' $bold_blue $normal
    
    # show error status if last command failed
    if test $last_status -ne 0
        printf '%s[%s]%s ' $red $last_status $normal
    end
end

# right prompt for additional information
function fish_right_prompt
    # show current time on right side
    set_color --dim white
    date '+%H:%M:%S'
    set_color normal
end

# title function for terminal window
function fish_title
    # show current directory and command in terminal title
    if test (count $argv) -gt 0
        echo (basename (pwd)): $argv
    else
        echo (basename (pwd))
    end
end

# greeting function - can be customized
function fish_greeting
    # optional: show system information on shell start
    if command -q fortune; and command -q cowsay
        echo
        fortune | cowsay
        echo
    else
        # simple greeting with system info
        echo
        printf 'Welcome to %s on %s\n' (hostname) (uname -s)
        printf 'Fish shell version: %s\n' $FISH_VERSION
        echo
    end
end