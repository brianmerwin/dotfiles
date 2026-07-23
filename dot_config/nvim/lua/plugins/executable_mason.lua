return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Configuration languages
        "ansiblels", -- Ansible Language Server
        "bashls", -- Bash Language Server
        "dockerls", -- Dockerfile Language Server
        "groovyls", -- Groovy Language Server (Jenkins)
        "helm_ls", -- Helm Language Server
        "html", -- HTML LS
        "jsonls", -- JSON LS
        "terraformls", -- Terraform LS
        "yamlls", -- YAML LS
        "pyright", -- Python Language Server
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Linters
        -- "ansible-lint", -- Ansible linter
        "hadolint", -- Dockerfile linter
        "npm-groovy-lint", -- Groovy/Jenkins linter
        "ruff", -- Python linter
        "shellcheck", -- Shell linter

        -- Formatters
        "jq", -- JSON formatter
        "shfmt", -- Shell formatter
        "stylua", -- Lua formatter

        -- Debug Adapters (DAP)
        "bash-debug-adapter", -- Bash debug adapter
        "debugpy", -- Python debug adapter
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-org/mason-lspconfig.nvim" },
    opts = {
      inlay_hints = {
        exclude = { "vue", "python" },
      },
      servers = {
        pyright = {
          on_attach = function(client, bufnr)
            -- Disable all pyright diagnostics
            vim.diagnostic.enable(false, { bufnr = bufnr, ns = vim.lsp.diagnostic.get_namespace(client.id) })
          end,
          settings = {
            pyright = {
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                typeCheckingMode = "off",
              },
            },
          },
        },
        ruff = {},
      },
    },
  },

  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        signature = {
          auto_open = {
            enabled = true,
          },
        },
      },
    },
  },
}
