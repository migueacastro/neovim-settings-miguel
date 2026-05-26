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
- `fm`: Format buffer
- `<leader>s`: Search and replace word under cursor
- `<leader>re`: Reload configuration

### Navigation
- `Tab` / `Shift + Tab`: Cycle buffers
- `C-n`: Toggle file tree
- `-`: Toggle floating file explorer
- `<leader>pf`: Find files
- `<leader>ps`: Search project (grep)

### Sessions & UI
- `<leader>ss`: Save session
- `<leader>sl`: List sessions
- `<leader>pt`: Select theme (persists on restart)
- `<leader>pk`: Search keymaps

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
