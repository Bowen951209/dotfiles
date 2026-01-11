return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
				automatic_enable = {
					exclude = {
						"rust_analyzer",
					},
				},
			})

			-- This prevents `undefined global vim` warnings.
			-- Source - https://stackoverflow.com/questions/79647620/undefined-global-vim
			-- Posted by Jo Totland
			-- Retrieved 2025/11/5, License - CC-BY-SA 4.0
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},
}
