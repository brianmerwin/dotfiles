-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<esc>", { silent = true, noremap = true })
vim.keymap.set("i", "<S-Tab>", "<C-d>", { silent = true, noremap = true })
--- Disable paste buffer window
vim.keymap.set("c", "q:", "", { noremap = true, silent = true })
--- Clear trailing whitespace with <leader>cw
vim.keymap.set("n", "<Leader>cw", ":%s/[[:space:]]\\+$//g<CR>:nohlsearch<CR>", { desc = "Remove trailing whitespace" })
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "LSP Documentation Pop-Up" })

-- Comment toggle with Ctrl+/ (uses ts-comments.nvim via native Neovim commenting)
vim.keymap.set("n", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set("n", "<C-_>", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set("v", "<C-/>", "gc", { desc = "Toggle comment", remap = true })
vim.keymap.set("v", "<C-_>", "gc", { desc = "Toggle comment", remap = true })
vim.keymap.set("i", "<C-/>", "<Esc>gcca", { desc = "Toggle comment", remap = true })
vim.keymap.set("i", "<C-_>", "<Esc>gcca", { desc = "Toggle comment", remap = true })

vim.keymap.set("n", "<leader>br", ":e!<CR>", { desc = "Reload buffer" })

-- In visual mode, paste over selection without yanking it
vim.keymap.set("v", "p", [["_dP]], { desc = "Paste over selection without overwriting register" })

vim.keymap.set(
  "n",
  "vil",
  "vg_",
  { noremap = true, silent = true, desc = "Visual: cursor->last non-blank character on line" }
)
vim.keymap.set(
  "v",
  "vil",
  "g_",
  { noremap = true, silent = true, desc = "Extend selection->last non-blank character on line" }
)

-- ============================================================================
-- Markdown & Bullets Keymaps
-- ============================================================================

local wk = require("which-key")

-- Helper function to safely execute commands only in markdown files
local function safe_markdown_cmd(cmd)
  return function()
    if vim.bo.filetype == "markdown" then
      vim.cmd(cmd)
    end
  end
end

-- Helper function to safely execute TOC commands only in markdown files
local function safe_toc_cmd(action)
  return function()
    if vim.bo.filetype == "markdown" then
      vim.cmd("Mtoc " .. action)
    end
  end
end

-- TOC Operations keymaps (uppercase)
vim.keymap.set("n", "<leader>mti", safe_toc_cmd("insert"), { desc = "Insert TOC" })
vim.keymap.set("n", "<leader>mtu", safe_toc_cmd("update"), { desc = "Update TOC" })

-- Markview Core Operations keymaps (uppercase)
vim.keymap.set("n", "<leader>mm", safe_markdown_cmd("Markview toggle"), { desc = "Toggle Markview" })
vim.keymap.set("n", "<leader>mR", safe_markdown_cmd("Markview Render"), { desc = "Force Render All" })
vim.keymap.set("n", "<leader>mh", safe_markdown_cmd("Markview HybridToggle"), { desc = "Toggle Hybrid Mode" })
vim.keymap.set("n", "<leader>ms", safe_markdown_cmd("Markview splitToggle"), { desc = "Toggle Splitview" })

-- Bullets.vim keymaps (lowercase)
vim.keymap.set("n", "<leader>mbx", "<Plug>(bullets-toggle-checkbox)", { desc = "Toggle Checkbox" })
vim.keymap.set("n", "<leader>mbr", "<Plug>(bullets-renumber)", { desc = "Renumber Bullets" })
vim.keymap.set("v", "<leader>mbr", "<Plug>(bullets-renumber)", { desc = "Renumber Bullets" })
vim.keymap.set("n", "<leader>mbn", "<Plug>(bullets-newline)", { desc = "New Bullet" })
vim.keymap.set("n", "<leader>mbc", function()
  if vim.bo.filetype == "markdown" then
    local pos = vim.api.nvim_win_get_cursor(0)
    local row, col = pos[1], pos[2]
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""

    -- Insert "- [ ] " at cursor position
    local before = line:sub(1, col)
    local after = line:sub(col + 1)
    local new_line = before .. "- [ ] " .. after

    vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
    vim.api.nvim_win_set_cursor(0, { row, col + 6 }) -- Move cursor after checkbox
  end
end, { desc = "Insert Checkbox" })

-- Helper functions to get Markview state for dynamic icons
local function get_markview_state()
  if vim.bo.filetype ~= "markdown" then
    return { enable = false, hybrid_mode = false }
  end

  local state = require("markview.state")
  local buffer = vim.api.nvim_get_current_buf()
  local buf_state = state.get_buffer_state(buffer, false)

  return buf_state or { enable = false, hybrid_mode = false }
end

local function get_markview_icon()
  local state = get_markview_state()
  return state.enable and " " or " "
end

local function get_hybrid_mode_icon()
  local state = get_markview_state()
  return state.hybrid_mode and " " or " "
end

local function get_splitview_icon()
  local state = require("markview.state")
  local split_buf = state.get_splitview_source()
  return split_buf and " " or " "
end

-- Which-key configuration
wk.add({
  { "<leader>m", group = "Markdown" },
  { "<leader>mt", group = "TOC" },
  { "<leader>mb", group = "Bullets" },
  -- TOC Operations
  { "<leader>mti", desc = "Insert TOC" },
  { "<leader>mtu", desc = "Update TOC" },
  -- Markview Operations with dynamic status icons
  { "<leader>mm", icon = get_markview_icon, desc = "Toggle Markview" },
  { "<leader>mR", desc = "Force Render All" },
  { "<leader>mh", icon = get_hybrid_mode_icon, desc = "Toggle Hybrid Mode" },
  { "<leader>ms", icon = get_splitview_icon, desc = "Toggle Splitview" },
  -- Bullets Operations
  { "<leader>mbx", desc = "Toggle Checkbox", mode = { "n" } },
  { "<leader>mbr", desc = "Renumber Bullets", mode = { "n", "v" } },
  { "<leader>mbn", desc = "New Bullet", mode = { "n" } },
  { "<leader>mbc", desc = "Insert Checkbox", mode = { "n" } },
})
