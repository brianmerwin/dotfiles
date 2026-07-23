return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gG", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
      { "<leader>gl", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Log" },
      { "<leader>gc", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit Current File Log" },
    },
    cmd = {
      "LazyGit",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    config = function()
      -- Optional: Configure lazygit integration
      vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize border
      vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
      vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
      vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
      vim.g.lazygit_config_file_path = "" -- custom config file path
    end,
  },

  -- Optional: Add which-key descriptions for better menu display
  -- {
  --   "folke/which-key.nvim",
  --   optional = true,
  --   opts = {
  --     defaults = {
  --       ["<leader>g"] = { name = "+git" },
  --     },
  --   },
  -- },

  -- Optional: Ensure terminal integration works well
  -- {
  --   "akinsho/toggleterm.nvim",
  --   optional = true,
  --   opts = {
  --     -- Ensure lazygit works well with toggleterm if you use it
  --     float_opts = {
  --       border = "curved",
  --     },
  --   },
  -- },
}
