require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
require("config.lsp")

-- Diagnostics configuration
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = false,
	update_in_insert = false,
})
