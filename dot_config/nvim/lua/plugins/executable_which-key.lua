return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>m", group = "markdown" },
        { "<leader>mt", "<cmd>Mtoc<cr>", desc = "Generate/Update TOC" },
        { "<leader>mi", "<cmd>Mtoc insert<cr>", desc = "Insert TOC at cursor" },
        { "<leader>mu", "<cmd>Mtoc update<cr>", desc = "Update existing TOC" },
        { "<leader>md", "<cmd>Mtoc remove<cr>", desc = "Remove TOC" },
        { "<leader>mr", "<cmd>Markview render<cr>", desc = "Re-Render current preview" },
        { "<leader>mp", "<cmd>Markview Enable<cr>", desc = "Enable Markview preview" },
      },
    },
  },
}
