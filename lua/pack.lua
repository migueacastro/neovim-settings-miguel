vim.pack.add({
        "https://github.com/bluz71/vim-moonfly-colors",
        "https://github.com/catppuccin/nvim",
        "https://github.com/folke/tokyonight.nvim",
        "https://github.com/rebelot/kanagawa.nvim",
        "https://github.com/rose-pine/neovim",
        "https://github.com/nvim-mini/mini.nvim",
        "https://github.com/nvim-mini/mini.nvim",
        "https://github.com/rafamadriz/friendly-snippets",
        { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
        "https://github.com/neovim/nvim-lspconfig",
        "https://github.com/mason-org/mason.nvim",
        "https://github.com/tpope/vim-fugitive",
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-tree/nvim-tree.lua",
        "https://github.com/nvim-tree/nvim-web-devicons",
        "https://github.com/nvim-lualine/lualine.nvim",
        "https://github.com/akinsho/bufferline.nvim",
        "https://github.com/nvim-telescope/telescope.nvim",
        "https://github.com/m4xshen/autoclose.nvim",
        "https://github.com/jedrzejboczar/possession.nvim",
        "https://github.com/windwp/nvim-ts-autotag",
        "https://github.com/ThePrimeagen/vim-be-good",

})

-- Autoload all files in lua/plugins/
local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local files = vim.fn.readdir(plugins_dir)

for _, file in ipairs(files) do
  if file:match("%.lua$") then
    local module_name = "plugins." .. file:sub(1, -5)
    local ok, err = pcall(require, module_name)
    if not ok then
      vim.notify("Error loading " .. module_name .. ": " .. err, vim.log.levels.ERROR)
    end
  end
end
