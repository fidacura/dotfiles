# ~/.config/fish/config.fish

# environment variables - core system configuration
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less
set -gx LANG en_US.UTF-8
set -gx CLICOLOR 1
set -gx BLOCKSIZE K

# disable fish greeting by default - can be re-enabled with custom function
set -g fish_greeting

# homebrew configuration for macos
if test (uname) = Darwin
    # nix package manager - highest priority
    fish_add_path --path --move $HOME/.nix-profile/bin
    
    # homebrew setup
    if test -f /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    end
    
    # macos specific paths
    fish_add_path --path /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
    fish_add_path --path /Applications/Docker.app/Contents/Resources/bin
    fish_add_path --path /opt/homebrew/opt/postgresql@15/bin
    fish_add_path --path $HOME/Library/Python/3.9/bin
end

# personal and development paths - high priority
fish_add_path --path --move $HOME/bin
fish_add_path --path --move $HOME/.local/bin
fish_add_path --path $HOME/.yarn/bin
fish_add_path --path $HOME/.config/yarn/global/node_modules/.bin
fish_add_path --path $HOME/.npm-global/bin

# nvm configuration using fisher plugin
set -gx NVM_DIR $HOME/.nvm

# homebrew auto-update prevention
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# git prompt configuration
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_showcolorhints true
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_showdirtystate true
set -g __fish_git_prompt_showstashstate true
set -g __fish_git_prompt_showuntrackedfiles true

# git prompt color
set -g __fish_git_prompt_color_branch magenta --bold
set -g __fish_git_prompt_color_dirtystate white
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_merging yellow
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_upstream_ahead green
set -g __fish_git_prompt_color_upstream_behind red
set -g __fish_git_prompt_color_cleanstate green

# git status symbols
set -g __fish_git_prompt_char_cleanstate ' ✓'
set -g __fish_git_prompt_char_dirtystate ' ●'
set -g __fish_git_prompt_char_stagedstate ' +'
set -g __fish_git_prompt_char_stashstate ' $'
set -g __fish_git_prompt_char_untrackedfiles ' ?'
set -g __fish_git_prompt_char_upstream_ahead ' ↑'
set -g __fish_git_prompt_char_upstream_behind ' ↓'
set -g __fish_git_prompt_char_upstream_diverged ' ⚡'
set -g __fish_git_prompt_char_upstream_equal ' ='
set -g __fish_git_prompt_char_stateseparator ' |'

# vi mode indicators for command line editing
function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo '[N] '
        case insert
            set_color --bold green
            echo '[I] '
        case replace_one
            set_color --bold yellow
            echo '[R] '
        case visual
            set_color --bold brmagenta
            echo '[V] '
        case '*'
            set_color --bold red
            echo '[?] '
    end
    set_color normal
end

# source additional configuration files
source ~/.config/fish/functions/aliases.fish
source ~/.config/fish/functions/development.fish
source ~/.config/fish/functions/system.fish
source ~/.config/fish/functions/network.fish
source ~/.config/fish/functions/media.fish

# load abbreviations if they exist
if test -f ~/.config/fish/conf.d/abbreviations.fish
    source ~/.config/fish/conf.d/abbreviations.fish
end

# plugin management and loading
# ensure fisher is installed for plugin management
if not functions -q fisher
    echo "Installing fisher plugin manager..."
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end

# auto-load essential plugins
set -l plugins \
    jethrokuan/z \
    franciscolourenco/done \
    PatrickF1/fzf.fish \
    jorgebucaran/nvm.fish

for plugin in $plugins
    if not fisher list | grep -q $plugin
        echo "Installing plugin: $plugin"
        fisher install $plugin
    end
end