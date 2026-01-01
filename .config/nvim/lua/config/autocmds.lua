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

-- Neogit commit navigation keymaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = "NeogitCommitView", -- Trigger only in the commit details split
	callback = function()
		-- Helper function to handle context switching and navigation
		local function move_in_log(direction)
			-- 1. Switch focus to the Log view (left window)
			vim.cmd("wincmd h")

			-- 2. Move cursor physically (using normal! to bypass mappings)
			if direction == "next" then
				vim.cmd("normal! j")
			else
				vim.cmd("normal! k")
			end

			-- 3. Simulate 'Enter' to trigger Neogit's load action
			-- Note: We intentionally use 'normal' (without !) to trigger the plugin's <CR> mapping
			vim.cmd("normal \r")

			-- 4. Switch focus back to the Commit View (right window)
			vim.cmd("wincmd l")
		end

		-- Keymap: Jump to next commit using ]c
		vim.keymap.set("n", "]c", function()
			move_in_log("next")
		end, {
			buffer = true,
			silent = true,
			nowait = true,
			desc = "Neogit: Next Commit",
		})

		-- Keymap: Jump to previous commit using [c
		vim.keymap.set("n", "[c", function()
			move_in_log("prev")
		end, {
			buffer = true,
			silent = true,
			nowait = true,
			desc = "Neogit: Previous Commit",
		})
	end,
})
