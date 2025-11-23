-- Toggle relative number on InsertEnter/InsertLeave (same behavior as original)
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.opt.relativenumber = true
	end,
})

-- highlighting
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust", "javascript", "lua" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
