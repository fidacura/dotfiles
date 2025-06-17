# ~/.config/zsh/exports.zsh

# development environment variables that were missing
export PYTHON_PATH="$HOME/Library/Python/3.9/bin"
export CLICOLOR=1
export BLOCKSIZE=K

# personal binaries; highest priority
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# development tools paths from original
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# macos specific paths from original
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
    export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
    export PATH="$PATH:$PYTHON_PATH"
fi

# nvm configuration that was missing
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
fi
if [[ -s "$NVM_DIR/bash_completion" ]]; then
    source "$NVM_DIR/bash_completion"
fi

# application specific exports
export HOMEBREW_NO_AUTO_UPDATE=1