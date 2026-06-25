# ~/.config/zsh/exports.zsh

export CLICOLOR=1
export BLOCKSIZE=K

# personal binaries; highest priority
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# development tools paths
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# macos specific paths
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
    export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
    # resolve python user scripts bin dynamically; avoids hardcoding a specific version
    _py_bin="$(ls -d "$HOME/Library/Python"/*/bin 2>/dev/null | sort -V | tail -1)"
    [[ -n "$_py_bin" ]] && export PYTHON_PATH="$_py_bin" && export PATH="$PATH:$PYTHON_PATH"
    unset _py_bin
fi

# nvm: lazy-load to avoid ~500ms startup cost; sourced on first invocation of
# nvm, node, npm, or npx
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    _load_nvm() {
        unset -f nvm node npm npx _load_nvm
        source "$NVM_DIR/nvm.sh"
        [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
    }
    nvm()  { _load_nvm; nvm "$@"; }
    node() { _load_nvm; node "$@"; }
    npm()  { _load_nvm; npm "$@"; }
    npx()  { _load_nvm; npx "$@"; }
fi

# application specific exports
export HOMEBREW_NO_AUTO_UPDATE=1