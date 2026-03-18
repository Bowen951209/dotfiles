vim.lsp.enable("tsserver")

vim.lsp.config("tsserver", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript" },
	root_dir = vim.fs.root(0, { "package.json", ".git" }),
	on_attach = on_attach,
	capabilities = capabilities,
})
