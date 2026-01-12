return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			prompts = {
				RewriteEnglish = {
					prompt = "Improve the English grammar and clarity of the selected text.",
					mapping = "<leader>ce",
					description = "Rewrite selected text to clear, correct English",
				},
			},
		},
	},
}
