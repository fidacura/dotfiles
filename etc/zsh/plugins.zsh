# ~/.config/zsh/plugins.zsh

# plugin installation directory
PLUGIN_DIR="$HOME/.config/zsh/plugins"

# plugin loading function
load_plugin() {
    local plugin_name="$1"
    local plugin_path="$PLUGIN_DIR/$plugin_name"
    
    if [[ -d "$plugin_path" ]]; then
        # try common plugin file names
        local plugin_files=(
            "$plugin_path/$plugin_name.plugin.zsh"
            "$plugin_path/$plugin_name.zsh"
            "$plugin_path/init.zsh"
        )
        
        for file in "${plugin_files[@]}"; do
            if [[ -f "$file" ]]; then
                source "$file"
                return 0
            fi
        done
    fi
    
    echo "Warning: Plugin $plugin_name not found or not loadable"
    return 1
}

# load essential plugins
load_plugin "zsh-autosuggestions"
load_plugin "zsh-history-substring-search" 
load_plugin "zsh-syntax-highlighting"

# plugin configuration
if [[ -n "${ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE+x}" ]]; then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# history substring search configuration
if command -v history-substring-search-up >/dev/null 2>&1; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi
