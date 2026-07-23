return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  opts = {
    preview = {
      enable = false,
      enable_hybrid_mode = false,
      modes = { "n", "i", "c" },
      hybrid_modes = { "n", "i", "c" },
    },
    experimental = {
      prefer_nvim = true,
      file_open_command = "edit",
    },
  },
}
