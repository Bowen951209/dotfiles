# Neovim Configuration

This is a modular Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Directory Structure

```
.config/nvim/
├── init.lua                 # Entry point - loads config modules and sets diagnostics
└── lua/
    ├── config/              # Core configuration modules
    │   ├── options.lua      # Editor options (tabs, numbers, leader key, etc.)
    │   ├── keymaps.lua      # Global keymaps (window movement, clipboard, terminal)
    │   ├── autocmds.lua     # Autocommands (format on save, relative number toggle)
    │   └── lazy.lua         # lazy.nvim bootstrap and setup
    └── plugins/             # Plugin specifications (one file per plugin/group)
        ├── init.lua         # Empty table (required by lazy.nvim import)
        ├── telescope.lua    # Fuzzy finder
        ├── treesitter.lua   # Syntax highlighting
        ├── lualine.lua      # Status line
        ├── bufferline.lua   # Buffer tabs
        ├── aerial.lua       # Code outline
        ├── mason.lua        # LSP installer + mason-lspconfig
        ├── conform.lua      # Code formatter
        ├── cmp.lua          # Autocompletion
        ├── copilot.lua      # GitHub Copilot
        ├── dap.lua          # Debug adapter protocol
        ├── neogit.lua       # Git integration
        ├── kanagawa.lua     # Colorscheme
        ├── lsp-endhints.lua # LSP end hints
        ├── trouble.lua      # Diagnostics list
        ├── which-key.lua    # Keybinding hints
        ├── rustaceanvim.lua # Rust development
        ├── comment.lua      # Code commenting
        └── misc.lua         # Other plugins (fidget, gitsigns, surround, etc.)
```

## How It Works

1. **`init.lua`** is the entry point that loads:
   - `config.options` - Editor settings
   - `config.keymaps` - Global key mappings
   - `config.autocmds` - Auto commands
   - `config.lazy` - Plugin manager setup

2. **`config/lazy.lua`** bootstraps lazy.nvim and uses `{ import = "plugins" }` to automatically load all plugin specs from the `lua/plugins/` folder.

3. Each file in **`lua/plugins/`** returns a table (plugin spec) that lazy.nvim processes.

## Maintenance Guide

### Adding a New Plugin

1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/myplugin.lua`)

2. Return a plugin spec table:

```lua
return {
    "author/plugin-name",
    -- Optional: lazy loading
    event = "VeryLazy",  -- or "BufRead", "InsertEnter", etc.
    cmd = "CommandName", -- load when command is used
    ft = "filetype",     -- load for specific filetypes
    
    -- Optional: dependencies
    dependencies = { "other/plugin" },
    
    -- Optional: configuration
    config = function()
        require("plugin-name").setup({
            -- plugin options here
        })
        
        -- Plugin-specific keymaps (if any)
        vim.keymap.set("n", "<leader>x", ":PluginCommand<CR>", { desc = "Description" })
    end,
    
    -- Alternative: use opts for simple setup (calls setup() automatically)
    opts = {
        -- plugin options here
    },
}
```

3. Restart Neovim or run `:Lazy` to install

### Adding Global Keymaps

Add keymaps to `lua/config/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>xx", function()
    -- your action
end, { desc = "Description for which-key" })
```

### Adding Plugin-Specific Keymaps

Add keymaps inside the plugin's `config` function in its spec file. This keeps plugin-related keymaps co-located with the plugin configuration.

### Adding Editor Options

Add options to `lua/config/options.lua`:

```lua
vim.opt.some_option = value
```

### Adding Autocommands

Add autocommands to `lua/config/autocmds.lua`:

```lua
vim.api.nvim_create_autocmd("EventName", {
    pattern = "*.ext",
    callback = function()
        -- your action
    end,
})
```

### Modifying Existing Plugins

1. Find the plugin file in `lua/plugins/`
2. Edit the configuration in the `config` function or `opts` table
3. Restart Neovim or run `:Lazy reload plugin-name`

## Key Files Reference

| File | Purpose |
|------|---------|
| `config/options.lua` | Leader key, tabs, line numbers, terminal shell |
| `config/keymaps.lua` | Window navigation, clipboard, terminal, LSP gotos |
| `config/autocmds.lua` | Format on save, relative number toggle, Neogit navigation |
| `plugins/telescope.lua` | `<leader>f*` keymaps for fuzzy finding |
| `plugins/trouble.lua` | `<leader>x*` keymaps for diagnostics |
| `plugins/aerial.lua` | `<leader>a` for code outline, `{`/`}` for navigation |
| `plugins/dap.lua` | `<leader>b` for breakpoints |
| `plugins/rustaceanvim.lua` | `<leader>r` for runnables, `<leader>d` for debuggables |

## Commands

- `:Lazy` - Open lazy.nvim UI (install, update, clean plugins)
- `:Mason` - Manage LSP servers, formatters, linters
- `:checkhealth` - Diagnose configuration issues
