# ~/.config/zsh/prompt.zsh

# enable prompt substitution
setopt prompt_subst

# git branch detection function
parse_git_branch() {
    git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# git status indicators
git_status() {
    local git_status_output
    git_status_output=$(git status --porcelain 2>/dev/null)
    
    if [[ -n $git_status_output ]]; then
        echo "*"
    fi
}

# clean, informative prompt design
PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[0;36m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[1;33m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;37m%}%D{"%a %b %d, %H:%M"}%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─[%{\e[0;37m%}$%{\e[0;34m%}%B] <%{\e[0;30m%}%B$(parse_git_branch)$(git_status)%{\e[0;34m%}%B>%{\e[0m%}%b '

# secondary prompt for multi-line commands
PS2=$' %{\e[0;34m%}%B>%{\e[0m%}%b '