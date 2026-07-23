local M = {}

M[1] = {
  "lazyvim/lazyvim",
  -- apply robust terminal‐focused defaults
  opts = {
    ui = {
      winblend = 0,
      pumblend = 0,
      cmdheight = 1,
      ext_popupmenu = false,
    },
    defaults = {
      float = false,
    },
  },
  -- after LazyVim sets up, enforce native TUI behavior
  config = function(_, opts)
    require("lazyvim").setup(opts)

    -- Neovim builtin TUI redraw & performance tweaks
    local o = vim.opt
    o.termguicolors = true -- true‐color in terminal
    o.lazyredraw = true -- skip redraw during macros/scripts
    o.ttimeoutlen = 10 -- faster mapped‐sequence timeout
    o.updatetime = 300 -- fewer CursorHold triggers
    o.redrawtime = 2000 -- more time for complex redraws
    o.scrolloff = 3 -- margin when scrolling
    o.sidescrolloff = 5 -- margin when side‐scrolling
    o.conceallevel = 0 -- disable conceal (e.g. in Markdown)
    o.cursorline = false -- disable full‐line cursor highlight

    -- stable statusline & native popupmenu
    o.laststatus = 2
    o.pumheight = 10
    o.showmode = true
  end,
}

M[2] = { "folke/noice.nvim", enabled = false }
M[3] = { "rcarriga/nvim-notify", enabled = false }

return M
