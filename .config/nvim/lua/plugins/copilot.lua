return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		dependencies = {
			{
				"copilotlsp-nvim/copilot-lsp",
				config = function()
					vim.g.copilot_nes_debounce = 500
				end,
			},
		},
		config = function()
			require("copilot").setup({})
		end,
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			nes = { enabled = true },
			filetypes = {
				rust = true,
				lua = true,
				["*"] = false,
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
