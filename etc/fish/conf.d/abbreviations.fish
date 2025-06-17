# ~/.config/fish/conf.d/abbreviations.fish

# directory navigation abbreviations
abbr -a -- - 'cd -'
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'

# system commands
abbr -a c clear
abbr -a x exit
abbr -a h 'history | tail -20'
abbr -a l 'ls -la'
abbr -a ll 'ls -la'

# git abbreviations - expanded for better history
abbr -a g git
abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gaa 'git add .'
abbr -a gc 'git commit'
abbr -a gcm 'git commit -m'
abbr -a gca 'git commit -a -m'
abbr -a gps 'git push'
abbr -a gpl 'git pull'
abbr -a gf 'git fetch'
abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr -a gb 'git branch'
abbr -a gbd 'git branch -D'
abbr -a gch 'git checkout'
abbr -a gchb 'git checkout -b'
abbr -a gl 'git log --oneline -10'
abbr -a gll 'git log --oneline --graph --all'
abbr -a gpom 'git pull origin main'
abbr -a grs 'git reset --soft'
abbr -a grh 'git reset --hard'
abbr -a gst 'git stash'
abbr -a gstp 'git stash pop'

# development abbreviations - smart editor detection
if command -q nvim
    abbr -a nv nvim
    abbr -a v nvim
    abbr -a vi nvim
    abbr -a vim nvim
else
    abbr -a nv vim
    abbr -a v vim
end
abbr -a py python3
abbr -a pip3i 'pip3 install'
abbr -a pipu 'pip3 install --upgrade'

# npm/node abbreviations
abbr -a ni 'npm install'
abbr -a nis 'npm install --save'
abbr -a nid 'npm install --save-dev'
abbr -a nr 'npm run'
abbr -a ns 'npm start'
abbr -a nt 'npm test'
abbr -a nb 'npm run build'
abbr -a nci 'npm ci'

# yarn abbreviations
abbr -a yi 'yarn install'
abbr -a ya 'yarn add'
abbr -a yad 'yarn add --dev'
abbr -a yr 'yarn run'
abbr -a ys 'yarn start'
abbr -a yt 'yarn test'
abbr -a yb 'yarn build'

# docker abbreviations
abbr -a d docker
abbr -a dc 'docker compose'
abbr -a dcu 'docker compose up'
abbr -a dcd 'docker compose down'
abbr -a dcb 'docker compose build'
abbr -a dps 'docker ps'
abbr -a dpsa 'docker ps -a'
abbr -a di 'docker images'
abbr -a drm 'docker rm'
abbr -a drmi 'docker rmi'
abbr -a dex 'docker exec -it'
abbr -a dlogs 'docker logs -f'

# system administration
abbr -a s sudo
abbr -a sctl 'sudo systemctl'
abbr -a jctl 'sudo journalctl'
abbr -a psg 'ps aux | grep'
abbr -a ports 'netstat -tulpn'
abbr -a listening 'lsof -i -P -n | grep LISTEN'

# network testing
abbr -a p1 'ping 1.1.1.1'
abbr -a p8 'ping 8.8.8.8'
abbr -a pg 'ping google.com'

# file operations
abbr -a grep 'grep --color=auto'
abbr -a fgrep 'fgrep --color=auto'
abbr -a egrep 'egrep --color=auto'
abbr -a cp 'cp -v'
abbr -a mv 'mv -v'
abbr -a rm 'rm -v'
abbr -a mkdir 'mkdir -pv'

# tar operations
abbr -a tgz 'tar -czf'
abbr -a tuz 'tar -xzf'
abbr -a tbz 'tar -cjf'
abbr -a tub 'tar -xjf'

# find shortcuts
abbr -a ff 'find . -type f -name'
abbr -a fd 'find . -type d -name'

# rsync shortcuts
abbr -a rsync-copy 'rsync -avz --progress'
abbr -a rsync-move 'rsync -avz --progress --remove-source-files'
abbr -a rsync-update 'rsync -avzu --progress'

# tmux abbreviations
abbr -a tm tmux
abbr -a tma 'tmux attach'
abbr -a tmn 'tmux new-session'
abbr -a tml 'tmux list-sessions'

# terraform abbreviations (if used)
# abbr -a tf terraform
# abbr -a tfi 'terraform init'
# abbr -a tfp 'terraform plan'
# abbr -a tfa 'terraform apply'
# abbr -a tfd 'terraform destroy'
# abbr -a tfv 'terraform validate'
# abbr -a tff 'terraform fmt'

# macos specific abbreviations
if test (uname) = Darwin
    abbr -a flush 'dscacheutil -flushcache'
    abbr -a lscleanup 'find . -name "*.DS_Store" -type f -ls -delete'
    abbr -a showfiles 'defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
    abbr -a hidefiles 'defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
    abbr -a spotoff 'sudo mdutil -a -i off'
    abbr -a spoton 'sudo mdutil -a -i on'
    abbr -a brewup 'brew update && brew upgrade && brew cleanup'
    abbr -a brewinfo 'brew info'
    abbr -a brews 'brew search'
end

# productivity abbreviations
abbr -a weather 'curl wttr.in'
abbr -a myip 'curl ifconfig.me'
abbr -a qr 'qrencode -t ansiutf8'
abbr -a epoch 'date +%s'
abbr -a iso8601 'date -u +"%Y-%m-%dT%H:%M:%SZ"'

# development server shortcuts
abbr -a serve 'python3 -m http.server'
abbr -a serve8000 'python3 -m http.server 8000'
abbr -a serve3000 'python3 -m http.server 3000'

# security and encryption
abbr -a sha256 'shasum -a 256'
abbr -a md5 'md5sum'
abbr -a base64d 'base64 -d'
abbr -a base64e 'base64'

# process management
abbr -a psmem 'ps aux --sort=-%mem | head'
abbr -a pscpu 'ps aux --sort=-%cpu | head'
abbr -a topcpu 'top -o cpu'
abbr -a topmem 'top -o mem'