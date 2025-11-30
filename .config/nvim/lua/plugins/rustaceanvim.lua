return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	lazy = false,
	ft = { "rust" },
	keys = {
		{
			"<leader>r",
			":RustLsp! runnables<CR>",
			desc = "Rust runnables",
			ft = "rust",
		},
		{
			"<leader>d",
			":RustLsp! debuggables<CR>",
			desc = "Rust debuggables",
			ft = "rust",
		},
	},
}
