return {
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = false, -- Disable the archived plugin
	},

	-- Native tree-sitter configuration for Neovim 0.12+
	{
		"nvim-treesitter/nvim-treesitter",
		build = false, -- Don't build anything, use native
		config = function()
			-- Install parsers using native vim.treesitter.language.add()
			local parsers = {
				"awk",
				"bash",
				"caddyfile",
				"dockerfile",
				"go",
				"hcl",
				"helm",
				"html",
				"ini",
				"javascript",
				"jq",
				"json",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"nginx",
				"proto",
				"python",
				"query",
				"regex",
				"requirements",
				"rust",
				"sql",
				"ssh_config",
				"systemd",
				"terraform",
				"toml",
				"vim",
				"yaml",
			}

			for _, parser in ipairs(parsers) do
				vim.treesitter.language.add(parser)
			end

			-- Enable highlighting (now native)
			vim.treesitter.start()
		end,
	},
}
