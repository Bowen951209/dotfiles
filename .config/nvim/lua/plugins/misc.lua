-- Miscellaneous plugins that don't need complex configuration
return {
	{ "j-hui/fidget.nvim", opts = {} },
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"keaising/im-select.nvim",
		config = function()
			local is_win = vim.fn.has("win32") == 1
			local is_wsl = vim.fn.has("wsl") == 1

			if is_win or is_wsl then
				require("im_select").setup({
					default_im_select = 1033,
					default_command = "im-select.exe",
				})
			else
				require("im_select").setup({
					default_im_select = "keyboard-us",
					default_command = "fcitx5-remote",
				})
			end
		end,
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
}
