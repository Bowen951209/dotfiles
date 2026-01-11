require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

-- Diagnostics configuration
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = false,
	update_in_insert = false,
})
