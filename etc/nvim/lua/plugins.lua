-- ~/.config/nvim/lua/plugins.lua
-- plugin management - enhanced with git, auto-pairs, formatting, and which-key
-- we're using lazy.nvim as our plugin manager

-- bootstrap lazy.nvim installation
-- this automatically downloads the plugin manager if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- plugin specifications
-- each plugin is defined with its name and configuration
local plugins = {
    
    -- colorscheme (makes neovim look nice)
    -- tokyo-night is a popular dark theme with good syntax highlighting
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",           -- darkest variant
                transparent = false,
                terminal_colors = true,
            })
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("catppuccin").setup({
    --             flavour = "mocha",         -- mocha (darkest), macchiato, frappe, latte
    --             background = {
    --                 light = "latte",
    --                 dark = "mocha",
    --             },
    --             transparent_background = false,
    --             show_end_of_buffer = false,
    --             term_colors = true,
    --             dim_inactive = {
    --                 enabled = false,
    --                 shade = "dark",
    --                 percentage = 0.15,
    --             },
    --             integrations = {
    --                 cmp = true,
    --                 gitsigns = true,
    --                 nvimtree = true,
    --                 treesitter = true,
    --                 telescope = true,
    --                 which_key = true,
    --             },
    --         })
    --         vim.cmd([[colorscheme catppuccin-mocha]])
    --     end,
    -- },

    -- icon fix - replace problematic icons with simple text
    -- this fixes the square "?" symbols
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({
                -- use simple ASCII icons instead of nerd font symbols
                override = {
                    zsh = { icon = ">_", color = "#428850", name = "Zsh" },
                    ["README.md"] = { icon = "R", color = "#519aba", name = "Readme" },
                    [".gitignore"] = { icon = "G", color = "#f1502f", name = "GitIgnore" },
                    [".gitmodules"] = { icon = "G", color = "#f1502f", name = "GitModules" },
                    ["package.json"] = { icon = "P", color = "#e8274b", name = "PackageJson" },
                    ["package-lock.json"] = { icon = "P", color = "#e8274b", name = "PackageLockJson" },
                },
                
                -- fallback to simple text icons
                default = true,
                
                -- use color but simple symbols
                color_icons = true,
                
                -- override by file extension
                override_by_extension = {
                    ["log"] = { icon = "L", color = "#81e043", name = "Log" },
                    ["js"] = { icon = "JS", color = "#cbcb41", name = "JavaScript" },
                    ["ts"] = { icon = "TS", color = "#519aba", name = "TypeScript" },
                    ["html"] = { icon = "H", color = "#e34c26", name = "Html" },
                    ["css"] = { icon = "C", color = "#563d7c", name = "Css" },
                    ["scss"] = { icon = "S", color = "#f55385", name = "Scss" },
                    ["py"] = { icon = "PY", color = "#519aba", name = "Python" },
                    ["rs"] = { icon = "RS", color = "#dea584", name = "Rust" },
                    ["c"] = { icon = "C", color = "#599eff", name = "C" },
                    ["cpp"] = { icon = "C++", color = "#f34b7d", name = "Cpp" },
                    ["lua"] = { icon = "LUA", color = "#51a0cf", name = "Lua" },
                    ["json"] = { icon = "J", color = "#cbcb41", name = "Json" },
                    ["md"] = { icon = "MD", color = "#519aba", name = "Markdown" },
                },
            })
        end,
    },
    
    -- file explorer (like vscode's file tree on the left)
    -- nvim-tree creates a sidebar showing your project folders and files
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons", -- icons for different file types
        config = function()
            -- disable netrw (vim's built-in file explorer) to avoid conflicts
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            
            require("nvim-tree").setup({
                -- tree appearance
                view = {
                    width = 30,        -- how wide the sidebar is
                    side = "left",     -- put it on the left side
                },
                
                -- what files to show
                filters = {
                    dotfiles = false,  -- show hidden files (like .gitignore)
                    custom = {         -- hide these folders
                        "node_modules", 
                        ".git",
                        "__pycache__"
                    },
                },
                
                -- enable icons and git status
                renderer = {
                    icons = {
                        show = {
                            file = true,     -- show file type icons
                            folder = true,   -- show folder icons
                            git = true,      -- show git status icons
                        },
                    },
                },
                
                -- git integration in file tree
                git = {
                    enable = true,       -- show git status
                    ignore = false,      -- show ignored files
                },
            })
            
            -- keyboard shortcuts for file tree
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)     -- space+e to toggle tree
            vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", opts)  -- space+ef to find current file
        end,
    },
    
    -- fuzzy finder (like ctrl+p in vscode)
    -- telescope lets you quickly find and open files
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required dependency
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    -- search settings
                    file_ignore_patterns = {    -- don't search in these folders
                        "node_modules/",
                        ".git/",
                        "__pycache__/",
                        "target/",
                    },
                    
                    -- layout settings
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.6,
                        },
                    },
                    sorting_strategy = "ascending",
                },
                
                pickers = {
                    find_files = {
                        hidden = true,  -- include hidden files in search
                    },
                },
            })
            
            -- keyboard shortcuts for telescope
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)   -- space+ff = find files
            vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", opts)    -- space+fg = search in files
            vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts)      -- space+fb = find open buffers
            vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", opts)    -- space+fh = search help
            
            -- git-related telescope shortcuts (works with gitsigns)
            vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>", opts)  -- space+gc = git commits
            vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", opts) -- space+gb = git branches
            vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", opts)   -- space+gs = git status
        end,
    },
    
    -- syntax highlighting (makes code colorful and readable)
    -- treesitter understands your code structure for better highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",  -- update parsers when plugin updates
        config = function()
            require("nvim-treesitter.configs").setup({
                -- languages to install syntax highlighting for
                ensure_installed = {
                    "lua",         -- neovim configuration
                    "html",        -- web development
                    "css",         -- styling
                    "scss",        -- sass/scss
                    "javascript",  -- javascript (includes jsx support)
                    "typescript",  -- typescript (includes tsx support)
                    "python",      -- python
                    "rust",        -- rust
                    "c",           -- c programming
                    "json",        -- json files
                    "markdown",    -- documentation
                    "bash",        -- shell scripts
                },
                
                -- enable syntax highlighting
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,  -- disable old highlighting
                },
                
                -- enable smart indentation
                indent = {
                    enable = true,
                },
                
                -- automatically install missing parsers
                auto_install = true,
            })
        end,
    },
    
    -- html auto-closing tags (like vscode)
    -- automatically closes html tags when you type <p> → <p></p>
    {
        "windwp/nvim-ts-autotag",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-ts-autotag").setup({
                -- enable auto-closing for these file types
                filetypes = {
                    "html", "javascript", "typescript", "javascriptreact", "typescriptreact",
                    "svelte", "vue", "tsx", "jsx", "rescript", "xml", "php", "markdown",
                    "astro", "glimmer", "handlebars", "hbs"
                },
                
                -- skip these tags (self-closing)
                skip_tags = {
                    "area", "base", "br", "col", "command", "embed", "hr", "img", "slot",
                    "input", "keygen", "link", "meta", "param", "source", "track", "wbr",
                    "menuitem"
                },
                
                -- enable for jsx/tsx
                enable_rename = true,      -- rename paired tags
                enable_close = true,       -- auto-close tags
                enable_close_on_slash = true, -- close with </
            })
            
            print("HTML auto-tags loaded - <p> will auto-close to <p></p>")
        end,
    },
    
    -- git integration (shows changes in the gutter, stage/unstage hunks)
    -- gitsigns adds git status to the editor and provides git operations
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                -- signs in the gutter (left side of line numbers)
                signs = {
                    add          = { text = "+" },     -- added lines
                    change       = { text = "~" },     -- modified lines
                    delete       = { text = "_" },     -- deleted lines
                    topdelete    = { text = "‾" },     -- deleted lines at top
                    changedelete = { text = "~" },     -- changed and deleted
                    untracked    = { text = "┆" },     -- new files
                },
                
                -- show signs in number column
                signcolumn = true,
                
                -- enable line highlighting for current changes
                current_line_blame = false,  -- don't show blame by default
                
                -- attach keybindings when gitsigns loads for a file
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local opts = { noremap = true, silent = true, buffer = bufnr }
                    
                    -- navigation between changes (hunks)
                    vim.keymap.set("n", "]c", function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end, { expr = true, buffer = bufnr, desc = "Next git change" })
                    
                    vim.keymap.set("n", "[c", function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end, { expr = true, buffer = bufnr, desc = "Previous git change" })
                    
                    -- git operations
                    vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)         -- space+hs = stage this change
                    vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)         -- space+hr = discard this change
                    vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts)       -- space+hS = stage whole file
                    vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts)       -- space+hR = discard all changes in file
                    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)       -- space+hp = preview change
                    vim.keymap.set("n", "<leader>hb", gs.blame_line, opts)         -- space+hb = show git blame
                    vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, opts) -- space+tb = toggle blame display
                    
                    -- stage/reset selected lines in visual mode
                    vim.keymap.set("v", "<leader>hs", function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, opts)
                    vim.keymap.set("v", "<leader>hr", function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, opts)
                end
            })
            
            print("Git integration loaded - see changes in gutter, use ]c/[c to navigate")
        end,
    },
    
    -- auto-pairs (automatically close brackets, quotes, etc.)
    -- saves time and prevents syntax errors
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",  -- only load when entering insert mode
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,  -- use treesitter for better detection
                
                -- language-specific rules
                ts_config = {
                    lua = {"string", "source"},                    -- disable in lua strings
                    javascript = {"string", "template_string"},    -- disable in js strings/templates
                    typescript = {"string", "template_string"},    -- disable in ts strings/templates
                },
                
                -- when to disable autopairs
                disable_filetype = { "TelescopePrompt" },  -- don't interfere with telescope
                disable_in_macro = false,                  -- work in macros
                disable_in_visualblock = false,            -- work in visual block mode
                disable_in_replace_mode = true,            -- don't interfere with replace mode
                
                -- behavior settings
                enable_moveright = true,       -- move cursor right when closing pair
                enable_afterquote = true,      -- add pairs after quotes
                enable_check_bracket_line = true,  -- check if bracket already exists on line
                enable_bracket_in_quote = true,    -- add brackets inside quotes
                break_undo = true,             -- break undo sequence on pair insertion
                
                -- fast wrap feature (surround selection with pairs)
                fast_wrap = {
                    map = "<M-e>",             -- alt+e to trigger fast wrap
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "Search",
                    highlight_grey = "Comment",
                },
            })
            
            print("Auto-pairs loaded - brackets/quotes will close automatically")
        end,
    },
    
    -- code formatting (prettier for js, black for python, etc.)
    -- ensures consistent code style across your projects
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                -- formatters for each language
                formatters_by_ft = {
                    -- web development
                    html = { "prettier" },
                    css = { "prettier" },
                    scss = { "prettier" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    json = { "prettier" },
                    
                    -- python
                    python = { "black" },      -- black is the most popular python formatter
                    
                    -- rust (rustfmt is built into rust)
                    rust = { "rustfmt" },
                    
                    -- c/c++
                    c = { "clang_format" },
                    cpp = { "clang_format" },
                    
                    -- other
                    lua = { "stylua" },        -- lua formatter
                    markdown = { "prettier" },
                    bash = { "shfmt" },
                },
                
                -- format on save (automatic formatting)
                format_on_save = {
                    timeout_ms = 500,          -- don't wait too long
                    lsp_fallback = true,       -- use lsp formatter if conform formatter not available
                },
                
                -- format command for manual formatting
                formatters = {
                    -- customize specific formatters if needed
                    prettier = {
                        prepend_args = { "--tab-width", "2" },  -- use 2 spaces for web files
                    },
                    shfmt = {
                        prepend_args = { "-i", "2" },           -- use 2 spaces for shell scripts
                    },
                },
            })
            
            -- manual format keybinding (in case auto-format doesn't work)
            vim.keymap.set({ "n", "v" }, "<leader>mp", function()
                require("conform").format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                })
            end, { desc = "Format file or selection" })
            
            print("Code formatting loaded - files will auto-format on save")
        end,
    },
    
    -- which-key (shows available shortcuts when you press space)
    -- helps you learn and discover keybindings
    {
        "folke/which-key.nvim",
        event = "VeryLazy",  -- load after startup for better performance
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300  -- how long to wait before showing which-key
            
            local wk = require("which-key")
            
            -- setup which-key with updated configuration format
            wk.setup({
                -- appearance
                preset = "classic",          -- use classic preset
                delay = 300,                 -- delay before showing which-key
                
                -- window settings
                win = {
                    border = "rounded",      -- rounded corners
                    padding = { 1, 2 },      -- padding inside window
                },
                
                -- layout settings
                layout = {
                    height = { min = 4, max = 25 }, -- min and max height
                    width = { min = 20, max = 50 }, -- min and max width
                    spacing = 3,                    -- spacing between columns
                    align = "left",                 -- align hint text
                },
                
                -- behavior
                show_help = true,               -- show help message
                show_keys = true,               -- show the currently pressed key
            })
            
            -- register key descriptions using the new format
            wk.add({
                -- space key groups
                { "<leader>f", group = "find (telescope)" },
                { "<leader>e", group = "explorer" },
                { "<leader>g", group = "git" },
                { "<leader>h", group = "git hunks" },
                { "<leader>c", group = "code" },
                { "<leader>t", group = "toggle" },
                { "<leader>m", group = "format" },
                { "<leader>r", group = "run" },
                { "<leader>n", group = "npm/node" },
                { "<leader>p", group = "python" },
                
                -- individual key descriptions
                { "<leader>w", desc = "Save file" },
                { "<leader>q", desc = "Quit" },
                { "<leader>x", desc = "Save and quit" },
                
                -- git navigation
                { "]c", desc = "Next git change" },
                { "[c", desc = "Previous git change" },
                
                -- lsp navigation
                { "gd", desc = "Go to definition" },
                { "gr", desc = "Find references" },
                { "K", desc = "Show documentation" },
                { "]d", desc = "Next diagnostic" },
                { "[d", desc = "Previous diagnostic" },
            })
            
            print("Which-key loaded - press Space to see available shortcuts")
        end,
    },
    
    -- lsp (language server protocol) - provides intelligent code features
    -- this gives you error checking, autocomplete, go-to-definition, etc.
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- mason manages language servers (automatic installation)
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            
            -- autocompletion engine
            "hrsh7th/nvim-cmp",         -- main completion plugin
            "hrsh7th/cmp-nvim-lsp",     -- lsp completion source
            "hrsh7th/cmp-buffer",       -- buffer completion source
            "hrsh7th/cmp-path",         -- file path completion
            
            -- snippets (code templates)
            "L3MON4D3/LuaSnip",         -- snippet engine
            "saadparwaiz1/cmp_luasnip", -- snippet completion source
        },
        config = function()
            -- setup mason (language server installer)
            require("mason").setup({
                ui = {
                    border = "rounded",  -- nice rounded corners
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
            
            -- automatically install these language servers
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",        -- lua (for neovim config)
                    "html",          -- html
                    "cssls",         -- css
                    "pyright",       -- python
                    "rust_analyzer", -- rust
                    "clangd",        -- c/c++
                    "ts_ls",         -- typescript/javascript (updated name)
                },
                automatic_installation = true,
            })
            
            -- setup autocompletion
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                
                -- completion menu appearance
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                
                -- keyboard mappings for completion
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_next_item(),     -- ctrl+k = next item
                    ["<C-j>"] = cmp.mapping.select_prev_item(),     -- ctrl+j = previous item
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),        -- scroll documentation
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),         -- force completion
                    ["<C-e>"] = cmp.mapping.abort(),                -- close completion
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- enter = accept
                }),
                
                -- completion sources (where suggestions come from)
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },    -- from language server
                    { name = "luasnip" },     -- from snippets
                    { name = "buffer" },      -- from current file
                    { name = "path" },        -- file paths
                }),
                
                -- customize completion menu appearance
                formatting = {
                    format = function(entry, vim_item)
                        -- add source name to completion items
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            })
            
            -- integrate autopairs with completion
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            
            -- setup language servers
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            -- function to set up keybindings when lsp attaches to a file
            local function on_attach(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                
                -- navigation keybindings
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)      -- go to definition
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)      -- find references
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)            -- show documentation
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)  -- go to implementation
                
                -- code actions
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)  -- space+ca = code actions
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)       -- space+rn = rename
                
                -- diagnostics (errors/warnings)
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)  -- space+e = show error
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)          -- [d = previous error
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)          -- ]d = next error
                vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts) -- space+dl = list all errors
                
                -- formatting (manual trigger)
                vim.keymap.set("n", "<leader>mf", function()
                    vim.lsp.buf.format({ async = true })
                end, opts) -- space+mf = format with lsp
            end
            
            -- configure each language server
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } }, -- recognize 'vim' global
                            workspace = { 
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                        },
                    },
                },
                html = {},
                cssls = {},
                pyright = {},
                rust_analyzer = {},
                clangd = {},
                ts_ls = {},  -- updated from tsserver
            }
            
            -- apply configuration to each server
            for server, config in pairs(servers) do
                config.capabilities = capabilities
                config.on_attach = on_attach
                lspconfig[server].setup(config)
            end
            
            print("LSP loaded - intelligent code features available")
        end,
    },
}

-- initialize lazy.nvim with our plugins
require("lazy").setup(plugins, {
    ui = {
        border = "rounded",  -- rounded corners for plugin manager ui
    },
    checker = {
        enabled = true,      -- check for plugin updates
        notify = false,      -- don't spam notifications
    },
    change_detection = {
        enabled = true,      -- automatically reload config changes
        notify = false,      -- don't notify about every change
    },
})