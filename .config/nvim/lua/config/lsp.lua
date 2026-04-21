vim.lsp.enable("tsserver")

vim.lsp.config("tsserver", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript" },
	root_dir = vim.fs.root(0, { "package.json", ".git" }),
	on_attach = on_attach,
	capabilities = capabilities,
})

-- This prevents `undefined global vim` warnings.
-- Source - https://stackoverflow.com/questions/79647620/undefined-global-vim
-- Posted by Jo Totland
-- Retrieved 2025/11/5, License - CC-BY-SA 4.0
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
