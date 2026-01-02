return {
	"nvim-telescope/telescope.nvim",
	version = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
			},
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
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
			aerial = {
				-- Set the width of the first two columns (the second
				-- is relevant only when show_columns is set to 'both')
				col1_width = 4,
				col2_width = 30,
				-- How to format the symbols
				format_symbol = function(symbol_path, filetype)
					if filetype == "json" or filetype == "yaml" then
						return table.concat(symbol_path, ".")
					else
						return symbol_path[#symbol_path]
					end
				end,
				-- Available modes: symbols, lines, both
				show_columns = "both",
			},
		})

		require("telescope").load_extension("ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })
		vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "Command history" })
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix list" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope Diagnostics" })
	end,
}
