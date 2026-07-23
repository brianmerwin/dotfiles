-- ~/.config/nvim/lua/plugins/gitleaks-picker.lua
return {
	{
		"folke/snacks.nvim",
		opts = function(_, opts)
			-- Add custom gitleaks picker command
			vim.api.nvim_create_user_command("GitleaksPicker", function()
				local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				local gitleaks_items = {}

				for _, diag in ipairs(diagnostics) do
					if diag.source == "gitleaks" then
						table.insert(gitleaks_items, {
							filename = vim.fn.bufname(diag.bufnr),
							lnum = diag.lnum + 1,
							col = diag.col + 1,
							text = diag.message,
						})
					end
				end

				if #gitleaks_items > 0 then
					Snacks.picker.pick({
						source = "gitleaks",
						items = gitleaks_items,
					})
				else
					vim.notify("No gitleaks issues found")
				end
			end, {})
		end,
	},
}
