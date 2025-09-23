-- ~/.config/nvim/lua/languages.lua
-- language-specific settings and shortcuts
-- this file customizes neovim behavior for different programming languages

-- html/css/scss configuration
-- settings for web development files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "scss", "sass" },
    callback = function()
        -- use 2 spaces for indentation (web standard)
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
        
        -- enable line wrapping for long html lines
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true  -- break at word boundaries
        
        print("Web development mode activated (2-space indentation)")
    end,
})

-- javascript/typescript configuration
-- settings for javascript and typescript files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    callback = function()
        -- use 2 spaces for indentation (js standard)
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
        
        -- keyboard shortcuts for javascript development
        local opts = { noremap = true, silent = true, buffer = true }
        
        -- check if this is a node.js project (has package.json)
        local package_json = vim.fn.findfile("package.json", ".;")
        if package_json ~= "" then
            -- node.js shortcuts
            vim.keymap.set("n", "<leader>rn", ":!node %<CR>", opts)           -- space+rn = run with node
            vim.keymap.set("n", "<leader>ni", ":!npm install<CR>", opts)      -- space+ni = npm install
            vim.keymap.set("n", "<leader>ns", ":!npm start<CR>", opts)        -- space+ns = npm start
            vim.keymap.set("n", "<leader>nt", ":!npm test<CR>", opts)         -- space+nt = npm test
            
            print("Node.js project detected - npm shortcuts available")
        end
        
        -- shortcut to add console.log
        vim.keymap.set("n", "<leader>cl", "oconsole.log();<ESC>hi", opts)  -- space+cl = add console.log
        
        print("JavaScript mode activated (2-space indentation)")
    end,
})

-- python configuration
-- settings for python files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        -- use 4 spaces for indentation (python standard)
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
        
        -- python line length guide (pep8 standard)
        vim.opt_local.colorcolumn = "88"  -- black formatter standard
        
        -- keyboard shortcuts for python development
        local opts = { noremap = true, silent = true, buffer = true }
        
        vim.keymap.set("n", "<leader>rp", ":!python %<CR>", opts)         -- space+rp = run python file
        vim.keymap.set("n", "<leader>pt", ":!pytest<CR>", opts)          -- space+pt = run tests
        
        -- check for common python frameworks
        local manage_py = vim.fn.findfile("manage.py", ".;")
        local app_py = vim.fn.findfile("app.py", ".;")
        
        if manage_py ~= "" then
            -- django shortcuts
            vim.keymap.set("n", "<leader>dm", ":!python manage.py migrate<CR>", opts)     -- space+dm = migrate
            vim.keymap.set("n", "<leader>dr", ":!python manage.py runserver<CR>", opts)   -- space+dr = runserver
            print("Django project detected - django shortcuts available")
        elseif app_py ~= "" then
            -- flask shortcuts
            vim.keymap.set("n", "<leader>fr", ":!flask run<CR>", opts)                    -- space+fr = flask run
            print("Flask project detected - flask shortcuts available")
        end
        
        print("Python mode activated (4-space indentation)")
    end,
})

-- rust configuration
-- settings for rust files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        -- use 4 spaces for indentation (rust standard)
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
        
        -- rust line length guide
        vim.opt_local.colorcolumn = "100"
        
        -- keyboard shortcuts for rust development
        local opts = { noremap = true, silent = true, buffer = true }
        
        vim.keymap.set("n", "<leader>cr", ":!cargo run<CR>", opts)        -- space+cr = cargo run
        vim.keymap.set("n", "<leader>cb", ":!cargo build<CR>", opts)      -- space+cb = cargo build
        vim.keymap.set("n", "<leader>ct", ":!cargo test<CR>", opts)       -- space+ct = cargo test
        vim.keymap.set("n", "<leader>cc", ":!cargo check<CR>", opts)      -- space+cc = cargo check
        
        print("Rust mode activated (4-space indentation, cargo shortcuts)")
    end,
})

-- c/c++ configuration
-- settings for c and c++ files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h", "hpp" },
    callback = function()
        -- use 4 spaces for indentation
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
        
        -- c line length guide
        vim.opt_local.colorcolumn = "80"
        
        -- keyboard shortcuts for c development
        local opts = { noremap = true, silent = true, buffer = true }
        
        -- simple compile and run (adjust as needed for your projects)
        vim.keymap.set("n", "<leader>cc", ":!gcc % -o %:r && ./%:r<CR>", opts)  -- space+cc = compile and run
        
        print("C/C++ mode activated (4-space indentation)")
    end,
})

-- markdown configuration
-- settings for documentation files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        -- enable line wrapping for reading
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        
        -- enable spell checking
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
        
        -- markdown line length
        vim.opt_local.textwidth = 80
        vim.opt_local.colorcolumn = "80"
        
        print("Markdown mode activated (spell check enabled)")
    end,
})

-- json configuration
-- settings for json files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
        -- use 2 spaces for json indentation
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
        
        -- keyboard shortcut to format json
        local opts = { noremap = true, silent = true, buffer = true }
        vim.keymap.set("n", "<leader>jf", ":%!jq .<CR>", opts)  -- space+jf = format json (requires jq)
        
        print("JSON mode activated (2-space indentation)")
    end,
})

-- automatically reload this file when you save it
-- this helps when you're experimenting with language settings
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*/nvim/lua/languages.lua",
    callback = function()
        vim.cmd("source %")
        print("Language configuration reloaded!")
    end,
})