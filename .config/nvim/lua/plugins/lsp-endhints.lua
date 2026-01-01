return {
	"chrisgrieser/nvim-lsp-endhints",
	event = "LspAttach",
	config = function()
		require("lsp-endhints").setup({
			icons = {
				type = "󰜁 ",
				parameter = "󰏪 ",
				offspec = " ",
				unknown = " ",
			},
			label = {
				truncateAtChars = 20,
				padding = 1,
				marginLeft = 0,
				sameKindSeparator = ", ",
			},
			extmark = {
				priority = 50,
			},
			autoEnableHints = false,
		})
	end,
}
