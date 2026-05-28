# Neovim Configuration

A modular and efficient Neovim setup focused on performance and modern developer workflows.

## Core Features

- Modular Architecture: Automatic plugin configuration loading from the plugins directory.
- Automated Environment: Self-installing LSP servers and Treesitter parsers with persistent configuration.
- Intelligent UI: Centered dashboard, global statusline, and smart sidebar management.
- Development Tools: Full Emmet support, autotags, and automatic Python virtual environment detection.

## Key Bindings

### General Editing
- Ctrl + s: Save file
- Ctrl + a: Select all text
- Ctrl + c: Copy to system clipboard
- fm: Format current buffer
- <leader>s: Search and replace word under cursor
- <leader>re: Reload configuration

### Navigation and Windows
- Tab / Shift + Tab: Cycle buffers
- <leader>vs: Vertical split
- <leader>vh: Horizontal split
- C-n: Toggle file tree
- -: Toggle floating file explorer
- <leader>vt: Vertical terminal
- <leader>ht: Horizontal terminal

### Snippets and Completion
- Ctrl + j: Expand snippet / Confirm completion
- Ctrl + l: Jump to next placeholder
- Ctrl + h: Jump to previous placeholder
- Enter: Confirm completion if menu is visible

### Interactive Pickers
- <leader>pf: Find files
- <leader>ps: Project grep
- <leader>ph: Help tags
- <leader>pk: Search active keymaps
- <leader>pt: Select and persist theme
- <leader>xx: List diagnostics

### Session Management
- <leader>ss: Save current session (SSave)
- <leader>sl: List and load sessions (SList)
- Dashboard: Direct access to recent sessions on startup

## Project Intelligence

### Language Specifics
- Svelte and TypeScript: Optimized using vtsls for fast imports and reliable type checking.
- Python: Automatic detection and activation of .venv environments in project roots.
- Web Development: Native Emmet abbreviations and automatic HTML/JSX tag management.

### Management Commands
- :LspInstall {name}: Installs and permanently adds an LSP to the configuration.
- :TSInstallPersist {name}: Installs and permanently adds a Treesitter parser.
- :SDelete {name}: Removes a saved session.

## File Structure

- init.lua: Entry point
- lua/pack.lua: Plugin management and auto-loader
- lua/keymaps.lua: Core key bindings
- lua/options.lua: Native Neovim settings
- lua/startup.lua: Startup and auto-opening logic
- lua/commands.lua: Event handling and custom commands
- lua/plugins/: Directory for individual plugin configurations

## Installation

1. Clone to ~/.config/nvim
2. Open Neovim
3. Run :PackUpdate to install dependencies
4. Restart Neovim
