-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable word wrapping after saving the file
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    vim.opt_local.wrap = false
  end,
})
-- Prevent mini.pairs from triggering when entering triple-quote
-- characters in python as docstrings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("i", '"""', '"""', { buffer = true })
    -- vim.keymap.set("i", "'''", "'''", { buffer = true })
  end,
})

vim.api.nvim_create_augroup("SessionManagement", { clear = true })

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = "SessionManagement",
  callback = function()
    vim.cmd("mksession! ~/.config/nvim/session.vim")
  end,
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, noremap = true, desc = "Goto Definition" })

-- Stop adding new line comments after two new lines.
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "*",
--   callback = function()
--     vim.keymap.set("i", "<CR>", function()
--       -- 1. Strip the “%s” from commentstring to get just the leader
--       local leader = vim.bo.commentstring:gsub("%%s", "")
--       -- 2. Get the text of the current line
--       local line = vim.api.nvim_get_current_line()
--       -- 3. If it’s only optional whitespace + leader + optional whitespace…
--       if line:match("^%s*" .. vim.pesc(leader) .. "%s*$") then
--         -- …send <C-u> to clear it
--         return vim.api.nvim_replace_termcodes("<C-u><leader>cw0", true, false, true)
--       end
--       -- Otherwise behave like a normal Enter
--       return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
--     end, { expr = true, buffer = true, silent = true })
--   end,
-- })
--
--
--

-- Disable linting errors / warnings while performing git merges
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
      if line:match("^<<<<<<<") or line:match("^=======") or line:match("^>>>>>>>") then
        vim.diagnostic.enable(false, { bufnr = 0 })
        return
      end
    end
  end,
})

-- Chezmoi integration
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
  callback = function(ev)
    local bufnr = ev.buf
    local edit_watch = function()
      require("chezmoi.commands.__edit").watch(bufnr)
    end
    vim.schedule(edit_watch)
  end,
})

-- Jenkinsfile detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*Jenkinsfile*",
  callback = function()
    vim.bo.filetype = "groovy"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Jenkinsfile
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "Jenkinsfile",
  callback = function()
    vim.bo.filetype = "groovy"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- YAML files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.yml,*.yaml",
  callback = function()
    vim.bo.filetype = "yaml"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Ansible YAML files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/playbooks/*.yml", "*/roles/*/tasks/*.yml", "*/ansible/*.yml", "playbook.yml", "site.yml" },
  callback = function()
    vim.bo.filetype = "yaml.ansible"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Python files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.py",
  callback = function()
    vim.bo.filetype = "python"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- PowerShell scripts
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ps1", "*.psm1", "*.psd1" },
  callback = function()
    vim.bo.filetype = "ps1"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Bash shell scripts
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.sh", ".bashrc", ".bash_profile", ".bash_aliases" },
  callback = function()
    vim.bo.filetype = "sh"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Dockerfiles
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Dockerfile", "*.dockerfile", "Dockerfile.*" },
  callback = function()
    vim.bo.filetype = "dockerfile"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Lua files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.lua",
  callback = function()
    vim.bo.filetype = "lua"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- JSON files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.json", "*.jsonc" },
  callback = function()
    vim.bo.filetype = "json"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- TOML files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.toml",
  callback = function()
    vim.bo.filetype = "toml"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Terraform files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.bo.filetype = "terraform"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Makefile
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Makefile", "makefile", "*.mk" },
  callback = function()
    vim.bo.filetype = "make"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = false -- Makefiles REQUIRE tabs
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Nginx config
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "nginx.conf", "*/nginx/*.conf", "*/sites-available/*", "*/sites-enabled/*" },
  callback = function()
    vim.bo.filetype = "nginx"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Apache config
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "httpd.conf", "apache2.conf", "*.conf" },
  callback = function()
    vim.bo.filetype = "apache"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- XML files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.xml",
  callback = function()
    vim.bo.filetype = "xml"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Markdown files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "*.markdown" },
  callback = function()
    vim.bo.filetype = "markdown"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Go files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.go",
  callback = function()
    vim.bo.filetype = "go"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = false -- Go uses tabs
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- JavaScript/TypeScript files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- CSS/SCSS files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.css", "*.scss", "*.sass" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- SQL files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.sql",
  callback = function()
    vim.bo.filetype = "sql"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Ruby files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.rb", "Rakefile", "Gemfile" },
  callback = function()
    vim.bo.filetype = "ruby"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- Rust files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.rs",
  callback = function()
    vim.bo.filetype = "rust"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- .env files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env", "*.env", ".env.*" },
  callback = function()
    vim.bo.filetype = "sh"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})

-- INI files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ini", ".editorconfig", "php.ini", "pip.conf" },
  callback = function()
    vim.bo.filetype = "dosini"
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})
