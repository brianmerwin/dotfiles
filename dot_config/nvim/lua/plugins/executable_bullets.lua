return {
  "bullets-vim/bullets.vim",
  ft = { "markdown", "text", "gitcommit", "scratch" },
  config = function()
    -- Disable default mappings (we'll use custom ones)
    vim.g.bullets_set_mappings = 0

    -- Enable auto-renumbering
    vim.g.bullets_renumber_on_change = 1

    -- Enable nested checkboxes
    vim.g.bullets_nested_checkboxes = 1

    -- Enabled file types
    vim.g.bullets_enabled_file_types = {
      "markdown",
      "text",
      "gitcommit",
      "scratch",
    }
  end,
}
