# ~/.config/zsh/aliases.zsh

# system navigation and basic commands
alias c="clear"
alias x="exit"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias ~="cd ~"

# file operations with modern tools
alias ls="ls --color -lh"
alias ll="ls --color -lh"
alias la="ls --color -la"
alias l="ls -CF"
alias grep="grep --color=auto"

# directory operations
alias biggest="du -h --max-depth=1 | sort -h"
alias lc="find . -type f | wc -l"
alias ld="ls -l | grep '^d'"
alias lf="ls -A | grep"
alias lr="ls -R"
alias lsd='ls -l | grep "^d"'

# history management
alias h="history -10"
alias hc="history -c"
alias hg="history | grep"
alias h-search='fc -El 0 | grep'
alias top-history='history 0 | awk '"'"'{print $2}'"'"' | sort | uniq -c | sort -n -r | head'
alias histrg='history -500 | rg'

# file finding and manipulation
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias ff='find . -type f -name'
alias follow="tail -f -n +1"

# development aliases
alias nv='nvim'
alias nvconfig='nvim ~/.config/nvim'
alias nvmail='nvim -c "set ft=mail"'
alias nvproj='nvim -c "Telescope find_files"'
alias nvrecent='nvim -c "Telescope oldfiles"'
alias compose='nvim -c "set ft=mail" /tmp/compose_$(date +%s).mail'
alias nvkeys='nvim ~/.config/nvim/lua/keymaps.lua'
alias nvplug='nvim ~/.config/nvim/lua/plugins.lua'

# git workflow shortcuts
alias g="git"
alias gs="git status"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gps="git push"
alias gpl="git pull"
alias gf="git fetch"
alias gd="git diff"
alias gb="git branch"
alias gch="git checkout"
alias gl="git log"

# network utilities
alias p1="ping 1.1.1.1"
alias p8="ping 8.8.8.8"

# system administration
alias s="sudo"
alias psg="ps aux | grep"

# programming language shortcuts
alias python='python3'

# package management
alias yarn-update="yarn upgrade-interactive --latest"

# nix darwin specific
alias nixswitch="nix build .#darwinConfigurations.fidacura-laptop.system && ./result/sw/bin/darwin-rebuild switch --flake ."

# vps connections (replace with actual ips)
alias vps-fidacura="ssh fidacura@IPADDRESS"