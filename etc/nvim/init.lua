-- ~/.config/nvim/init.lua

-- disable vi compatibility for modern features
vim.opt.compatible = false

-- line numbers and display
vim.opt.number = true          -- show line numbers
vim.opt.relativenumber = true  -- show relative line numbers for easier navigation
vim.opt.cursorline = true      -- highlight current line
vim.opt.wrap = false           -- don't wrap long lines
vim.opt.scrolloff = 8          -- keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8      -- keep 8 columns visible left/right of cursor

-- indentation and tabs
vim.opt.expandtab = true       -- use spaces instead of tabs
vim.opt.tabstop = 2            -- tab width
vim.opt.shiftwidth = 2         -- indent width
vim.opt.softtabstop = 2        -- tab width in insert mode
vim.opt.autoindent = true      -- copy indent from current line
vim.opt.smartindent = true     -- smart autoindenting

-- search behavior
vim.opt.ignorecase = true      -- ignore case in search
vim.opt.smartcase = true       -- case sensitive if uppercase used
vim.opt.incsearch = true       -- show matches while typing
vim.opt.hlsearch = true        -- highlight search results

-- file handling
vim.opt.backup = false         -- don't create backup files
vim.opt.writebackup = false    -- don't create backup before writing
vim.opt.swapfile = false       -- don't create swap files
vim.opt.undofile = true        -- enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"  -- undo directory

-- visual settings
vim.opt.termguicolors = true   -- enable 24-bit colors
vim.opt.background = "dark"    -- dark background
vim.opt.signcolumn = "yes"     -- always show sign column
vim.opt.colorcolumn = "80"     -- show column at 80 characters

-- behavior
vim.opt.mouse = "a"            -- enable mouse support
vim.opt.clipboard = "unnamedplus"  -- use system clipboard
vim.opt.splitbelow = true      -- horizontal splits below
vim.opt.splitright = true     -- vertical splits to the right
vim.opt.updatetime = 250       -- faster completion and diagnostics

-- ================================================================
-- KEY MAPPINGS (BASIC AND BEGINNER-FRIENDLY)
-- ================================================================

-- set leader key to space (most common choice)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- clear search highlighting with escape
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- better window navigation using jkl; layout (ergonomic home row)
vim.keymap.set("n", "<C-j>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-k>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-l>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-;>", "<C-w>l", { desc = "Move to right window" })

-- window resizing
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- better indenting (keeps selection after indent)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ================================================================
-- navigation remappings (adapted for jkl; layout)
-- ================================================================

-- remap basic movement to jkl; (home row ergonomics)
vim.keymap.set({"n", "v"}, "j", "h", { desc = "Move left" })
vim.keymap.set({"n", "v"}, "k", "j", { desc = "Move down" })
vim.keymap.set({"n", "v"}, "l", "k", { desc = "Move up" })
vim.keymap.set({"n", "v"}, ";", "l", { desc = "Move right" })

-- remap displaced keys to logical alternatives
vim.keymap.set({"n", "v"}, "h", ";", { desc = "Repeat last f/F/t/T" })
vim.keymap.set("n", "H", "J", { desc = "Join lines" })

-- move selected lines up/down - adapted for jkl; layout  
vim.keymap.set("v", "L", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- save file
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- quit
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Force quit all" })

-- better page scrolling (keeps cursor centered) - adapted for jkl;
vim.keymap.set("n", "<C-k>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-l>", "<C-u>zz", { desc = "Scroll up and center" })

-- ================================================================
-- plugin management (using lazy.nvim)
-- ================================================================

-- bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugin specifications
local plugins = {
  -- ================================================================
  -- colorscheme (themes)
  -- ================================================================
  
  -- vim one dark theme (primary choice)
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "dark",           -- dark, darker, cool, deep, warm, warmer, light
        transparent = false,      -- show/hide background
        term_colors = true,       -- change terminal color as per the selected theme style
        ending_tildes = false,    -- show the end-of-buffer tildes
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
        
        -- toggle theme style with keymap
        toggle_style_key = nil,   -- keymap to toggle theme style
        toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'}, -- list of styles to toggle between
        
        -- change code style
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },
        
        -- lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },
        
        -- custom highlights
        colors = {}, -- override default colors
        highlights = {}, -- override highlight groups
      })
      require("onedark").load()
    end,
  },

  -- tokyo night theme (alternative - uncomment to use)
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("tokyonight").setup({
  --       style = "night",        -- storm, moon, night, day
  --       transparent = false,    -- disable setting background
  --       terminal_colors = true, -- terminal colors
  --       styles = {
  --         comments = { italic = true },
  --         keywords = { italic = true },
  --         functions = {},
  --         variables = {},
  --       },
  --     })
  --     vim.cmd.colorscheme("tokyonight")
  --   end,
  -- },

  -- ================================================================
  -- file explorer (nvim-tree)
  -- ================================================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
      
      -- toggle file explorer
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    end,
  },

  -- ================================================================
  -- fuzzy finder (telescope)
  -- ================================================================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
        },
      })
      
      -- telescope keymaps
      vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
    end,
  },

  -- ================================================================
  -- status line (lualine)
  -- ================================================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "onedark",  -- changed from tokyonight to onedark
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
      })
    end,
  },

  -- ================================================================
  -- buffer management (bufferline)
  -- ================================================================
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = true,
          show_close_icon = true,
          separator_style = "thin",
        },
      })
      
      -- buffer navigation
      vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })
    end,
  },

  -- ================================================================
  -- syntax highlighting and code parsing (treesitter)
  -- ================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "javascript", "typescript", 
          "python", "rust", "html", "css", "scss", "json", 
          "markdown", "markdown_inline", "bash"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- ================================================================
  -- autocompletion (nvim-cmp)
  -- ================================================================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- ================================================================
  -- language server protocol (LSP) configuration
  -- ================================================================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- mason setup (automatic lsp server installation)
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "tsserver", 
          "pyright",
          "rust_analyzer",  -- added rust support
          "html",
          "cssls",
          "jsonls",
          "marksman",       -- added markdown language server
        },
        automatic_installation = true,
      })

      -- lsp keymaps (adapted for jkl; layout)
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "L", vim.lsp.buf.hover, opts)  -- changed from K to L
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end

      -- setup language servers
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      })

      -- typescript/javascript
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- python
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- html
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- css
      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- json
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- rust
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      })

      -- markdown
      lspconfig.marksman.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
  },

  -- ================================================================
  -- useful utilities (autopairs, comments, etc.)
  -- ================================================================

  -- auto pairs for brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- comment toggling
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- surround text with quotes, brackets, etc.
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        indent = {
          char = "┊",
        },
        scope = {
          enabled = false,
        },
      })
    end,
  },

  -- ================================================================
  -- enhanced code editing experience
  -- ================================================================

  -- better error/diagnostic display
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        mode = "workspace_diagnostics",
      })
      
      vim.keymap.set("n", "<leader>xx", ":Trouble<CR>", { desc = "Toggle diagnostics" })
      vim.keymap.set("n", "<leader>xw", ":Trouble workspace_diagnostics<CR>", { desc = "Workspace diagnostics" })
      vim.keymap.set("n", "<leader>xd", ":Trouble document_diagnostics<CR>", { desc = "Document diagnostics" })
    end,
  },

  -- git integration (like vscode git panel)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 300,
        },
      })
      
      vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame line" })
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
      vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
    end,
  },

  -- enhanced markdown support for writing
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
      }
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_page_title = "「${name}」"
      
      vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown preview" })
      vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop markdown preview" })
    end,
  },

  -- code formatting (prettier, black, rustfmt, etc.)
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          rust = { "rustfmt" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
      
      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range" })
    end,
  },

  -- enhanced code navigation and references
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  -- project-wide search and replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("spectre").setup()
      
      vim.keymap.set("n", "<leader>S", ':lua require("spectre").toggle()<CR>', { desc = "Toggle search/replace" })
      vim.keymap.set("n", "<leader>sw", ':lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Search current word" })
    end,
  },
}

-- ================================================================
-- load plugins using lazy.nvim
-- ================================================================
require("lazy").setup(plugins, {
  ui = {
    border = "rounded",
  },
})

-- ================================================================
-- autocommands for various tasks
-- ================================================================

-- highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TrimWhitespace", {}),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursor", {}),
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") and vim.bo.filetype ~= "commit" then
      vim.normal("g`\"")
    end
  end,
})

-- enhanced mail editing for neomutt integration
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("MailSettings", {}),
  pattern = "mail",
  callback = function()
    vim.opt_local.textwidth = 72      -- proper email line width
    vim.opt_local.wrap = true         -- wrap long lines
    vim.opt_local.linebreak = true    -- break at word boundaries
    vim.opt_local.spell = true        -- enable spell checking
    vim.opt_local.spelllang = "en_us" -- spell check language
    
    -- start in insert mode for quick composing
    vim.cmd("startinsert")
    
    -- jump to first empty line (after headers)
    vim.defer_fn(function()
      vim.cmd("normal! gg/^$/")
      vim.cmd("normal! o")
    end, 100)
  end,
})

-- enhanced markdown writing settings
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("MarkdownSettings", {}),
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true         -- wrap long lines
    vim.opt_local.linebreak = true    -- break at word boundaries
    vim.opt_local.spell = true        -- enable spell checking
    vim.opt_local.spelllang = "en_us" -- spell check language
    vim.opt_local.conceallevel = 2    -- hide markdown syntax for cleaner writing
    vim.opt_local.textwidth = 0       -- no hard line breaks
  end,
})

-- ================================================================
-- key mappings for common actions
-- ================================================================

-- :help - shows help
-- <leader>ff - find files
-- <leader>fg - search in files  
-- <leader>e - toggle file explorer
-- gd - go to definition
-- L - show documentation (remapped from K)
-- <leader>ca - code actions
-- <leader>cf - format code
-- <leader>xx - toggle diagnostics
-- <leader>mp - markdown preview
-- <leader>S - search and replace
-- gcc - comment/uncomment line
-- Tab/Shift-Tab - next/previous buffer
-- <leader>w - save file
-- <leader>q - quit
-- Movement: j=left, k=down, l=up, ;=right

print("🚀 Neovim configuration loaded with jkl; navigation! Full coding setup with Rust, TypeScript, Python, and Markdown support ready!")