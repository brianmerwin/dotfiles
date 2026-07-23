local opt = vim.opt
opt.cmdheight = 1
opt.scrolloff = 10
opt.errorbells = false
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.encoding = "UTF-8"
opt.termguicolors = true
opt.colorcolumn = "100"
opt.textwidth = 100
opt.formatoptions = "cqnj"
opt.selection = "inclusive"
opt.sessionoptions = "blank,curdir,folds,help,options,tabpages,winsize"
opt.clipboard = "unnamedplus"

-- Added for tmux mouse copy/paste support
opt.mouse = "a"

-- Visual artifact troublshooting
opt.termsync = false
