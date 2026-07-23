return {
  "lambdalisue/suda.vim",
  event = { "BufReadPre", "BufWritePre" },
  init = function()
    vim.g.suda_smart_edit = 1
  end,
  -- keys = {
  --   -- Dummy prefix to create the “Suda” group under <leader>u
  --   {
  --     lhs = "<leader>W",
  --     desc = " Suda (sudo)",
  --     mode = "n",
  --   },
  --   -- Write with sudo
  --   {
  --     lhs = "<leader>Ww",
  --     rhs = "<cmd>SudaWrite<CR>",
  --     desc = "Write File with sudo",
  --     mode = "n",
  --   },
  --   -- Read with sudo
  --   {
  --     lhs = "<leader>Wr",
  --     rhs = "<cmd>SudaRead<CR>",
  --     desc = "Read File with sudo",
  --     mode = "n",
  --   },
  -- },
}
