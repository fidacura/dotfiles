-- ~/.config/nvim/init.lua
-- main configuration entry point for neovim
-- this is a minimal phase 1 setup for learning

-- set leader key early (space bar)
-- leader key is used for custom shortcuts like <leader>e for file explorer
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- basic editor settings for comfortable coding
-- these make neovim behave more like modern editors
local function setup_editor_basics()
    local options = {
        -- line numbers
        number = true,              -- show line numbers on the left
        relativenumber = true,      -- show relative numbers (helps with movement)
        
        -- indentation (how code is spaced)
        tabstop = 4,               -- how wide a tab character looks
        shiftwidth = 4,            -- how much to indent when you press tab
        expandtab = true,          -- use spaces instead of tab characters
        smartindent = true,        -- automatically indent new lines
        
        -- search behavior
        ignorecase = true,         -- ignore uppercase/lowercase when searching
        smartcase = true,          -- unless you type uppercase letters
        hlsearch = true,           -- highlight search results
        incsearch = true,          -- show results as you type
        
        -- visual improvements
        termguicolors = true,      -- enable full color support
        signcolumn = "yes",        -- always show the column for error/warning icons
        wrap = false,              -- don't wrap long lines
        scrolloff = 8,             -- keep 8 lines visible when scrolling up/down
        
        -- file handling
        backup = false,            -- don't create backup files
        swapfile = false,          -- don't create swap files
        undofile = true,           -- save undo history between sessions
        
        -- responsiveness
        updatetime = 300,          -- faster updates for git signs and diagnostics
        timeoutlen = 500,          -- how long to wait for key combinations
    }
    
    -- apply all the settings
    for setting, value in pairs(options) do
        vim.opt[setting] = value
    end
end

-- essential keyboard shortcuts
-- these are the minimum shortcuts you need to be productive
local function setup_keymaps()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }
    
    -- file operations
    map("n", "<leader>w", ":write<CR>", opts)       -- save file (space + w)
    map("n", "<leader>q", ":quit<CR>", opts)        -- quit (space + q)
    map("n", "<leader>x", ":wq<CR>", opts)          -- save and quit (space + x)
    
    -- clear search highlighting when you press escape
    map("n", "<ESC>", ":nohlsearch<CR>", opts)
    
    -- better window navigation with ctrl + arrow keys
    map("n", "<C-Up>", ":resize +2<CR>", opts)      -- make window taller
    map("n", "<C-Down>", ":resize -2<CR>", opts)    -- make window shorter
    map("n", "<C-Left>", ":vertical resize -2<CR>", opts)  -- make window narrower
    map("n", "<C-Right>", ":vertical resize +2<CR>", opts) -- make window wider
    
    -- keep selection when indenting in visual mode
    map("v", "<", "<gv", opts)     -- indent left and keep selection
    map("v", ">", ">gv", opts)     -- indent right and keep selection
end

-- clipboard configuration
-- this enables copying to/from system clipboard
local function setup_clipboard()
    -- enable system clipboard integration
    vim.opt.clipboard = "unnamedplus"  -- use system clipboard for all operations
    
    -- on macOS, use pbcopy/pbpaste
    if vim.fn.has("macunix") == 1 then
        vim.g.clipboard = {
            name = "macOS-clipboard",
            copy = {
                ["+"] = "pbcopy",
                ["*"] = "pbcopy",
            },
            paste = {
                ["+"] = "pbpaste",
                ["*"] = "pbpaste",
            },
            cache_enabled = 0,
        }
    end
    
    -- clipboard shortcuts
    local opts = { noremap = true, silent = true }
    
    -- copy to clipboard
    vim.keymap.set("v", "<leader>y", '"+y', opts)     -- space+y = copy selection to clipboard
    vim.keymap.set("n", "<leader>yy", '"+yy', opts)   -- space+yy = copy line to clipboard
    
    -- paste from clipboard
    vim.keymap.set("n", "<leader>p", '"+p', opts)     -- space+p = paste from clipboard
    vim.keymap.set("v", "<leader>p", '"+p', opts)     -- space+p = paste from clipboard (visual)
    
    print("Clipboard integration enabled")
end

-- initialize basic settings
setup_editor_basics()
setup_keymaps()
setup_clipboard()

-- load plugins (defined in lua/plugins.lua)
require("plugins")

-- load language-specific settings (defined in lua/languages.lua)
require("languages")