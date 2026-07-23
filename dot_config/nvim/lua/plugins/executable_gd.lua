-- Force gd command uses default behavior and does not display telescope pop up
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            {
              "gd",
              function()
                vim.lsp.buf.definition({
                  loclist = false,
                  on_list = function(options)
                    if options.items and #options.items > 0 then
                      local item = options.items[1]
                      if item.filename then
                        vim.cmd("edit " .. item.filename)
                      end
                      vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
                    end
                  end,
                })
              end,
              desc = "Goto Definition",
              has = "definition",
            },
          },
        },
      },
    },
  },
}
