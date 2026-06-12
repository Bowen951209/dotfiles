return {
	"miikanissi/modus-themes.nvim",
	priority = 1000,
	config = function()
		-- Do not put this in `config/options.lua`,
		-- as it is loaded *before* Lazy.
		vim.cmd.colorscheme("modus")
	end,
}
