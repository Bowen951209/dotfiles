return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({
			integrations = {
				diffview = false,
			},
			mappings = {
				popup = {
					["d"] = false,
				},
			},
		})
	end,
}
