return {
  "nvimdev/dashboard-nvim",
  event = { "VimEnter", "UIEnter" },
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  opts = {
    theme = "doom",
    config = {
      vertical_center = true,
      header = {
        [[                                                    ]],
        [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
        [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
        [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
        [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        [[                                                    ]],
      },
      hide = {
        statusline = false,
      },
    },
  },
  config = function(_, opts)
    require("dashboard").setup(opts)

    -- Track if we've already shown dashboard for this session
    local dashboard_shown = false

    -- Handle opening directories (nvim .)
    vim.api.nvim_create_autocmd("UIEnter", {
      callback = function()
        -- Skip if we've already shown the dashboard
        if dashboard_shown then
          return
        end

        -- Check if nvim was opened with a directory
        if vim.fn.argc(-1) ~= 1 then
          return
        end

        local arg = vim.fn.argv(0)
        local stat = vim.loop.fs_stat(arg)
        if not stat or stat.type ~= "directory" then
          return
        end

        -- Find the non-explorer window with empty buffer
        local wins = vim.api.nvim_list_wins()
        for _, win in ipairs(wins) do
          local bufnr = vim.api.nvim_win_get_buf(win)
          local buftype = vim.bo[bufnr].filetype
          
          -- Skip explorer windows
          if buftype ~= "snacks_explorer" and buftype ~= "neo-tree" then
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local is_empty = #lines == 1 and lines[1] == ""
            
            -- Found the empty buffer window - show dashboard here
            if is_empty and vim.bo[bufnr].buftype == "" then
              dashboard_shown = true
              vim.api.nvim_set_current_win(win)
              require("dashboard"):instance()
              return
            end
          end
        end
      end,
    })
  end,
}
