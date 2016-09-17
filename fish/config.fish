function fish_prompt
    echo
    echo -n (date "+%T")
    set_color ffafb3
    echo -n ' [kasper@MacBookPro' 'on '
	set_color FF0
    echo -n (pwd)']'
    set_color normal
    echo
    echo -n '⚡️' '' '=> '
end

function tmux2
    set TERM screen-256color-bce
    tmux
end

# respect node PATH
set -gx PATH $PATH /Users/kasper/npm-global/bin

# grep colors
setenv -x GREP_OPTIONS "--color=auto"
