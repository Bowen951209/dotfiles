-- Miscellaneous plugins that don't need complex configuration
return {
	{ "j-hui/fidget.nvim", opts = {} },
	{ "lewis6991/gitsigns.nvim" },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_method = "latexmk"
		end,
	},
	{
		"keaising/im-select.nvim",
		config = function()
			if vim.fn.has("win32") == 1 then
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
