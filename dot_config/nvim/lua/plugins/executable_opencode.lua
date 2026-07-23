return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    "folke/snacks.nvim", -- Required dependency for opencode.nvim
  },
  config = function()
    -- Configure opencode via global variable (not setup function)
    vim.g.opencode_opts = {
      -- Any plugin-specific options can go here
    }

    -- Required for reload functionality
    vim.o.autoread = true

    -- Normal mode OpenCode mappings (avoiding Ctrl+a/x conflicts)
    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true, mode = "plan" })
    end, { desc = "Ask OpenCode" })

    vim.keymap.set({ "n", "x" }, "<leader>ox", function()
      require("opencode").select()
    end, { desc = "Execute OpenCode action…" })

    vim.keymap.set({ "n", "t" }, "<leader>ot", function()
      require("opencode").toggle()
    end, { desc = "Toggle OpenCode" })

    -- Session management
    vim.keymap.set("n", "<leader>on", function()
      require("opencode").command("session.new")
    end, { desc = "New OpenCode Session" })

    vim.keymap.set("n", "<leader>oc", function()
      require("opencode").prompt("continue")
    end, { desc = "Continue OpenCode Session" })

    vim.keymap.set("n", "<leader>os", function()
      require("opencode").command("session.clear")
    end, { desc = "Clear OpenCode Session" })

    vim.keymap.set("n", "<leader>op", function()
      require("opencode").prompt("project")
    end, { desc = "OpenCode Project Context" })

    -- Visual mode specific mappings
    vim.keymap.set("x", "<leader>oe", function()
      require("opencode").prompt("explain @this")
    end, { desc = "Explain selection" })

    vim.keymap.set("x", "<leader>or", function()
      require("opencode").prompt("refactor @this")
    end, { desc = "Refactor selection" })

    vim.keymap.set("x", "<leader>od", function()
      require("opencode").prompt("debug @this")
    end, { desc = "Debug selection" })

    vim.keymap.set("x", "<leader>of", function()
      require("opencode").prompt("fix @this")
    end, { desc = "Find bugs in selection" })

    -- Which-key integration for discoverability
    local wk = require("which-key")

    -- Normal mode which-key mappings
    wk.add({
      { "<leader>o", group = "OpenCode" },
      { "<leader>oa", desc = "Ask OpenCode", mode = { "n", "x" } },
      { "<leader>ox", desc = "Execute action…", mode = { "n", "x" } },
      { "<leader>ot", desc = "Toggle OpenCode", mode = { "n", "t" } },
      { "<leader>on", desc = "New Session", mode = "n" },
      { "<leader>oc", desc = "Continue Session", mode = "n" },
      { "<leader>os", desc = "Clear Session", mode = "n" },
      { "<leader>op", desc = "Project Context", mode = "n" },
    })

    -- Visual mode which-key mappings
    wk.add({
      { "<leader>o", group = "OpenCode", mode = "x" },
      { "<leader>oe", desc = "Explain selection", mode = "x" },
      { "<leader>or", desc = "Refactor selection", mode = "x" },
      { "<leader>od", desc = "Debug selection", mode = "x" },
      { "<leader>of", desc = "Find bugs in selection", mode = "x" },
    })
  end,
}

