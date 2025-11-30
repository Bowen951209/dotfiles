return {
	"nvim-telescope/telescope.nvim",
	version = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--glob",
						"!**/.git/*",
					},
				},
				live_grep = {
					additional_args = function()
						return {
							"--hidden",
							"--glob",
							"!**/.git/*",
						}
					end,
				},
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })
		vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "Command history" })
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix list" })
	end,
}
