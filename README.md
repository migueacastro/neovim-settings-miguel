# Neovim Configuration

A modular and efficient Neovim setup focused on performance and modern developer workflows.

## Features

- **Modular Design**: Organized structure with automatic plugin loading.
- **LSP & Treesitter**: Automated installation and persistent configuration.
- **Session Management**: Built-in session handling with dashboard integration.
- **Interactive UI**: Stylish dashboard, global statusline, and fuzzy pickers.

## Key Bindings

### General
- `Ctrl + s`: Save file
- `Ctrl + a`: Select all
- `Ctrl + c`: Copy to system clipboard
- `ff`: Format buffer
- `<leader>s`: Search and replace word under cursor
- `<leader>re`: Reload configuration

### Navigation & Splits
- `Tab` / `Shift + Tab`: Cycle buffers
- `<leader>vs`: Vertical split
- `<leader>vh`: Horizontal split
- `C-n`: Toggle file tree
- `-`: Toggle floating file explorer

### Terminal
- `<leader>vt`: Vertical terminal
- `<leader>ht`: Horizontal terminal

### Pickers (Mini.Pick)
- `<leader>pf`: Find files
- `<leader>ps`: Search project (grep)
- `<leader>ph`: Help tags
- `<leader>pk`: Search keymaps
- `<leader>pt`: Select theme (persists)
- `<leader>xx`: Diagnostics

### Sessions
- `<leader>ss`: Save session
- `<leader>sl`: List sessions

## Structure

- `init.lua`: Main entry point
- `lua/pack.lua`: Plugin loader
- `lua/keymaps.lua`: Core mappings
- `lua/options.lua`: Native options
- `lua/startup.lua`: Startup logic
- `lua/commands.lua`: Custom commands/autocmds
- `lua/plugins/`: Individual plugin configurations

## Setup

1. Clone to `~/.config/nvim`
2. Run `:PackUpdate`
3. Restart Neovim
