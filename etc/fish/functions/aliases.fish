# ~/.config/fish/functions/aliases.fish

# system navigation and basic commands
alias c='clear'
alias x='exit'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias ~='cd ~'

# file operations with modern tools - improved ls usage
if command -q exa
    # use exa if available (modern ls replacement)
    alias ls='exa --color=always --long --header'
    alias ll='exa --color=always --long --header'
    alias la='exa --color=always --long --all --header'
    alias lt='exa --color=always --tree --level=2'
else
    # fallback to traditional ls with enhanced flags
    alias ls='ls --color=auto -lh'
    alias ll='ls --color=auto -lh'
    alias la='ls --color=auto -la'
end

alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# directory operations
alias biggest='du -h --max-depth=1 | sort -h'
alias lc='find . -type f | wc -l'
alias ld='ls -l | grep "^d"'
alias lf='ls -A | grep'
alias lr='ls -R'
alias lsd='ls -l | grep "^d"'

# history management; fish specific
alias h='history | tail -10'
alias hc='history clear'
alias hg='history | grep'

# file finding and manipulation
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias ff='find . -type f -name'
alias follow='tail -f -n +1'

# development aliases; smart editor detection
if command -q nvim
    alias nv='nvim'
    alias nvconfig='nvim ~/.config/nvim'
    alias nvmail='nvim -c "set ft=mail"'
    alias nvproj='nvim -c "Telescope find_files"'
    alias nvrecent='nvim -c "Telescope oldfiles"'
    alias nvkeys='nvim ~/.config/nvim/lua/keymaps.lua'
    alias nvplug='nvim ~/.config/nvim/lua/plugins.lua'
    alias compose='nvim -c "set ft=mail" /tmp/compose_(date +%s).mail'
else
    alias nv='vim'
    alias nvconfig='vim ~/.vimrc'
    alias nvmail='vim -c "set ft=mail"'
end

# text editors with fallback
if command -q nvim
    alias v='nvim'
    alias vi='nvim'
else
    alias v='vim'
    alias vi='vim'
end

# git workflow shortcuts - comprehensive set
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a -m'
alias gps='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gd='git diff'
alias gdc='git diff --cached'
alias gb='git branch'
alias gbd='git branch -D'
alias gch='git checkout'
alias gchb='git checkout -b'
alias gl='git log'
alias gpom='git pull origin master'
alias grs='git reset --soft'
alias grh='git reset --hard'
alias undopush='git push -f origin HEAD^:master'

# network utilities
alias p1='ping 1.1.1.1'
alias p8='ping 8.8.8.8'
alias localip='ipconfig getifaddr en0'
alias ips='ifconfig -a | perl -nle\'/(\d+\.\d+\.\d+\.\d+)/ and print $1\''
alias whois='whois -h whois-servers.net'

# system administration
alias s='sudo'
alias psg='ps aux | grep'

# programming language shortcuts
alias python='python3'

# package management
alias yarn-update='yarn upgrade-interactive --latest'

# browser shortcuts for macos
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias brave='/Applications/Brave.app/Contents/MacOS/Brave'
alias firefox='/Applications/Firefox.app/Contents/MacOS/firefox'

# ssh connections - customize with your actual ips
# alias vps-fidacura='ssh fidacura@YOUR_IP_ADDRESS'