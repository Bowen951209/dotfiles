require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

-- The rest of your original init.lua runtime configurations are preserved here.
-- These are executed after lazy.nvim and plugins are registered (same execution order as original).
require("telescope").setup({
	pickers = {
		find_files = {
			find_command = {
				"rg",
				"--files",
				"--hidden",
				"--glob",
				"!**/.git/*",
			},
		},
		live_grep = {
			additional_args = function()
				return {
					"--hidden", -- include hidden files
					"--glob",
					"!**/.git/*", -- exclude .git
				}
			end,
		},
	},
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "Command history" })
vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix list" })

require("nvim-treesitter").setup({
	-- Directory to install parsers and queries to
	install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({ "rust", "javascript", "lua" })

-- highlighting
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust", "javascript", "lua" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- folding and indenting
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.opt.showmode = false
require("lualine").setup({
	options = { theme = "codedark" },
	sections = {
		lualine_x = {
			"cdate",
			{
				"ctime",
				format = "%H:%M",
				fmt = function(str)
					return str .. "  "
				end,
			},
		},
	},
})

vim.opt.termguicolors = true
require("bufferline").setup({})

require("Comment").setup()

require("aerial").setup({
	-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	on_attach = function(bufnr)
		-- Jump forwards/backwards with '{' and '}'
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
})

-- keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
	automatic_enable = {
		exclude = {
			"rust_analyzer",
		},
	},
})

-- This prevent `undefined global vim` warnings.
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

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})

vim.opt.number = true
vim.opt.relativenumber = true

-- InsertEnter/Leave autocmds are handled in config.autocmds (required at top)

-- DAP Configuration for Rust (codelldb)
local dap = require("dap")

-- Configure CodeLLDB adapter
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.has("win32") == 1 and vim.fn.stdpath("data") .. "/mason/bin/codelldb.cmd"
			or vim.fn.stdpath("data") .. "/mason/bin/codelldb",
		args = { "--port", "${port}" },
	},
}

-- Rust Debugging Configuration
dap.configurations.rust = {
	{
		name = "Launch Rust program",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

require("dapui").setup()

local dapui = require("dapui")
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

require("neogit").setup({
	integrations = {
		diffview = true,
	},
})

vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>")

-- Copy to system clipboard (visual mode)
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+yg_', { desc = "Yank line to system clipboard" })

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

-- Inlay hint
vim.keymap.set("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

require("kanagawa").load("dragon")

require("lsp-endhints").setup({
	icons = {
		type = "󰜁 ",
		parameter = "󰏪 ",
		offspec = " ", -- hint kind not defined in official LSP spec
		unknown = " ", -- hint kind is nil
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
	autoEnableHints = true,
})

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
	{ noremap = true, silent = true, desc = "Open vertical terminl" }
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

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })

-- Run Rust "runnables"
vim.keymap.set("n", "<leader>r", ":RustLsp! runnables<CR>", { noremap = true, silent = true, desc = "Rust runnables" })

-- Debug Rust "debuggables"
vim.keymap.set(
	"n",
	"<leader>d",
	":RustLsp! debuggables<CR>",
	{ noremap = true, silent = true, desc = "Rust debuggables" }
)

-- Set default shell to PowerShell
vim.o.shell = "powershell.exe"
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.o.shellquote = ""
vim.o.shellxquote = ""

