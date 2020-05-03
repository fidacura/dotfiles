# ---------------------------------------------------------
# -------------------> Networking <------------------------
# ---------------------------------------------------------
alias localip "ipconfig getifaddr en0"
alias ips "ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ and print $1'"
alias whois="whois -h whois-servers.net"

# HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Start a server
function server
  open http://localhost:9080/ 
  and python -m SimpleHTTPServer 9080
end 


# ---------------------------------------------------------
# ----------------------> UNIX <---------------------------
# ---------------------------------------------------------

alias rot13 "tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'"

function md
  mkdir -p "$argv"; cd "$argv"
end

function randpwd
  dd if=/dev/urandom bs=1 count=48 2>/dev/null | base64 | rev | cut -b 2- | rev
end


# ---------------------------------------------------------
# ----------------------> MacOS <--------------------------
# ---------------------------------------------------------
# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Empty the Trash
alias deltrash="rm -rfv ~/.Trash"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true and killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false and killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false and killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true and killall Finder"

# Disable/enable Spotlight
alias spotoff="sudo mdutil -a -i off"
alias spoton="sudo mdutil -a -i on"
