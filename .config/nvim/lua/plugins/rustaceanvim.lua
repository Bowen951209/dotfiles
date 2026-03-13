return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	lazy = false,
	ft = { "rust" },
	keys = {
		{
			"<leader>rn",
			":RustLsp! runnables<CR>",
			desc = "Run previous runnables",
			ft = "rust",
		},
		{
			"<leader>rt",
			":RustLsp! testables<CR>",
			desc = "Run previous testables",
			ft = "rust",
		},
		{
			"<leader>d",
			":RustLsp! debuggables<CR>",
			desc = "Run previous debuggables",
			ft = "rust",
		},
	},
}
