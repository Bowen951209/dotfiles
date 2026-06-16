return {
	"keaising/im-select.nvim",
	config = function()
		local is_win = vim.fn.has("win32") == 1
		local is_wsl = vim.fn.has("wsl") == 1

		if is_win or is_wsl then
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
}
