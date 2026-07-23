return {
  "hedyhli/markdown-toc.nvim",
  ft = "markdown", -- Lazy load on markdown filetype
  cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
  opts = {
    {
      toc_list = {
        markers = "*",
        cycle_markers = false,
      },
      indent_size = 2,
      padding_lines = 1,
      fences = {
        enabled = true,
        start_text = "mtoc start",
        end_text = "mtoc end",
      },
      auto_update = {
        enabled = true,
      },
    },
  },
}
