vim.g.mapleader = " "

-- Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next result centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev result centered" })

-- Editing
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste keep yank" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete void" })

-- Indentation
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Utils
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search/Replace word" })
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<Tab>", "<cmd>bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bp<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
vim.keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy all" })
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Completion confirmation
vim.keymap.set("i", "<CR>", function()
    if vim.fn.pumvisible() ~= 0 then
        return "<C-y>"
    end
    return "<CR>"
end, { expr = true, replace_keycodes = true, desc = "Confirm completion" })

vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make executable" })
vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Reload config" })

-- Splits
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>vh", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Terminal
vim.keymap.set("n", "<leader>vt", "<cmd>vsplit | term<cr>a", { desc = "Vertical terminal" })
vim.keymap.set("n", "<leader>ht", "<cmd>split | term<cr>a", { desc = "Horizontal terminal" })

-- Navegación rápida al principio y final del archivo
vim.keymap.set("n", "<leader>e", "G", { desc = "Go to end of file" })
vim.keymap.set("n", "<leader>b", "gg", { desc = "Go to beginning of file" })

-- Cerrar buffers (Bufferline y nativo)
vim.keymap.set("n", "<leader>c", "<cmd>BufferLinePickClose<CR>", { desc = "Close current buffer" })

-- Copiar la ruta relativa del archivo (ej: src/main.lua)
vim.keymap.set("n", "<leader>cp", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    print("Relative path copied: " .. path)
end, { desc = "Copy relative path" })

-- Copiar la ruta absoluta del archivo (ej: /home/usuario/proyecto/src/main.lua)
vim.keymap.set("n", "<leader>cP", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("Absolute path copied: " .. path)
end, { desc = "Copy absolute path" })

-- Commands
vim.api.nvim_create_user_command("Keymaps", function()
    require('mini.extra').pickers.keymaps()
end, { desc = "Show keymaps" })

-- Comentar/Descomentar código
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment block" })


