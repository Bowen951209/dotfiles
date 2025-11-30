require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

-- Diagnostics configuration
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})
