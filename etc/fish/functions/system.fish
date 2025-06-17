# ~/.config/fish/functions/system.fish

# enhanced directory creation with navigation
function md
    if test (count $argv) -eq 0
        echo "Usage: md <directory_name>"
        return 1
    end
    mkdir -p $argv[1]; and cd $argv[1]
end

# process management utilities
function psgrep
    if test (count $argv) -eq 0
        echo "Usage: psgrep <process_name>"
        return 1
    end
    ps aux | grep -i $argv[1] | grep -v grep
end

function killall_by_name
    if test (count $argv) -eq 0
        echo "Usage: killall_by_name <process_name>"
        return 1
    end
    
    set -l pids (pgrep -f $argv[1])
    
    if test (count $pids) -eq 0
        echo "No processes found matching: $argv[1]"
        return 1
    end
    
    echo "Found processes:"
    for pid in $pids
        ps -p $pid -o pid,ppid,comm,args --no-headers
    end
    
    read -l -P "Kill these processes? [y/N]: " confirm
    if test "$confirm" = "y" -o "$confirm" = "Y"
        for pid in $pids
            kill $pid
            echo "Killed process $pid"
        end
    else
        echo "Operation cancelled"
    end
end

# disk usage analysis
function disk_usage_top
    set -l count 10
    if test (count $argv) -gt 0
        set count $argv[1]
    end
    
    echo "Top $count largest directories:"
    du -h 2>/dev/null | sort -hr | head -n $count
end

# file permissions helper
function fix_permissions
    if test (count $argv) -eq 0
        echo "Usage: fix_permissions <directory>"
        echo "Sets directories to 755 and files to 644"
        return 1
    end
    
    set -l target $argv[1]
    
    if not test -d $target
        echo "Error: Directory not found: $target"
        return 1
    end
    
    echo "Fixing permissions in: $target"
    find $target -type d -exec chmod 755 {} \;
    find $target -type f -exec chmod 644 {} \;
    echo "Permissions updated"
end

# system information display
function sysinfo
    echo "=== System Information ==="
    echo "Hostname: "(hostname)
    echo "OS: "(uname -s)" "(uname -r)
    echo "Architecture: "(uname -m)
    echo "Uptime: "(uptime | string replace -r '.*up\s*' '' | string replace -r ',.*load.*' '')
    
    if command -q free
        echo "Memory: "(free -h | grep Mem | awk '{print $3 "/" $2}')
    end
    
    echo "Current user: "(whoami)
    echo "Shell: $SHELL"
    echo "Fish version: $FISH_VERSION"
    
    if test (uname) = Darwin
        echo "macOS version: "(sw_vers -productVersion)
    end
end

# backup function with timestamping
function backup_file
    if test (count $argv) -eq 0
        echo "Usage: backup_file <file_or_directory>"
        return 1
    end
    
    set -l source $argv[1]
    
    if not test -e $source
        echo "Error: Source not found: $source"
        return 1
    end
    
    set -l timestamp (date '+%Y%m%d_%H%M%S')
    set -l backup_name "$source.backup.$timestamp"
    
    if test -d $source
        cp -r $source $backup_name
    else
        cp $source $backup_name
    end
    
    echo "Backup created: $backup_name"
end

# service management wrapper (systemd/launchctl)
function service_status
    if test (count $argv) -eq 0
        echo "Usage: service_status <service_name>"
        return 1
    end
    
    set -l service $argv[1]
    
    if test (uname) = Darwin
        # macos launchctl
        if launchctl list | grep -q $service
            echo "Service $service is loaded"
            launchctl list | grep $service
        else
            echo "Service $service is not loaded"
        end
    else if command -q systemctl
        # linux systemd
        systemctl status $service
    else
        echo "Service management not available on this system"
        return 1
    end
end

# log file analysis
function analyze_logs
    set -l log_file $argv[1]
    
    if test (count $argv) -eq 0
        # default log locations based on os
        if test (uname) = Darwin
            set log_file /var/log/system.log
        else
            set log_file /var/log/syslog
        end
    end
    
    if not test -f $log_file
        echo "Error: Log file not found: $log_file"
        return 1
    end
    
    echo "=== Log Analysis for $log_file ==="
    echo "File size: "(du -h $log_file | cut -f1)
    echo "Last modified: "(stat -c %y $log_file 2>/dev/null; or stat -f %Sm $log_file)
    echo
    echo "Recent entries (last 20 lines):"
    tail -20 $log_file
    echo
    echo "Error patterns:"
    grep -i "error\|fail\|critical" $log_file | tail -5
end

# network connectivity test
function netcheck
    echo "=== Network Connectivity Check ==="
    
    # test local connectivity
    echo "Testing local connectivity..."
    if ping -c 1 127.0.0.1 >/dev/null 2>&1
        echo "✓ Localhost reachable"
    else
        echo "✗ Localhost not reachable"
    end
    
    # test gateway
    set -l gateway (route -n get default 2>/dev/null | grep gateway | awk '{print $2}'; or ip route | grep default | awk '{print $3}' 2>/dev/null)
    if test -n "$gateway"
        echo "Testing gateway: $gateway"
        if ping -c 1 $gateway >/dev/null 2>&1
            echo "✓ Gateway reachable"
        else
            echo "✗ Gateway not reachable"
        end
    end
    
    # test dns
    echo "Testing DNS resolution..."
    if nslookup google.com >/dev/null 2>&1
        echo "✓ DNS resolution working"
    else
        echo "✗ DNS resolution failed"
    end
    
    # test internet connectivity
    echo "Testing internet connectivity..."
    if ping -c 1 8.8.8.8 >/dev/null 2>&1
        echo "✓ Internet reachable (8.8.8.8)"
    else
        echo "✗ Internet not reachable"
    end
end

# cpu and memory monitoring
function top_processes
    set -l count 10
    if test (count $argv) -gt 0
        set count $argv[1]
    end
    
    echo "=== Top $count CPU consumers ==="
    if test (uname) = Darwin
        ps -rco pid,pcpu,pmem,comm | head -n (math $count + 1)
    else
        ps auxk -pcpu | head -n (math $count + 1)
    end
end

# file system health check
function fscheck
    echo "=== File System Health Check ==="
    
    # disk usage by mount point
    echo "Disk usage by mount point:"
    df -h | grep -v tmpfs | grep -v udev
    echo
    
    # check for full disks
    set -l full_disks (df -h | awk 'NR>1 {gsub(/%/, "", $5); if ($5 > 90) print $1 " " $5 "%"}')
    if test -n "$full_disks"
        echo "⚠️  WARNING: Disks over 90% full:"
        echo $full_disks
    else
        echo "✓ All disks have adequate free space"
    end
    
    # inode usage check (linux only)
    if test (uname) != Darwin
        echo
        echo "Inode usage:"
        df -i | grep -v tmpfs | grep -v udev
    end
end

# environment cleanup
function clean_env
    echo "=== Environment Cleanup ==="
    
    # clean temporary files
    echo "Cleaning temporary files..."
    if test -d /tmp
        find /tmp -type f -atime +7 -delete 2>/dev/null
        echo "✓ Old temporary files removed"
    end
    
    # clean user cache (macos)
    if test (uname) = Darwin
        if test -d ~/Library/Caches
            echo "Cleaning user caches..."
            find ~/Library/Caches -name "*.cache" -delete 2>/dev/null
            echo "✓ User caches cleaned"
        end
    end
    
    # clean fish history if too large
    if test -f ~/.local/share/fish/fish_history
        set -l history_size (stat -c%s ~/.local/share/fish/fish_history 2>/dev/null; or stat -f%z ~/.local/share/fish/fish_history)
        if test $history_size -gt 1000000  # 1MB
            echo "Fish history file is large ($history_size bytes), consider cleaning"
        end
    end
    
    echo "Environment cleanup complete"
end

# security audit basics
# function security_check
#     echo "=== Basic Security Check ==="
    
#     # check for world-writable files in home
#     echo "Checking for world-writable files in home directory..."
#     set -l writable_files (find ~ -type f -perm -002 2>/dev/null | head -5)
#     if test -n "$writable_files"
#         echo "⚠️  World-writable files found:"
#         for file in $writable_files
#             echo "  $file"
#         end
#     else
#         echo "✓ No world-writable files in home directory"
#     end
    
#     # check ssh key permissions
#     if test -d ~/.ssh
#         echo "Checking SSH key permissions..."
#         for key in ~/.ssh/id_*
#             if test -f $key
#                 set -l perms (stat -c %a $key 2>/dev/null; or stat -f %Mp%Lp $key | string sub --start=3)
#                 if test $perms != 600
#                     echo "⚠️  SSH key $key has permissions $perms (should be 600)"
#                 end
#             end
#         end
#     end
    
#     # check for suspicious processes (basic)
#     echo "Checking for processes running as root..."
#     set -l root_procs (ps aux | awk '$1 == "root" && $11 !~ /^\[/ {print $11}' | sort | uniq -c | sort -nr | head -5)
#     echo "Top root processes:"
#     echo $root_procs
# end