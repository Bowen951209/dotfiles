return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "archibate/lualine-time" },
	config = function()
		require("lualine").setup({
			options = { theme = "codedark" },
			sections = {
				lualine_x = {
					"cdate",
					{
						"ctime",
						format = "%H:%M",
						fmt = function(str)
							return str .. "  "
						end,
					},
				},
			},
		})
	end,
}
