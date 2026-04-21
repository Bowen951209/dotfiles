-- Window movement
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })

-- Resize windows with Ctrl + Arrow keys
vim.keymap.set("n", "<M-h>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<M-l>", "<cmd>vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<M-j>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<M-k>", "<cmd>resize -2<CR>", { silent = true })

-- System Clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+yg_', { desc = "Yank line to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

-- Terminal mappings and helpers
vim.keymap.set("n", "<Leader>tt", ":terminal<CR>", { noremap = true, silent = true, desc = "Open terminal" })
vim.keymap.set(
	"n",
	"<Leader>th",
	":split | terminal<CR>",
	{ noremap = true, silent = true, desc = "Open horizontal terminal" }
)
vim.keymap.set(
	"n",
	"<Leader>tv",
	":vsplit | terminal<CR>",
	{ noremap = true, silent = true, desc = "Open vertical terminal" }
)
vim.keymap.set(
	"t",
	"<Esc><Esc>",
	"<C-\\><C-n>",
	{ noremap = true, silent = true, desc = "Switch to normal mode from terminal mode" }
)

local function close_terminal()
	local buftype = vim.bo.buftype
	if buftype == "terminal" then
		vim.cmd("stopinsert") -- exit terminal mode
		vim.cmd("bd!") -- delete buffer
	end
end
vim.keymap.set("t", "<C-c><C-c>", close_terminal, { noremap = true, silent = true, desc = "Close terminal" })
vim.keymap.set("n", "<C-c><C-c>", close_terminal, { noremap = true, silent = true, desc = "Close terminal" })

-- Inlay Hint toggle
vim.keymap.set("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

-- Gotos
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", function()
	require("telescope.builtin").lsp_references()
end, { desc = "Go to References", nowait = true })

-- Lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename" })

vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Neogit
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })
